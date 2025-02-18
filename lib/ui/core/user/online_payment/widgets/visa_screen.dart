import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({
    super.key,
    required this.finalToken,
    required this.iframeId,
    required this.onFinished,
    required this.onError,
  });

  final String finalToken;
  final String iframeId;
  final VoidCallback onFinished;
  final VoidCallback onError;

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller
    _initializeWebView();
  }

  void _initializeWebView() {
    // Create the WebView controller and set up the necessary parameters
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('success=true')) {
              widget.onFinished();
            }
            // Prevent page reloads if it's already loaded
            return NavigationDecision.navigate;
          },
          onPageFinished: (url) {
            if (url.contains("success=true")) {
              widget.onFinished();
            } else if (url.contains("success=false")) {
              widget.onError();
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          "https://accept.paymob.com/api/acceptance/iframes/${widget.iframeId}?payment_token=${widget.finalToken}"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: _webViewController != null
            ? WebViewWidget(controller: _webViewController!)
            : const Center(
                child:
                    CircularProgressIndicator()), // Show loading indicator while WebView is initializing
      ),
    );
  }
}
