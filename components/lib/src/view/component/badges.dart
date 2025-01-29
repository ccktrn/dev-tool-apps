import 'package:flutter/material.dart';

class DefaultBadge extends StatelessWidget {
  const DefaultBadge ({
    super.key,
    required this.child,
    required this.future,
    required this.badgebuilder,
    this.bg,
    this.fg,
  });
  final Widget child; 
  final Future<List<dynamic>>? future; 
  final Widget?Function(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) badgebuilder; 
  final Color? bg;
  final Color? fg;

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        child,
        FutureBuilder(
          future: future,
          builder:(context, snapshot){
            final res = badgebuilder(context,snapshot);
            if(res==null){
              return Container();
            }else{
              return Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: bg ?? Theme.of(context).colorScheme.inversePrimary,
                  foregroundColor: fg ?? Theme.of(context).colorScheme.onPrimaryContainer,
                  child: res,
                )          
              );
            }
          }
        ),
      ]
      
      
      
      // [
      //   child,

      // ],
    );
  }
}