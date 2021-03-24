import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/category_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/provider/announcement_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/images_provider.dart';
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
  List<AnnouncementData> announcementList = [];
  List<ImageData> imageList = [];
  int intialId = 0;
  ScrollController _categoryScrollController = new ScrollController();
  int limit = 50;
  bool isLoaded = false;
  String cityId = "0";
  String categoryId = "0";
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
    Provider.of<Cart>(context,listen: false).fetchCartList();
    Provider.of<CityProvider>(context, listen: false).fetchCityList(1, limit);
    Provider.of<AnnouncementProvider>(context, listen: false)
        .fetchAnnouncementList();
    Provider.of<ImagesProvider>(context, listen: false).fetchImageList();
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
    announcementList =
        Provider.of<AnnouncementProvider>(context).announcementList;
    imageList = Provider.of<ImagesProvider>(context).imagesList;
    return FutureBuilder(
        future: fetchSupplier(categoryId, cityId, 1, 20),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('No Data available');
            case ConnectionState.waiting:
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.cover,
                    height: kToolbarHeight,
                  ),
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
        // centerTitle: true,
        title: Image.asset(
          'assets/images/app_logo.png',
          fit: BoxFit.cover,
          height: kToolbarHeight,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              }),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.cartItems.length.toString()??"0.0",
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
          child: ListView(
            children: [
              buildAnnouncementSlider(),
              buildImagesSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // alignment: Alignment.centerRight,
                    child: DropdownButton(
                        hint: Text("اختر المدينه"),
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
              GridView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: snapshot.data.length,

                physics: NeverScrollableScrollPhysics(),

                ///
                shrinkWrap: true,

                ///
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("object");
                      Navigator.pushNamed(context, ProductScreen.route,
                          arguments: {
                            "supplierId": supplierList[index].id.toString(),
                            "categoryId": categoryId
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70.0,
                            width: 65.0,
                            child: CachedNetworkImage(
                              imageUrl:
                                  imagePath + supplierList[index].imagePath,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            supplierList[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                                fontSize: 16.0),
                          ),
                          Text(
                            supplierList[index].categoryName ?? "",
                            style: TextStyle(
                                color: Color(0xFF575E67),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return ListTile(
                  //   onTap: () {
                  //     print("object");
                  //     Navigator.pushNamed(context, ProductScreen.route,
                  //         arguments: {
                  //           "supplierId": supplierList[index].id.toString(),
                  //           "categoryId": categoryId
                  //         });
                  //   },
                  //   leading: supplierList[index].imagePath == null
                  //       ? Text("")
                  //       : Container(
                  //           width: 50,
                  //           height: 50,
                  //           child: CachedNetworkImage(
                  //             imageUrl:
                  //                 imagePath + supplierList[index].imagePath,
                  //             fit: BoxFit.cover,
                  //             placeholder: (context, url) =>
                  //                 Center(child: CircularProgressIndicator()),
                  //             errorWidget: (context, url, error) =>
                  //                 Icon(Icons.error),
                  //           ),
                  //         ),
                  //   title: Text(supplierList[index].name),
                  //   subtitle: Text(supplierList[index].categoryName ?? ""),
                  // );
                },
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

  Widget sliderBuilder(int index, List<dynamic> list) {
    return Container(
      width: double.infinity,
      child: Image.network(
        imagePath + list[index].imagePath,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildAnnouncementSlider() {
    return announcementList != null && announcementList.isEmpty
        ? Text("")
        : Container(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: announcementList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return sliderBuilder(index, announcementList);
              },
              // items: imageSliders,
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
          );
  }

  Widget buildImagesSlider() {
    return imageList != null && imageList.isEmpty
        ? Text("")
        : Container(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return sliderBuilder(index, imageList);
              },
              // items: imageSliders,
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
          );
  }
}
