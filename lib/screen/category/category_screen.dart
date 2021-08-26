import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/model/main_category.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/supplier/supplier_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getString(context, "category"),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GridView.builder(
          // controller: _categoryScrollController,
          itemCount: mainCategoryList?.length,

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
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            crossAxisCount: constraints.maxWidth > 480 ? 5 : 3,
            childAspectRatio: 0.8,
          ),
        ),
      ),
    );
  }
}
