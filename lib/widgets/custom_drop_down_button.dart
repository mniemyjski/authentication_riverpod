import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDropDownButton extends StatelessWidget {
  final String name;
  final String? value;
  final List<String> list;
  final ValueChanged<String?> onChanged;
  final bool description;
  final Function? descFunc;
  final bool enabled;

  const CustomDropDownButton({
    Key? key,
    required this.name,
    this.value,
    required this.list,
    required this.onChanged,
    this.description = false,
    this.descFunc,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 5, bottom: 8.5, right: 5, top: 8.5),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 6, top: 5, bottom: 2),
            width: double.infinity,
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          IgnorePointer(
            ignoring: !enabled,
            child: DropdownButton<String>(
              isDense: !description,
              isExpanded: true,
              value: value,
              hint: Text(''),
              underline: Container(
                color: Colors.transparent,
              ),
              onChanged: onChanged,
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            value.tr(),
                            style: TextStyle(fontSize: 14),
                          )),
                      if (description)
                        Container(
                            margin: EdgeInsets.only(left: 6),
                            child: Text(
                              descFunc!(value).toString(),
                              style: TextStyle(fontSize: 10),
                            )),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
