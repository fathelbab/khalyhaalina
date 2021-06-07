import 'package:eshop/model/image_data.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';

class ImagesProvider extends ChangeNotifier {
  List<ImageData>? _imagesList = [];
  fetchImageList() async {
    _imagesList = await fetchImages();
    notifyListeners();
  }

  List<ImageData>? get imagesList => _imagesList;
}
