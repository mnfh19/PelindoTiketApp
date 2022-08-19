import 'dart:convert';

class Riwayat {
  int id_booking;
  String no_booking;
  String rute_awal;
  String rute_akhir;
  String tgl_tiba;
  String penumpang_dewasa;
  String penumpang_balita;
  String tgl_berangkat;
  String tgl_booking;
  String jam_berangkat;
  String jam_tiba;
  String nama_kapal;
  String KM;
  String kelas_tiket;
  String jenis_kapal;
  String jenis_kendaraan;

  Riwayat({
    this.tgl_tiba,
    this.id_booking,
    this.no_booking,
    this.rute_awal,
    this.rute_akhir,
    this.penumpang_dewasa,
    this.penumpang_balita,
    this.tgl_berangkat,
    this.tgl_booking,
    this.jam_berangkat,
    this.jam_tiba,
    this.nama_kapal,
    this.KM,
    this.kelas_tiket,
    this.jenis_kapal,
    this.jenis_kendaraan,
  });

  factory Riwayat.fromJson(Map<String, dynamic> map) {
    return Riwayat(
      tgl_tiba: map["tgl_tiba"],
      id_booking: map["id_booking"],
      no_booking: map["no_booking"],
      rute_awal: map["rute_awal"],
      rute_akhir: map["rute_akhir"],
      penumpang_dewasa: map["penumpang_dewasa"],
      penumpang_balita: map["penumpang_balita"],
      tgl_berangkat: map["tgl_berangkat"],
      tgl_booking: map["tgl_booking"],
      jam_berangkat: map["jam_berangkat"],
      jam_tiba: map["jam_tiba"],
      nama_kapal: map["nama_kapal"],
      KM: map["KM"],
      kelas_tiket: map["kelas_tiket"],
      jenis_kapal: map["jenis_kapal"],
      jenis_kendaraan: map["jenis_kendaraan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tgl_tiba": tgl_tiba,
      "id_booking": id_booking,
      "no_booking": no_booking,
      "rute_awal": rute_awal,
      "rute_akhir": rute_akhir,
      "penumpang_dewasa": penumpang_dewasa,
      "penumpang_balita": penumpang_balita,
      "tgl_berangkat": tgl_berangkat,
      "tgl_booking": tgl_booking,
      "jam_berangkat": jam_berangkat,
      "jam_tiba": jam_tiba,
      "nama_kapal": nama_kapal,
      "KM": KM,
      "kelas_tiket": kelas_tiket,
      "jenis_kapal": jenis_kapal,
      "jenis_kendaraan": jenis_kendaraan,
    };
  }
}

List<Riwayat> riwayatFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Riwayat>.from(data.map((item) => Riwayat.fromJson(item)));
}

String riwayatToJson(Riwayat data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
