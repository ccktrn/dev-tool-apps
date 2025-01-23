// import 'package:app_novelviewer/src/importer.dart';
import 'package:flutter/material.dart';

class SelectDialog extends StatelessWidget {
  const SelectDialog({super.key,required this.optNames, required this.optValues,  this.title});
  final String? title;
  final List<String> optNames;
  final List<dynamic> optValues;

  @override
  Widget build(BuildContext context){
    List<Widget> widgets = [
        for ( int i=0;i<optNames.length;i++) 
          SimpleDialogOption(
            onPressed: ()=>Navigator.pop(context,optValues[i]),
            child: Text(optNames[i]),
          )
      ];
     
    return SimpleDialog(
      title: title != null ? Text(title!):null,
      children: widgets,
    );
  }
}