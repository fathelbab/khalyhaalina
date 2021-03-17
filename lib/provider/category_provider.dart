import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/category_data.dart';
import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categoryList = [];
  fetchCategoryList(int offset, int limit) async {
    _categoryList = await fetchCategory(offset, limit);
    notifyListeners();
  }

  List<Category> get categoryList => _categoryList;
}
