import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  runApp(MaterialApp(home: WebApp()));
}

class WebApp extends StatefulWidget {
  const WebApp({super.key});

  @override
  _WebAppState createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> {
  late final WebViewController _controller;

  @override
  initState() {
    super.initState();
    _controller =
        WebViewController(
            onPermissionRequest:
                (WebViewPermissionRequest request) => request.grant(),
          )
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse("https://pasimo-staging-srv.delphinity.nl/qrgoats"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
