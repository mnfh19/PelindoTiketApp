import 'package:flutter/material.dart';
import 'package:pelindo_travel/screen/data_penumpang/component/form_data_penumpang.dart';
import 'package:pelindo_travel/screen/data_penumpang/input_penumpang_screen.dart';
import 'package:pelindo_travel/screen/forgot/forgot_screen.dart';
import 'package:pelindo_travel/screen/home/home_screen.dart';
import 'package:pelindo_travel/screen/jenis_kapal/jenis_kapal_screen.dart';
import 'package:pelindo_travel/screen/login/login_screen.dart';
import 'package:pelindo_travel/screen/onboard/intro.dart';
import 'package:pelindo_travel/screen/onboard/splash.dart';
import 'package:pelindo_travel/screen/otp/otp_screen.dart';
import 'package:pelindo_travel/screen/pembayaran/pembayaran_screen.dart';
import 'package:pelindo_travel/screen/pemesanan/pemesanan_screen.dart';
import 'package:pelindo_travel/screen/profil/profil_screen.dart';
import 'package:pelindo_travel/screen/register/register_screen.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/ringkasan_pemesanan_screen.dart';
import 'package:pelindo_travel/screen/riwayat/riwayat_screen.dart';
import 'package:pelindo_travel/screen/tiket/detail_tiket_screen.dart';

String initialRoute = '/';

Route<dynamic> appRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return  Splash();
        },
      );
    
    case '/home':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const HomeScreen();
        },
      );
    case '/login':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const LoginScreen();
        },
      );
    case '/lupa-password':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const ForgotScreen();
        },
      );
    case '/kode-verifikasi':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const OtpScreen();
        },
      );
    case '/daftar':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const RegisterScreen();
        },
      );
    case '/jenis-kapal':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as JenisKapalScreen;
          return JenisKapalScreen(
              ruteAwal: args.ruteAwal,
              ruteAkhir: args.ruteAkhir,
              tglBerangkat: args.tglBerangkat);
        },
      );
    case '/pemesanan':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as PemesananScreen;
          return PemesananScreen(
            id: args.id,
            id_jadwal: args.id_jadwal,
            namaKapal: args.namaKapal,
            isPenumpang: args.isPenumpang,
            isKendaraan: args.isKendaraan,
          );
        },
      );
    case '/input-penumpang':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as InputPenumpangScreen;
          return InputPenumpangScreen(
            id: args.id,
            jadwal: args.jadwal,
            dewasa: args.dewasa,
            balita: args.balita,
            idTiket: args.idTiket,
            idKendaraan: args.idKendaraan,
            total: args.total,
            kelas: args.kelas,
            namaKendaraan: args.namaKendaraan,
          );
        },
      );
    case '/pembayaran':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as PembayaranScreen;
          return PembayaranScreen(
            no_rek1: args.no_rek1,
            no_rek2: args.no_rek2,
            atas_nama1: args.atas_nama1,
            atas_nama2: args.atas_nama2,
            dewasa: args.dewasa,
            balita: args.balita,
            kendaraan: args.kendaraan,
            total: args.total,
            tenggat: args.tenggat,
            isPenumpang: args.isPenumpang,
            isKendaraan: args.isKendaraan,
          );
        },
      );
    case '/riwayat':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as RiwayatScreen;
          return RiwayatScreen(
            id: args.id,
          );
        },
      );
    case '/profil':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const ProfilScreen();
        },
      );
    case '/form-input-penumpang':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as FormINputDataPenumpang;
          return FormINputDataPenumpang(
            isDewasa: args.isDewasa,
          );
        },
      );
    case '/ringkasan-pemesanan':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as RingkasanPesananScreen;
          return RingkasanPesananScreen(
            list: args.list,
            booking: args.booking,
            jadwal: args.jadwal,
            kelas: args.kelas,
            kendaraan: args.kendaraan,
          );
        },
      );
    case '/detail-tiket':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as DetailTiketScreen;
          return DetailTiketScreen(
            nama: args.nama,
            km: args.km,
            no_tiket: args.no_tiket,
            penumpang: args.penumpang,
            telp_penumpang: args.telp_penumpang,
            jumlah: args.jumlah,
            tgl_berangkat: args.tgl_berangkat,
            tgl_tiba: args.tgl_tiba,
            kelas: args.kelas,
            kendaraan: args.kendaraan,
            pemesan: args.pemesan,
            telp_pemesan: args.telp_pemesan,
            awal: args.awal,
            akhir: args.akhir,
            tipe: args.tipe,
            isPenumpang: args.isPenumpang,
            isKendaraan: args.isKendaraan,
          );
        },
      );
    default:
  }
}
