// import 'package:app_novelviewer/src/importer.dart';
import 'package:flutter/material.dart';

class CustomButtonsDialog extends StatelessWidget {
  const CustomButtonsDialog({super.key, this.buttons});
  final List<String>? buttons;

  @override
  Widget build(BuildContext context){
    return const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            heightFactor: 5,
            child: CircularProgressIndicator(),
          ),
          Center(
            child: Text("未実装(別ページで実装するかも)")
          )
        ],
      )
        
    );
  }
}