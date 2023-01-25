import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWebView extends ConsumerWidget {
  final String url, reference;
  const PayWebView({Key? key, required this.url, required this.reference})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    manualCallback() async {
      var formData = {
        "trxref": reference,
      };
      try {
        final response = await ref
            .read(networkProvider)
            .postWithToken(formData: formData, path: 'callback');
        var body = response.data;
        print(body);
        if (response.statusCode == 200) {
          BottomSnack.successSnackBar(
              message: body['message'], context: context);
          return true;
        }
      } catch (e) {
        print(e);
        BottomSnack.errorSnackBar(
            message: 'Something went wrong, please try again later',
            context: context);
      }
    }

    return BaseScreen(
      title: 'Fund Wallet',
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'PaystackWeb',
        gestureNavigationEnabled: true,
        navigationDelegate: (request) {
          if (request.url.contains('reference=$reference')) {
            manualCallback().then((value) {
              if (value == true) {
                 ref.read(dashboardProvider.notifier).getProfile(context: context);
                Navigator.pop(context);
              }
            });
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (url) {},
        onPageFinished: (url) {},
      ),
    );
  }
}
