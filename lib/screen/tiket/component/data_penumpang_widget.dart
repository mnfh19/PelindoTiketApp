import 'package:flutter/material.dart';

class DataPenumpangWidget extends StatelessWidget {
  final namaPenumpang;
  final jenisIdentitas;
  final nomorIdentitas;
  final press;
  const DataPenumpangWidget({
     Key key,
     this.namaPenumpang,
     this.jenisIdentitas,
     this.nomorIdentitas,
     this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      child: Text(
                        'Nama',
                        style: TextStyle(
                          color: Color(0xff333E63),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ),
                    Text(
                      ': $namaPenumpang',
                      style: TextStyle(
                        color: Color(0xff333E63),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 50,
                      child: Text(
                        '$jenisIdentitas',
                        style: TextStyle(
                          color: Color(0xff333E63),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ),
                    Text(
                      ': $nomorIdentitas',
                      style: TextStyle(
                        color: Color(0xff333E63),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: press,
            icon: Icon(Icons.arrow_forward_rounded),
          )
        ],
      ),
    );
  }
}