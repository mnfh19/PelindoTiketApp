import 'package:flutter/material.dart';

class LineDotWidget extends StatelessWidget {
  const LineDotWidget({
     Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(height: 5,),
        Container(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  // Color(0xff2D9CDB),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 6,
                width: 8,
                decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  // Color(0xff2D9CDB),
                  // shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 6,
                width: 8,
                decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  // Color(0xff2D9CDB),
                  // shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 6,
                width: 8,
                decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  // Color(0xff2D9CDB),
                  // shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 6,
                width: 8,
                decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  // Color(0xff2D9CDB),
                  // shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color:
                      // Color(0xffE0E0E0),
                      Color(0xff2D9CDB),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
