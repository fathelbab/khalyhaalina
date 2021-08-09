import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/model/main_category.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/supplier/supplier_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/constants.dart';
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
                      mainCategoryList![index].subCategory![0].id.toString(),
                      1,
                      20);
              Navigator.pushNamed(
                context,
                SupplierScreen.route,
                arguments: mainCategoryList[index],
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  height: 90,
                  width: 90,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: Constants.imagePath +
                          mainCategoryList![index].image1.toString(),
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
