import 'package:get/get.dart';
import '../data/app_database.dart';
import 'memory_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppDatabase>(AppDatabase(), permanent: true);
    Get.put<MemoryController>(MemoryController(Get.find()));
  }
}
