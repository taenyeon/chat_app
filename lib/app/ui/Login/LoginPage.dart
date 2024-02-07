import 'dart:developer';

import 'package:chat_app/app/controller/LoginController.dart';
import 'package:chat_app/app/route/Route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: loginController.usernameController,
                decoration: const InputDecoration(labelText: 'EMAIL'),
              ),
              TextFormField(
                controller: loginController.passwordController,
                decoration: const InputDecoration(labelText: 'PASSWORD'),
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: () => loginController.login(),
                  child: const Text('LOGIN'))
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    Get.snackbar("login", "press");
  }
}
