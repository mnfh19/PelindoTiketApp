// import 'package:flutter/material.dart';
// import 'package:pelindo_travel/screen/data_penumpang/component/form_data_penumpang.dart';
// import 'package:pelindo_travel/screen/data_penumpang/input_penumpang_screen.dart';
// import 'package:pelindo_travel/screen/jenis_kapal/component/kendaraan_modal.dart';
// import 'package:pelindo_travel/screen/jenis_kapal/component/penumpang_modal.dart';
// import 'package:pelindo_travel/screen/pemesanan/component/jumlah_tiket_field.dart';
// import 'package:pelindo_travel/size_config.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../app_color.dart';

// class PemesananScreen extends StatefulWidget {
//   final String id;
//   final String namaKapal;
//   final String id_jadwal;
//   const PemesananScreen({
//     Key key,
//     this.namaKapal,
//     this.id,
//     this.id_jadwal,
//   }) : super(key: key);

//   @override
//   _PemesananScreenState createState() => _PemesananScreenState();
// }

// class _PemesananScreenState extends State<PemesananScreen> {
//   TextEditingController _jmlDewasa = TextEditingController(text: '0');
//   TextEditingController _jmlBayi = TextEditingController(text: '0');

//   String namaKapal;
//   var kapalItem;
//   String namaKelas = 'EK - A';
//   var hargaKelasBayi = 80000;
//   var hargaKelasDewasa = 800000;
//   List kelasItem;
//   List selectedKelas;
//   String namaKendaraan = 'Sepeda';
//   var hargaKendaraan = 0;
//   List kendaraanItem;

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff85D3FF),
//         shadowColor: Color(0xff85D3FF),
//         automaticallyImplyLeading: false,
//         leadingWidth: 25,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Color(0xff333E63),
//           ),
//         ),
//         title: Text(
//           'Pemesanan',
//           style: TextStyle(
//             color: Color(0xff181D2D),
//             fontSize: 22,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Poppins',
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: getProportionateScreenWidth(57)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 16),
//                   //nama Kapal
//                   Container(
//                     margin: EdgeInsets.only(left: 5, bottom: 6),
//                     child: Text(
//                       'Nama Kapal',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       widget.namaKapal,
//                       style: TextStyle(
//                         color: Color(0xff59597C),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Poppins',
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   //jumlah tiket
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(left: 5, bottom: 6),
//                               child: Text(
//                                 'Dewasa',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Poppins',
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(right: 15),
//                               child: JumlahTiketField(
//                                 textController: _jmlDewasa,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(left: 15, bottom: 6),
//                               child: Text(
//                                 'Bayi (0-23 Bulan)',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Poppins',
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 15),
//                               child: JumlahTiketField(
//                                 textController: _jmlBayi,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   //kelas Tiket
//                   Container(
//                     margin: EdgeInsets.only(left: 5, bottom: 6),
//                     child: Text(
//                       'Kelas Tiket',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Pilih Jenis Kelas Tiket',
//                           style: TextStyle(
//                             color: Color(0xff88879C),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Poppins',
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Icon(
//                           Icons.keyboard_arrow_down,
//                           color: Color(0xff88879C),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   //Jenis Kendaraan
//                   Container(
//                     margin: EdgeInsets.only(left: 5, bottom: 6),
//                     child: Text(
//                       'Jenis Kendaraan',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Pilih Jenis Kelas Kendaraan',
//                           style: TextStyle(
//                             color: Color(0xff88879C),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Poppins',
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Icon(
//                           Icons.keyboard_arrow_down,
//                           color: Color(0xff88879C),
//                         ),
//                       ],
//                     ),
//                   ),
//                   VerticalSpacing(),
//                   //Total Pemesanan
//                   Container(
//                     margin: EdgeInsets.only(left: 5, bottom: 6),
//                     child: Text(
//                       'Total Pemesanan',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.only(
//                         left: 15, top: 15, bottom: 15, right: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 100,
//                           child: Text(
//                             'Dewasa',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Center(
//                             child: Text(
//                               '1',
//                               style: TextStyle(
//                                 color: Color(0xff88879C),
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Poppins',
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Rp -',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.only(
//                         left: 15, top: 15, bottom: 15, right: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 100,
//                           child: Text(
//                             'Bayi',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Center(
//                             child: Text(
//                               '1',
//                               style: TextStyle(
//                                 color: Color(0xff88879C),
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Poppins',
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Rp -',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.only(
//                         left: 15, top: 15, bottom: 15, right: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 100,
//                           child: Text(
//                             'Kendaraan',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Center(
//                             child: Text(
//                               '',
//                               style: TextStyle(
//                                 color: Color(0xff88879C),
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Poppins',
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Rp -',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.only(
//                         left: 15, top: 15, bottom: 15, right: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Color(0xffE8E8E8), width: 1),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 100,
//                           child: Text(
//                             'TOTAL HARGA',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Container(),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Rp -',
//                             style: TextStyle(
//                               color: Color(0xff88879C),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Poppins',
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             VerticalSpacing(),
//             Container(
//               alignment: Alignment.centerRight,
//               margin: EdgeInsets.only(
//                   right: getProportionateScreenWidth(43), bottom: 20),
//               child: TextButton(
//                 onPressed: () async {
//                   SharedPreferences sharedPreferences =
//                       await SharedPreferences.getInstance();

//                   Navigator.pushNamed(
//                     context,
//                     '/input-penumpang',
//                     arguments: InputPenumpangScreen(
//                       id: sharedPreferences.getString("id"),
//                       dewasa: int.parse(_jmlDewasa.text),
//                       balita: int.parse(_jmlBayi.text),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 140,
//                   decoration: BoxDecoration(
//                     color: colorPrimary,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'LANJUT',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Arial',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget buildModalPenumpang(context, id, nama) {
//   return makeDismissible(
//     context,
//     child: ModalKelasPenumpang(id: id, nama: nama),
//   );
// }

// Widget buildModalKendaraan(context, id) {
//   return makeDismissible(
//     context,
//     child: ModalKendaraan(
//       id: id,
//     ),
//   );
// }

// Widget makeDismissible(context, {Widget child}) {
//   return GestureDetector(
//     behavior: HitTestBehavior.opaque,
//     onTap: () => Navigator.of(context).pop(),
//     child: GestureDetector(onTap: () {}, child: child),
//   );
// }
