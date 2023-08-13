import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/views/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/02e8bc92-61ff-4f07-91a7-2e9c3472205e'));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          enableGradient: false,
          leading: InkWell(
            child: const Icon(CupertinoIcons.back),
            onTap: () {
              Get.back();
            },
          ),
          center: const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          trailing: const SizedBox(width: 20),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
