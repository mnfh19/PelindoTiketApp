import 'dart:convert';

class Penumpang {
  String id_penumpang;
  String id_user;
  String jenis_penumpang;
  String no_tiket;
  String nama_penumpang;
  String jenis_identitas;
  String no_identitas;
  String ttl;
  String jenis_kelamin;
  String telp;

  Penumpang(
      {this.id_penumpang,
      this.id_user,
      this.no_tiket,
      this.jenis_penumpang,
      this.nama_penumpang,
      this.jenis_identitas,
      this.no_identitas,
      this.ttl,
      this.jenis_kelamin,
      this.telp});

  factory Penumpang.fromJson(Map<String, dynamic> map) {
    return Penumpang(
        id_penumpang: map["id_penumpang"],
        id_user: map["id_user"],
        no_tiket: map["no_tiket"],
        jenis_penumpang: map["jenis_penumpang"],
        nama_penumpang: map["nama_penumpang"],
        jenis_identitas: map["jenis_identitas"],
        no_identitas: map["no_identitas"],
        ttl: map["ttl"],
        jenis_kelamin: map["jenis_kelamin"],
        telp: map["telp"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_Penumpang": id_penumpang,
      "id_user": id_user,
      "no_tiket": no_tiket,
      "jenis_penumpang": jenis_penumpang,
      "nama_penumpang": nama_penumpang,
      "jenis_identitas": jenis_identitas,
      "no_identitas": no_identitas,
      "ttl": ttl,
      "jenis_kelamin": jenis_kelamin,
      "telp": telp,
    };
  }

  @override
  String toString() {
    return 'Penumpang{id_Penumpang: $id_penumpang, id_user: $id_user, jenis_penumpang: $jenis_penumpang, no_tiket: $no_tiket, nama_penumpang: $nama_penumpang, jenis_identitas: $jenis_identitas, no_identitas: $no_identitas, ttl: $ttl, jenis_kelamin: $jenis_kelamin, telp: $telp,}';
  }
}

List<Penumpang> penumpangFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Penumpang>.from(data.map((item) => Penumpang.fromJson(item)));
}

String penumpangToJson(Penumpang data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
