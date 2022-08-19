import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BeritaWidget extends StatelessWidget {
  const BeritaWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding:
              EdgeInsets.only(left: getProportionateScreenWidth(35)),
          child: Text(
            'Berita',
            style: TextStyle(
              color: Color(0xff333E63),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BeritaItemWidget(
                tag: 1,
                title: 'Tetap jaga \nkomunikasi \nselama di kapal',
                imgUrl: 'assets/images/chat.png',
              ),
              BeritaItemWidget(
                tag: 2,
                title: 'Protokol \nkesehatan di \nkapal',
                imgUrl: 'assets/images/chat.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BeritaItemWidget extends StatelessWidget {
  final tag;
  final title;
  final imgUrl;
  const BeritaItemWidget({
    Key key,
    this.tag,
    this.title,
    this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 262,
      height: 160,
      padding: EdgeInsets.all(getProportionateScreenWidth(24)),
      margin: EdgeInsets.only(left: getProportionateScreenWidth(15)),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x00000000),
            offset: Offset(0.0, 8.0),
            blurRadius: 64.0,
          ),
        ],
        gradient:
            RadialGradient(colors: [Color(0xffffffff), Color(0xffF4FBFF)]),
        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: tag == 1 ? Color(0x3385D3FF) : Color(0x33F47814),
                    borderRadius: BorderRadius.all(const Radius.circular(4.0)),
                  ),
                  child: Text(
                    tag == 1 ? 'Tips' : 'Update',
                    style: TextStyle(
                      color: tag == 1 ? Color(0xff2596D7) : Color(0xffFE9B4B),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xff333E63),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Arial',
                    height: 1.6,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(),
              Container(
                height: getProportionateScreenWidth(100),
                width: getProportionateScreenWidth(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgUrl),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
