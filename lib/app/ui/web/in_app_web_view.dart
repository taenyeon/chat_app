import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewPage extends StatefulWidget {
  const InAppWebViewPage({super.key});

  @override
  State<StatefulWidget> createState() => InAppWebViewPageState();
}

class InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController? webViewController;
  String? url;
  InAppWebViewSettings settings = InAppWebViewSettings(
    // useShouldOverrideUrlLoading: true,
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    useHybridComposition: true,
    supportMultipleWindows: true,
    allowsInlineMediaPlayback: true,
  );

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri("https://naver.com"),
      ),
      initialSettings: settings,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) {
        setState(() {
          this.url = url.toString();
        });
      },
    );
  }
}
