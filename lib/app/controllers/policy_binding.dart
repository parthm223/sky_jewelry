import 'package:get/get.dart';
import 'package:sky_jewelry/app/bindings/policy_controller.dart';

class PolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolicyController>(() => PolicyController());
  }
}
