import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSegyjaUDpvNUrvq-oYOa9zBmS3xivRIysLIKO59TcSawvAKfA/viewform?usp=sf_link',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
