import 'package:flutter/material.dart';

import '../../../size_config.dart';

class PesanButton extends StatelessWidget {
  final onPress;
  const PesanButton({
    Key key,
     this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(left: 3),
        padding: EdgeInsets.symmetric(
            vertical: 6, horizontal: getProportionateScreenWidth(23)),
        decoration: BoxDecoration(
          color: Color(0xff01ADD7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          'Pesan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
