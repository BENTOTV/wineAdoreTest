import 'package:get/get.dart';
import 'package:test_flutter/app/data/providers/tasks/provider.dart';
import 'package:test_flutter/app/data/services/storage/repository.dart';
import 'package:test_flutter/app/module/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController(
        repositoryTask: RepositoryTask(taskProviders: TaskProviders())));
  }
}
