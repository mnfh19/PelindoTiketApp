import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pelindo_travel/models/booking.dart';
import 'package:pelindo_travel/models/jadwal.dart';
import 'package:pelindo_travel/models/penumpang.dart';
import 'package:pelindo_travel/models/riwayat.dart';
import 'package:pelindo_travel/models/tiket_kendaraan.dart';
import 'package:pelindo_travel/models/tiket_penumpang.dart';
import 'package:pelindo_travel/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // final String _url = 'https://sidamak.warungkampoeng.my.id/api/';
  final String baseUrl = 'https://tiketapp.berkasnovel.online/api';
  Client client = Client();

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  postData(data, apiUrl) async {
    // var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = baseUrl + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    http.Response response = await http.get(Uri.parse(baseUrl + apiUrl));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getWhere(apiUrl, String id) async {
    var fullUrl = baseUrl + apiUrl + "/" + id;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  Future<String> getWhereData(apiUrl, String id) async {
    var fullUrl = baseUrl + apiUrl + "/" + id;
    http.Response response =
        await http.get(Uri.parse(fullUrl), headers: _setHeaders());
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  Future<List<User>> getUser() async {
    final response = await client.get(Uri.parse("$baseUrl/getUser"));
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<TiketPenumpang>> getTiketPenumpang(id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/getKelasKapalPenumpang/$id"));
    if (response.statusCode == 200) {
      return tiketPenumpangFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<TiketKendaraan>> getTiketKendaraan(id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/getKelasKapalKendaraan/$id"));
    if (response.statusCode == 200) {
      return tiketKendaraanFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Jadwal>> getJadwal(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    final response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
    if (response.statusCode == 200) {
      return jadwalFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Penumpang>> getAllPenumpang(id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/getAllPenumpang/$id"));
    if (response.statusCode == 200) {
      return penumpangFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Penumpang>> getPenumpangDewasa(id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/getTempPenumpangDewasa/$id"));
    if (response.statusCode == 200) {
      return penumpangFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Penumpang>> getPenumpangBalita(id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/getTempPenumpangBalita/$id"));
    if (response.statusCode == 200) {
      return penumpangFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createPenumpang(Penumpang data) async {
    final response = await client.post(
      "$baseUrl/createTempPenumpang",
      headers: {"content-type": "application/json"},
      body: penumpangToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Booking>> getWhereBooking(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String id = prefs.getString('isLogin');
    final response = await http
        .get(Uri.parse(baseUrl + "/getStatusBooking/" + id.toString()));
    if (response.statusCode == 200) {
      return bookingFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Penumpang>> getPenumpangTiket(id) async {
    final response = await http
        .get(Uri.parse(baseUrl + "/getPenumpangTiket/" + id.toString()));
    if (response.statusCode == 200) {
      return penumpangFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> bookingBaru(Booking data) async {
    final response = await client.post(
      "$baseUrl/booking",
      headers: {"content-type": "application/json"},
      body: bookingToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  bookingBaru2(Booking data) async {
    return await http.post(Uri.parse("$baseUrl/booking"),
        body: bookingToJson(data), headers: _setHeaders());

    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future<String> upload(String filepath, apiUrl) async {
    var uri = Uri.parse(baseUrl + apiUrl);
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));
    var response = await request.send();
    return response.stream.bytesToString();
  }

  Future<bool> ubahProfil(User data) async {
    final response = await client.post(
      "$baseUrl/ubahProfil",
      headers: {"content-type": "application/json"},
      body: userToJson(data),
    );
    // print(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Riwayat>> riwayat(id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/getAllBooking/$id"));
    if (response.statusCode == 200) {
      return riwayatFromJson(response.body);
    } else {
      return null;
    }
  }
}
