import 'package:get/get.dart';
import '../controllers/metals_controller.dart';

class MetalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MetalsController>(() => MetalsController());
  }
}
