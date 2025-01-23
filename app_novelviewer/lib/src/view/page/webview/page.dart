import 'dart:io';

import 'package:app_novelviewer/src/model/logic/add_novel.dart';
import 'package:app_novelviewer/src/provider/provider/pref/custom_conf.dart';
import 'package:app_novelviewer/src/view/importer.dart';
import 'package:app_novelviewer/src/view/component/dialog/loading_dialog.dart';
import 'package:app_novelviewer/src/view/component/snackbar/message_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends ConsumerStatefulWidget {
  const WebViewPage({
    super.key,
    this.url,
  });
  final Uri? url;

  @override
  ConsumerState<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends ConsumerState<WebViewPage> {
  final _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setBackgroundColor(Theme.of(context).colorScheme.background);
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );
    _controller
        .loadRequest(widget.url ?? Uri.parse(ref.watch(defaultURLProvider)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _controller.getTitle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data ?? "");
            } else {
              return const Text("Loading...");
            }
          },
        ),
        // title: const Text(WebViewPageText.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _addNovel,
          ),
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.centerStart,
      persistentFooterButtons: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _controller.goBack(),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _controller.goForward(),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => _controller.reload(),
        ),
      ],
      body: WebViewWidget(controller: _controller),
    );
  }

  // func

  void _addNovel() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(message: "目次取得中…"),
    );
    try {
      String? url = await _controller.currentUrl();
      if (url != null) {
        await addNovel(url);
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(messageSnackBar(SnackBarText.registerd));
        }
      }
    } on FormatException {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(messageSnackBar(SnackBarText.unexpectedURL));
      }
    } on ClientException {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(messageSnackBar(SnackBarText.networkerror));
      }
    } on HttpException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(messageSnackBar("$e"));
      }
    }
    if (mounted) {
      // close loadingDialog
      Navigator.pop(context);
    }
  }
}
