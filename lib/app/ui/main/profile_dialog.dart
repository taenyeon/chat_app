import 'package:chat_app/app/controller/base_controller.dart';
import 'package:chat_app/app/controller/modify_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var baseController = Get.put(BaseController());
    var user = baseController.user.value;
    var modifyProfileController = Get.put(ModifyProfileController());

    modifyProfileController.nameController.text = user.name;
    modifyProfileController.phoneNumberController.text = user.phoneNumber;

    return AlertDialog(
      content: SizedBox(
        width: 500,
        height: 500,
        child: Column(
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  user.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            buildTextFormField(
              "Name",
              modifyProfileController.nameController,
            ),
            const Padding(padding: EdgeInsets.all(5)),
            buildTextFormField(
              "PhoneNumber",
              modifyProfileController.phoneNumberController,
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.redAccent,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.create,
            color: Colors.blueAccent,
          ),
        ),
      ],
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowDirection: VerticalDirection.down,
      insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
      backgroundColor: Colors.black,
    );
  }

  Row buildTextFormField(String title, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: TextFormField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            onFieldSubmitted: (value) {},
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              isCollapsed: true,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.limeAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
