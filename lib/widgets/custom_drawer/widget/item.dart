import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.icon,
    required this.text,
    this.inactive = false,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool inactive;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text, style: inactive ? TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey) : null),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
