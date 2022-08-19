import 'package:flutter/material.dart';

import '../../../size_config.dart';

class ModalPilihKendaraan extends StatelessWidget {
  final List kendaraanItem;
  const ModalPilihKendaraan({
    Key key,
    this.kendaraanItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10), vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Keendaraan',
              style: TextStyle(
                color: Color(0xffD46308),
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          ...List.generate(kendaraanItem.length, (index) {
            return HargaKendaraan(
              namaKendaraan: kendaraanItem[index]["namaKendaraan"],
              harga: kendaraanItem[index]["harga"],
              onPress: () {},
            );
          }),
        ],
      ),
    );
  }
}

class HargaKendaraan extends StatelessWidget {
  final namaKendaraan;
  final harga;
  final onPress;
  const HargaKendaraan({
    Key key,
    this.namaKendaraan,
    this.harga,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.only(
            top: 13,
            bottom: 13,
            left: getProportionateScreenWidth(12),
            right: getProportionateScreenWidth(5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffE8E8E8), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                namaKendaraan,
                style: TextStyle(
                  color: Color(0xff59597C),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
                maxLines: 2,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    ':',
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '\t\t\t',
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    'Rp $harga',
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
