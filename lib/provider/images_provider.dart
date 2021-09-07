import 'package:eshop/model/image_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';

class ImagesProvider extends ChangeNotifier {
  List<ImageData>? _imagesList = [];
  fetchImageList() async {
    final cityId = CacheHelper.getPrefs(key: 'cityId') ?? "0";
    _imagesList = await fetchImages(cityId);
    notifyListeners();
  }

  List<ImageData>? get imagesList => _imagesList;
}
