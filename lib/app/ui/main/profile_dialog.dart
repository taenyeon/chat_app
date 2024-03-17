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
    var emailController = TextEditingController();
    emailController.text = user.username;
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
            const Padding(padding: EdgeInsets.all(10)),
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: user.imageUrl != null
                        ? Image.network(
                            user.imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Text(
                            user.name.toUpperCase()[0],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                          ),
                  ),
                ),
                Positioned(child: Container())
              ],
            ),
            buildTextFormField("Email", emailController, false),
            const Padding(padding: EdgeInsets.all(5)),
            buildTextFormField(
              "Name",
              modifyProfileController.nameController,
              true,
            ),
            const Padding(padding: EdgeInsets.all(5)),
            buildTextFormField(
              "PhoneNumber",
              modifyProfileController.phoneNumberController,
              true,
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

  Row buildTextFormField(
      String title, TextEditingController controller, bool isEnabled) {
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
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              enabled: isEnabled,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              onFieldSubmitted: (value) {},
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.limeAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
