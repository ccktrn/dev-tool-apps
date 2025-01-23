// import 'package:app_novelviewer/src/importer.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            heightFactor: 5,
            child: CircularProgressIndicator(),
          ),
          Center(
            child: Text(message??"")
          )
        ],
      )
        
    );
  }
}