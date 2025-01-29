import 'package:sample/src/view/importer.dart';
import 'package:flutter/material.dart';

class HomeInfo extends ConsumerWidget {
  const HomeInfo({super.key});

  // final int? update;

  @override
  Widget build(BuildContext context, ref) {
    return Center(
      child: Padding(padding: EdgeInsets.all(2), child: Text("HomeInfo")),
    );
  }
}
