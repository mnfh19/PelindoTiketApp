import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/penumpang.dart';
import 'package:pelindo_travel/screen/data_penumpang/component/form_data_penumpang.dart';

import '../../../app_color.dart';
import 'dart:math' as math;

class DewasaData extends StatelessWidget {
  final String id;
  final int jum;
  final Function update;

  const DewasaData({
    Key key,
    this.id,
    this.jum,
    this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: ScrollOnExpand(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorSecondary,
                                  ),
                                  child: Image.asset(
                                      'assets/icons/emoji-happy.png'),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  jum.toString() + ' Dewasa',
                                  style: TextStyle(
                                    color: Color(0xff333E63),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.keyboard_arrow_down,
                              collapseIcon: Icons.keyboard_arrow_up,
                              iconColor: Colors.black,
                              iconSize: 28.0,
                              iconRotationAngle: math.pi / 2,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Divider(),
                        FutureBuilder(
                          future: ApiService().getPenumpangDewasa(id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Penumpang>> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Something wrong with message: ${snapshot.error.toString()}"),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              List<Penumpang> penumpang = snapshot.data;

                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Penumpang data = penumpang[index];

                                  update(data.nama_penumpang);

                                  return DewasaDataItem(
                                    nama: data.nama_penumpang,
                                    iden: data.jenis_identitas,
                                    no: data.no_identitas,
                                  );
                                },
                                itemCount: penumpang.length,
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/form-input-penumpang',
                              arguments: FormINputDataPenumpang(isDewasa: true),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: colorSecondary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Tambah data penumpang',
                                style: TextStyle(
                                  color: Color(0xff333E63),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DewasaDataItem extends StatelessWidget {
  final String nama;
  final String iden;
  final String no;
  const DewasaDataItem({
    Key key,
    this.nama,
    this.iden,
    this.no,
  }) : super(key: key);

  void menuSelection(String value) {
    switch (value) {
      case 'Edit':
        //
        break;
      case 'Delete':
        //
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Row(
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
                ': ' + nama,
                style: TextStyle(
                  color: Color(0xff333E63),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Arial',
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Container(
                width: 50,
                child: Text(
                  iden,
                  style: TextStyle(
                    color: Color(0xff333E63),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
              Text(
                ': ' + no,
                style: TextStyle(
                  color: Color(0xff333E63),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Arial',
                ),
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.edit),
            onSelected: menuSelection,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'Hapus',
                child: Text(
                  'Hapus',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.edit),
          //   ),
        ),
        Divider(),
      ],
    );
  }
}
