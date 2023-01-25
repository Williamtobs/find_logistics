import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWebView extends StatelessWidget {
  const PayWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Fund Wallet',
      child: WebView(
        initialUrl: 'https://checkout.paystack.com/7zu1ot06d0qn9h6',
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'PaystackWeb',
      ),
    );
  }
}
