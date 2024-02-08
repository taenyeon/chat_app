import 'package:chat_app/app/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
}
