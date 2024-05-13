import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebViewPage extends StatefulWidget {
  final String url;

  InAppWebViewPage({
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled);
  @override
  void initState() {
    super.initState();
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Gadget'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
