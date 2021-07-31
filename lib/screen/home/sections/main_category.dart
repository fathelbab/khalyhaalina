import 'package:eshop/model/main_category.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/supplier/supplier_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategorySection extends StatefulWidget {
  const MainCategorySection({Key? key}) : super(key: key);

  @override
  _MainCategorySectionState createState() => _MainCategorySectionState();
}

class _MainCategorySectionState extends State<MainCategorySection> {
  late String locale;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
  }

  @override
  Widget build(BuildContext context) {
    List<MainCategory>? mainCategoryList =
        Provider.of<CategoryProvider>(context).mainCategory;
    return Container(
      height: 120,
      width: 120,
      child: ListView.builder(
        // controller: _categoryScrollController,
        itemCount: mainCategoryList?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<SupplierProvider>(context, listen: false)
                  .fetchSupplierList(
                      mainCategoryList![index].subCategory![0].id.toString(), 1, 20);
              Navigator.pushNamed(
                context,
                SupplierScreen.route,
                arguments: mainCategoryList[index],
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  height: 80,
                  width: 80,
                  child: Center(
                    child: Image.asset(
                      Constants.imagePath +
                          mainCategoryList![index].image1.toString(),
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  locale == "ar"
                      ? mainCategoryList[index].nameAr.toString()
                      : mainCategoryList[index].nameEn.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0XFFE5A352),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
