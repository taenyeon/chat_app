import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ModifyProfileController extends GetxController {
  late Logger log;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  RxString selectedImageUrl = "".obs;

  @override
  void onInit() {
    log = Logger("ModifyProfileController");
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
