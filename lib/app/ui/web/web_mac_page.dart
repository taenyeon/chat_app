import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';

class WebMacPage extends StatefulWidget {
  const WebMacPage({super.key});

  @override
  State<StatefulWidget> createState() => _WebMacPage();
}

class _WebMacPage extends State<WebMacPage> {
  final String url = "https://ez-ace.ncpworkplace.com/v/home/";

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
              configuration: const CreateConfiguration(
                title: "webViewer",
                titleBarTopPadding: 0,
              ),
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
              ..launch(url);
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "open other window browser",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.desktop_windows_outlined,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
