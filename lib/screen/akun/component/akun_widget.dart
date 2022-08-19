import 'package:flutter/material.dart';

import '../../../size_config.dart';

class AkunWidget extends StatelessWidget {
  final icon;
  final text;
  final action;

  const AkunWidget({
    Key key,
    this.icon,
    this.text,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          left: getProportionateScreenWidth(30),
          right: getProportionateScreenWidth(30),
        ),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Color(0xffF8F8FF),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 0.5,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: 15,
              width: 15,
              fit: BoxFit.cover,
              image: AssetImage('assets/icons/$icon'),
            ),
            SizedBox(width: getProportionateScreenWidth(25)),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Color(0xff88879C),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    // color: colorPrimary,
                    borderRadius: BorderRadius.circular(8),
                    gradient: RadialGradient(
                      colors: [
                        Color(0xff85D3FF),
                        Color(0xff2596D7),
                      ],
                      center: Alignment.topRight,
                      radius: 2,
                    ),
                  ),
                  child: Image(
                    image: AssetImage('assets/icons/arrow-right.png'),
                    width: 15,
                    height: 15,
                  )),
            
          ],
        ),
      ),
    );
  }
}
