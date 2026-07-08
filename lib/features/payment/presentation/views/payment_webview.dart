import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

enum PaymentResult { success, cancelled, failed }

class PaymentWebView extends StatefulWidget {
  final String checkoutUrl;

  final List<String> successIndicators;

  final List<String> cancelIndicators;

  const PaymentWebView({
    super.key,
    required this.checkoutUrl,
    this.successIndicators = const ['success', 'status=success'],
    this.cancelIndicators = const ['cancel', 'status=cancel'],
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  bool _loading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (error) {
            if (mounted) {
              setState(() {
                _loading = false;
                _loadError = error.description;
              });
            }
          },
          onNavigationRequest: (request) {
            final url = request.url;

            if (widget.successIndicators.any(url.contains)) {
              Navigator.of(context).pop(PaymentResult.success);
              return NavigationDecision.prevent;
            }

            if (widget.cancelIndicators.any(url.contains)) {
              Navigator.of(context).pop(PaymentResult.cancelled);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel payment?'),
        content: const Text(
          'Are you sure you want to leave? Your payment will not be completed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancel payment'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _confirmExit();
        if (shouldExit && context.mounted) {
          Navigator.of(context).pop(PaymentResult.cancelled);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: const Text('Payment'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final shouldExit = await _confirmExit();
              if (shouldExit && context.mounted) {
                Navigator.of(context).pop(PaymentResult.cancelled);
              }
            },
          ),
        ),
        body: SafeArea(
          child: _loadError != null
              ? _buildErrorState()
              : Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (_loading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 48, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              'Couldn\'t load the payment page.\nCheck your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.lightGrey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _loadError = null;
                  _loading = true;
                });
                _controller.reload();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
