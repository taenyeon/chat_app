import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';

class WebMacPage extends StatefulWidget {
  const WebMacPage({super.key});

  @override
  State<StatefulWidget> createState() => _WebMacPage();
}

class _WebMacPage extends State<WebMacPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 300,
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white12),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () async {
            final webview = await WebviewWindow.create(
              configuration: const CreateConfiguration(),
            );
            webview
              ..registerJavaScriptMessageHandler("test", (name, body) {
                debugPrint('on javaScipt message: $name $body');
              })
              ..setApplicationNameForUserAgent(" WebviewExample/1.0.0")
              ..setPromptHandler((prompt, defaultText) {
                if (prompt == "test") {
                  return "Hello World!";
                } else if (prompt == "init") {
                  return "initial prompt";
                }
                return "";
              })
              ..addScriptToExecuteOnDocumentCreated("""
                const mixinContext = {
              platform: 'Desktop',
              conversation_id: 'conversationId',
              immersive: false,
              app_version: '1.0.0',
              appearance: 'dark',
                }
                window.MixinContext = {
              getContext: function() {
                return JSON.stringify(mixinContext)
              }
                }
              """)
              ..launch("https://naver.com");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "open other window browser",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.desktop_windows,
                    color: Colors.white70,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
