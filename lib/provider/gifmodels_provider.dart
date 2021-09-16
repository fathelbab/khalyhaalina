import 'package:eshop/data/service/gif_models_service.dart';
import 'package:eshop/model/gif_models_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/foundation.dart';

class GifModelsProvider extends ChangeNotifier {
  List<GifModels>? _gifModelsList = [];

  getGifModelsList() async {
    String cityId = CacheHelper.getPrefs(key: 'cityId') ?? "0";
    _gifModelsList = await getGifModels(cityId);
    notifyListeners();
  }

  List<GifModels>? get gifModelsList => _gifModelsList;
}
