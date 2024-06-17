import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter/app/core/utils/keys.dart';

class StorageService extends GetxService {
  final GetStorage _box = GetStorage();
  Future<GetStorage> init() async {
    //await _box.write(taskKey, []);
    await _box.writeIfNull(taskKey, []);
    return _box;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write<T>(String key, dynamic value) {
    _box.write(key, value);
  }
}
