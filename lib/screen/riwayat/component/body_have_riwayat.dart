import 'package:flutter/material.dart';
import 'package:pelindo_travel/screen/riwayat/component/kota_asal_tujuan_widget.dart';
import 'package:pelindo_travel/screen/riwayat/component/modal_detail_pemesanan.dart';
import 'package:pelindo_travel/screen/riwayat/component/riwayat_item_widget.dart';

class BodyHaveRiwayat extends StatelessWidget {
  const BodyHaveRiwayat({
     Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
        // height: SizeConfig.screenHeight!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RiwayatItemWidget(
              kotaAsal: 'Surabaya',
              kotaTujuan: 'Makassar',
              waktu: '17 Okt 21,  09.00 - 18 Okt 21, 13.00',
              namaKapal: 'KAPAL PELNI (KM. DOROLONDA)',
              noBooking: 'BKNEK01',
              tanggalBooking: '16 Oktober 2021 (19.45)',
              jumlahPenumpang: '2',
              press: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return buildModalDetailPemesanan(context);
                  },
                );
              },
            ),
            RiwayatItemWidget(
              kotaAsal: 'Surabaya',
              kotaTujuan: 'Makassar',
              waktu: '17 Okt 21,  09.00 - 18 Okt 21, 13.00',
              namaKapal: 'KAPAL PELNI (KM. DOROLONDA)',
              noBooking: 'BKNEK01',
              tanggalBooking: '16 Oktober 2021 (19.45)',
              jumlahPenumpang: '2',
              press: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return buildModalDetailPemesanan(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildModalDetailPemesanan(context) {
  return makeDismissible(
    context,
    child: ModalDetailPemesanan(),
  );
}

Widget makeDismissible(context, { Widget child}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );
}
