import 'package:geo_tasker/controllers/task.controller.dart';
import 'package:get/get.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
  }
}


