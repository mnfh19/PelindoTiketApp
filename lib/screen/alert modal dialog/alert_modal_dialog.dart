import 'package:flutter/material.dart';

import '../../app_color.dart';
import '../../size_config.dart';

class AlertmodalDialogWidget extends StatelessWidget {
  final title;
  final subTitle;
  final yesClicked;

  const AlertmodalDialogWidget({
    Key key,
    this.title,
    this.subTitle,
    this.yesClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(25), vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                // color: Color(0xff181D2D),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 37,
            ),
            Text(
              subTitle,
              style: TextStyle(
                // color: Color(0xff181D2D),
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xff88879C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: yesClicked,
                  // () {
                  //   Navigator.pushNamedAndRemoveUntil(
                  //       context, '/home', (route) => false);
                  // },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}