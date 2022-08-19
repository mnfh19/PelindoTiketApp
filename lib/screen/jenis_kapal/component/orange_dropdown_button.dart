import 'package:flutter/material.dart';

class OrangeDropdown extends StatelessWidget {
  final text;
  final onPress;
  const OrangeDropdown({
    Key key,
     this.text,
     this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 90,
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.only(left: 8, top: 2,bottom: 2),
        decoration: BoxDecoration(
          color: Color(0xffFE9B4B).withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color(0xffFE9B4B),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'Arial',
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xff9F9FB9),
            ),
          ],
        ),
      ),
    );
  }
}