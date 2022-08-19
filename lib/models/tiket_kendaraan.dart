import 'dart:convert';

class TiketKendaraan {
  int id_tiket_kendaraan;
  String id_jadwal;
  String jenis_kendaraan;
  String harga;
  String jumlah_tiket;

  TiketKendaraan({
    this.id_tiket_kendaraan,
    this.id_jadwal,
    this.jenis_kendaraan,
    this.harga,
    this.jumlah_tiket,
  });

  factory TiketKendaraan.fromJson(Map<String, dynamic> map) {
    return TiketKendaraan(
      id_tiket_kendaraan: map["id_tiket_kendaraan"],
      id_jadwal: map["id_jadwal"],
      jenis_kendaraan: map["jenis_kendaraan"],
      harga: map["harga"],
      jumlah_tiket: map["jumlah_tiket"],
    );
  }
}

List<TiketKendaraan> tiketKendaraanFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<TiketKendaraan>.from(data.map((item) => TiketKendaraan.fromJson(item)));
}
