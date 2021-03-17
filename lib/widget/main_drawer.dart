import 'package:eshop/model/category_data.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  List<Category> categoryList = [];
  final ScrollController _categoryScrollController = new ScrollController();
  final int limit = 20;
  final BuildContext contextt;
  String cityId = "";
  String categoryId = "";
  MainDrawer({Key key, this.contextt});
  @override
  Widget build(BuildContext context) {
    categoryList = Provider.of<CategoryProvider>(context).categoryList;
    var supplierProvider = Provider.of<SupplierProvider>(context,listen: false);
    return Drawer(
      child: ListView.builder(
        controller: _categoryScrollController,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.pop(context);
              cityId = supplierProvider.cityId;

              supplierProvider.setCategoryId(categoryList[index].id.toString());
              categoryId = supplierProvider.categoryId;
              supplierProvider.fetchSupplierList(categoryId, cityId, 1, limit);
              print(categoryList[index].name);
            },
            title: Text(
              categoryList[index].name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
