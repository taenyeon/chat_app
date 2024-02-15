import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTestPage extends StatelessWidget {
  const MainTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        children: [
          menuBar(),
          body(),
        ],
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white24,
          ),
        ),
      ),
    );
  }

  Padding menuBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white24,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              menu(Icons.dashboard, "BOARD"),
              menu(Icons.message, "CHAT"),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.abc),
                iconSize: 50,
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white10,
                  ),
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column menu(IconData icon, String name) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10,
            ),
            width: 50,
            height: 50,
            child: Center(
              child: Icon(
                icon,
                color: Colors.white38,
              ),
            ),
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white38,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
