import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_drawer.dart';

class Homew extends StatelessWidget {
  final List<City> cityList;
  String cityId = "";
  String categoryId = "";
  String _selectedCity;
  Homew({Key key, this.cityList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    cityId = Provider.of<SupplierProvider>(context).cityId;
    Provider.of<SupplierProvider>(context, listen: false)
        .fetchSupplierList(categoryId, cityId, 1, 100);
    String cityName = cityList[0].name;
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Shop"),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Column(
          children: [
            Container(
              // alignment: Alignment.centerRight,
              child: DropdownButton(
                  hint: Text(cityName),
                  value: _selectedCity,
                  onChanged: (newValue) {
                    _selectedCity = newValue;
                    cityName = _selectedCity;
                    print(_selectedCity);
                    cityId = cityList
                            .firstWhere((city) => (city.name == _selectedCity))
                            .id
                            .toString() ??
                        "";
                    Provider.of<SupplierProvider>(context,listen: false).setCityId(cityId);

                    print("kira" + categoryId + cityId);
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
            SupplierList(),
          ],
        ),
      ),
    );
  }
}

class SupplierList extends StatelessWidget {
  List<Supplier> supplierList;

  @override
  Widget build(BuildContext context) {
    supplierList = Provider.of<SupplierProvider>(context).supplierList;

    return Expanded(
      child: ListView.builder(
        itemCount: supplierList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              print("object");
              Navigator.pushNamed(context, ProductScreen.route, arguments: {
                "supplierId": supplierList[index].id.toString(),
                "categoryId": Provider.of<SupplierProvider>(context).categoryId
              });
            },
            leading: supplierList[index].imagePath == null
                ? Text("")
                : Container(
                    width: 50,
                    height: 50,
                    child: CachedNetworkImage(
                      imageUrl: imagePath + supplierList[index].imagePath,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
            title: Text(supplierList[index].name),
            subtitle: Text(supplierList[index].categoryName ?? ""),
          );
        },
      ),
    );
  }
}
