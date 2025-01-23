import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
    required this.titles,
    required this.icons,
    this.onTaps,
  });
  final List<String> titles;
  final List<IconData> icons;
  final List<void Function()>? onTaps;
  @override
  Widget build(BuildContext context) {

    final double width = min(300, 3/4 * MediaQuery.sizeOf(context).width) ;

    List<Widget> widgets = [ 
      for( int i=0; i<titles.length;i++) 
        ListTile(
          leading: icons.length>i ? Icon(icons[i]) : null,
          title: Text(titles[i]), 
          onTap: (onTaps?.length??-1)>i ? onTaps![i] : null,
        )
    ];

    widgets.insert(0,const SizedBox(height: 80));

    return SizedBox(
        width: width,
        child: Drawer(
          child: ListView(
            children:widgets
          ),       
        ) ,
      );
  }
}