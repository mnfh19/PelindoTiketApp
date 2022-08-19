import 'dart:convert';

class Booking {
  int id_booking;
  String no_booking;
  int id_tiket;
  int id_tiket_kendaraan;
  int id_user;
  String penumpang_dewasa;
  String penumpang_balita;
  String harga_total;
  String tgl_booking;
  int status_booking;
  String bukti_pembayaran;
  int status_bayar;

  

  Booking(
      {this.id_user,
      this.id_booking,
      this.no_booking,
      this.id_tiket,
      this.id_tiket_kendaraan,
      this.penumpang_dewasa,
      this.penumpang_balita,
      this.harga_total,
      this.tgl_booking,
      this.status_booking,
      this.bukti_pembayaran,
      this.status_bayar});

  factory Booking.fromJson(Map<String, dynamic> map) {
    return Booking(
        id_user: map["id_user"],
        id_booking: map["id_booking"],
        no_booking: map["no_booking"],
        id_tiket: map["id_tiket"],
        id_tiket_kendaraan: map["id_tiket_kendaraan"],
        penumpang_dewasa: map["penumpang_dewasa"],
        penumpang_balita: map["penumpang_balita"],
        harga_total: map["harga_total"],
        tgl_booking: map["tgl_booking"],
        status_booking: map["status_booking"],
        bukti_pembayaran: map["bukti_pembayaran"],
        status_bayar: map["status_bayar"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": id_user,
      "id_booking": id_booking,
      "no_booking": no_booking,
      "id_tiket": id_tiket,
      "id_tiket_kendaraan": id_tiket_kendaraan,
      "penumpang_dewasa": penumpang_dewasa,
      "penumpang_balita": penumpang_balita,
      "harga_total": harga_total,
      "tgl_booking": tgl_booking,
      "status_booking": status_booking,
      "bukti_pembayaran": bukti_pembayaran,
      "status_bayar": status_bayar,
    };
  }

  @override
  String toString() {
    return 'User{id_user: $id_user, id_booking: $id_booking, no_booking: $no_booking, id_tiket: $id_tiket, id_tiket_kendaraan: $id_tiket_kendaraan, penumpang_dewasa: $penumpang_dewasa, penumpang_balita: $penumpang_balita, harga_total: $harga_total, tgl_booking: $tgl_booking, status_booking: $status_booking, bukti_pembayaran: $bukti_pembayaran, status_bayar: $status_bayar,}';
  }
}

List<Booking> bookingFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Booking>.from(data.map((item) => Booking.fromJson(item)));
}

String bookingToJson(Booking data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
