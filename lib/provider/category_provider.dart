import 'package:eshop/data/service/category_service.dart';
import 'package:eshop/model/main_category.dart';
import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier {
  List<MainCategory> _mainCategoryList = [];
  fetchMainCategoryList(int offset, int limit) async {
    _mainCategoryList = await fetchMainCategory(offset, limit);
    notifyListeners();
  }

  List<MainCategory> get mainCategory => _mainCategoryList;
}
