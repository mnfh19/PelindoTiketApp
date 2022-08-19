import 'dart:convert';

class TiketPenumpang {
  int id_tiket;
  String id_jadwal;
  String kelas_tiket;
  String jumlah_tiket;
  String harga_balita;
  String harga_dewasa;

  TiketPenumpang({
    this.id_tiket,
    this.id_jadwal,
    this.kelas_tiket,
    this.jumlah_tiket,
    this.harga_balita,
    this.harga_dewasa,
  });

  factory TiketPenumpang.fromJson(Map<String, dynamic> map) {
    return TiketPenumpang(
      id_tiket: map["id_tiket"],
      id_jadwal: map["id_jadwal"],
      kelas_tiket: map["kelas_tiket"],
      jumlah_tiket: map["jumlah_tiket"],
      harga_balita: map["harga_balita"],
      harga_dewasa: map["harga_dewasa"],
    );
  }
}

List<TiketPenumpang> tiketPenumpangFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<TiketPenumpang>.from(data.map((item) => TiketPenumpang.fromJson(item)));
}
