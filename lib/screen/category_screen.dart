import 'package:eshop/constant/constant.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/category_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:eshop/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'search/search_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const String route = "/category_screen";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categoryList = [];
  List<City> cityList = [];
  int intialId = 0;
  ScrollController _categoryScrollController = new ScrollController();
  int limit = 50;
  bool isLoaded = false;
  String cityId = "";
  String categoryId = "";
  String _selectedCity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategoryList(1, limit);

    Provider.of<CityProvider>(context, listen: false).fetchCityList(1, limit);

    _categoryScrollController.addListener(() {
      if (_categoryScrollController.position.pixels ==
          _categoryScrollController.position.maxScrollExtent) {
        limit += 5;
        Provider.of<CategoryProvider>(context, listen: false)
            .fetchCategoryList(1, limit);
        getAllCity(1, 100);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    categoryList = Provider.of<CategoryProvider>(context).categoryList;
    cityList = Provider.of<CityProvider>(context).cityList;

    return FutureBuilder(
        future: fetchSupplier(categoryId, cityId, 1, 20),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('No Data available');
            case ConnectionState.waiting:
              return Scaffold(
                appBar: AppBar(
                  title: Text("Suppliers"),
                ),
                drawer: mainDrawer(),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else {
                var supplierList = snapshot.data;
                return buildScaffold(snapshot, supplierList);
              }
          }
        });
  }

  Scaffold buildScaffold(AsyncSnapshot snapshot, supplierList) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.of(context).getString('supplier')),
        actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              }),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child,
              color: Colors.red,
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigator.of(context).pushNamed(CartScreen.routesName);
                }),
          ),
        
        ],
      ),
      drawer: mainDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // alignment: Alignment.centerRight,
                    child: DropdownButton(
                        hint: Text("المدينه"),
                        value: _selectedCity,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCity = newValue;
                            cityId = cityList
                                    .firstWhere(
                                        (city) => (city.name == _selectedCity))
                                    .id
                                    .toString() ??
                                "";
                          });
                        },
                        items: cityList
                            .map(
                              (city) => DropdownMenuItem(
                                value: city.name,
                                child: Text(city.name ?? ""),
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print("object");
                        Navigator.pushNamed(context, ProductScreen.route,
                            arguments: {
                              "supplierId": supplierList[index].id.toString(),
                              "categoryId": categoryId
                            });
                      },
                      leading: supplierList[index].imagePath == null
                          ? Text("")
                          : Container(
                              width: 50,
                              height: 50,
                              child: CachedNetworkImage(
                                imageUrl:
                                    imagePath + supplierList[index].imagePath,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                      title: Text(supplierList[index].name),
                      subtitle: Text(supplierList[index].categoryName ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _categoryScrollController.dispose();
  }

  Widget mainDrawer() {
    return Drawer(
      child: Container(
        color: primaryColor,
        child: ListView.builder(
          controller: _categoryScrollController,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  categoryId = categoryList[index].id.toString();
                });
              },
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              title: Text(
                categoryList[index].name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}
