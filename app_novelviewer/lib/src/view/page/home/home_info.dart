import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class HomeInfo extends ConsumerWidget {
  const HomeInfo({
    super.key,
    // this.update,
    required this.nv,
    required this.ep,
  });

  // final int? update;
  final Novel? nv;
  final Episode? ep;

  @override
  Widget build(BuildContext context, ref) {
    return (nv == null || nv?.status == NovelStatus.deleted || ep == null)
        ? const Center(child: Text(HomePageText.noRecentReadMessage))
        : Center(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                        flex: 4,
                        child: Center(
                          child: Text(
                            HomePageText.homeInfoTitle,
                            textScaler: TextScaler.linear(1.5),
                          ),
                        )),
                    const Divider(),
                    Expanded(
                        //recent read history
                        flex: 8,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Center(
                                child: Text("${nv?.title}",
                                    overflow: TextOverflow.ellipsis,
                                    textScaler: const TextScaler.linear(1.3)),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Center(
                                  child: Text(
                                "${ep?.title}",
                                overflow: TextOverflow.ellipsis,
                                textScaler: const TextScaler.linear(1.3),
                              )),
                            ),
                          ],
                        )),
                  ],
                )));
  }
}
