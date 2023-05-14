import 'dart:io';

import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  final urlController = TextEditingController();

  startApp() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Terms And Condition',
      child: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://findlogistic.com/terms-and-conditions'),
        ),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          setState(() {
            urlController.text = url.toString();
          });
        },
        onLoadStop: (controller, url) async {
          setState(() {
            urlController.text = url.toString();
          });
        },
        onProgressChanged: (controller, progress) {
          if (progress == 100) {
            setState(() {});
          }
        },
        onLoadError: (controller, url, code, message) {
          if (kDebugMode) {
            print("error $code $message");
          }
        },
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          return ServerTrustAuthResponse(
              action: ServerTrustAuthResponseAction.PROCEED);
        },
      ),
    );
  }
}
