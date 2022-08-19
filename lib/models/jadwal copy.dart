import 'dart:convert';

class Jadwal {
  int id_jadwal;
  int id_kapal;
  int id_rute;
  String tgl_berangkat;
  String tgl_tiba;
  String lama_perjalanan;
  String jam_berangkat;
  String jam_tiba;
  int status_jadwal;
  String km;
  String nama_kapal;
  String jenis_kapal;
  String muatan;
  int status_kapal;
  int sisa_tiket_penumpang;
  int sisa_tiket_kendaraan;

  Jadwal(
      {this.id_jadwal,
      this.id_kapal,
      this.id_rute,
      this.tgl_berangkat,
      this.tgl_tiba,
      this.lama_perjalanan,
      this.jam_berangkat,
      this.jam_tiba,
      this.status_jadwal,
      this.km,
      this.nama_kapal,
      this.jenis_kapal,
      this.muatan,
      this.status_kapal,
      this.sisa_tiket_penumpang,
      this.sisa_tiket_kendaraan});

  factory Jadwal.fromJson(Map<String, dynamic> map) {
    return Jadwal(
        id_jadwal: map["id_jadwal"],
        id_kapal: map["id_kapal"],
        id_rute: map["id_rute"],
        tgl_berangkat: map["tgl_berangkat"],
        tgl_tiba: map["tgl_tiba"],
        lama_perjalanan: map["lama_perjalanan"],
        jam_berangkat: map["jam_berangkat"],
        jam_tiba: map["jam_tiba"],
        status_jadwal: map["status_jadwal"],
        km: map["KM"],
        nama_kapal: map["nama_kapal"],
        jenis_kapal: map["jenis_kapal"],
        muatan: map["muatan"],
        status_kapal: map["status_kapal"],
        sisa_tiket_penumpang: map["sisa_tiket_penumpang"],
        sisa_tiket_kendaraan: map["sisa_tiket_kendaraan"]);
  }
}

List<Jadwal> jadwalFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Jadwal>.from(data.map((item) => Jadwal.fromJson(item)));
}
