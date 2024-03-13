import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void sendMessage(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      icon: const Icon(
        Icons.rocket_launch,
        color: Colors.limeAccent,
        shadows: [],
      ),
      backgroundColor: Colors.white10,
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
    );
  }

  static void sendError(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange,
        ),
      ),
      icon: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black26,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.rocket_launch,
              color: Colors.limeAccent,
              size: 30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white10,
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
    );
  }
}
