import 'package:flutter/material.dart';
import 'package:test_app/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late final WebViewController _controller;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (String url) {
        setState(() {
          _isLoading = true;
        });
      }, onPageFinished: (String url) {
        setState(() {
          _isLoading = false;
        });
      }))
      ..loadRequest(Uri.parse(widget.article.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Page'),
      ),
      body: Column(children: [
        if (_isLoading) const LinearProgressIndicator(),
        Expanded(child: WebViewWidget(controller: _controller)),
        // Container(
        //   color: Colors.lightBlue,
        //   child: SafeArea(
        //     child: Row(
        //       children: [
        //         IconButton(
        //           icon: const Icon(
        //             Icons.arrow_back,
        //           ),
        //           color: Colors.white,
        //           onPressed: () async {
        //             _controller.goBack();
        //           },
        //         ),
        //         IconButton(
        //           icon: const Icon(
        //             Icons.arrow_forward,
        //           ),
        //           color: Colors.white,
        //           onPressed: () async {
        //             _controller.goForward();
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
