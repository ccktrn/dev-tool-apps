import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.icon,
    required this.title,
    // this.trailing,
    this.onPressed,
  });
  final Widget icon;
  final String title;
  // final Widget? trailing ;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell( 
        splashColor: Theme.of(context).colorScheme.inversePrimary,
        highlightColor: Theme.of(context).colorScheme.primaryContainer,
        onTap: onPressed,
        child :Center(
          child: ListTile(
            leading: icon,
            // trailing: trailing,
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
          )
        )
      )
    );
  }
}



