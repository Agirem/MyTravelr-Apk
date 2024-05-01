import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WebViewApp(),
  ));
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://booking.mytravelr.co'));
  }

   @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 2,
          backgroundColor: Colors.blue,
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    // Check if there's back navigation history
    if (Navigator.of(context).canPop()) {
      // Use popUntil to navigate back to the previous route
      Navigator.of(context).popUntil((route) => route.isFirst);
      return false; // Prevent app from closing
    }
    return true; // Allow app to close if no back history
  }
}
