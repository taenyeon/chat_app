import 'package:chat_app/app/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Container()),
          const Expanded(child: LoginInterface())
        ],
      ),
    );
  }
}

class LoginInterface extends StatelessWidget {
  const LoginInterface({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final LoginController loginController = Get.put(LoginController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: Colors.black45,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 40,
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: loginController.usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: 'EMAIL',
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.limeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: loginController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            borderSide: const BorderSide(color: Colors.white)),
                        labelText: 'PASSWORD',
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.limeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.04,
                    child: ElevatedButton(
                      onPressed: () => loginController.login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.limeAccent,
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
