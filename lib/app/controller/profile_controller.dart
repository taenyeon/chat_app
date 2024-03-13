import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ProfileController extends GetxController {
  late Logger log;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;

  @override
  void onInit() {
    log = Logger("ProfileController");
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
