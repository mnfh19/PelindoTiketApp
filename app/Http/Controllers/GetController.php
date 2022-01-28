<?php

namespace App\Http\Controllers;

use App\KapalModel;
use Illuminate\Http\Request;
use App\RuteModel;
use App\JadwalModel;
use App\BookingModel;
use App\TiketModel;
use App\TiketKendaraanModel;

class GetController extends Controller
{
    public function getRute(){
        $data = RuteModel::all();
        return response()->json($data);
    }

    public function getRuteAwal(){
        $data = RuteModel::groupBy('rute_awal')->pluck('rute_awal');
        return response()->json($data);
    }

    public function getRuteAkhir(){
        $data = RuteModel::groupBy('rute_akhir')->pluck('rute_akhir');
        return response()->json($data);
    }

    public function getKapalRuteJadwal(Request $r){

        $checkRute = RuteModel::where('rute_awal', $r->awal)->where('rute_akhir', $r->akhir)->first();

        //Rute kosong

        if($checkRute == null){
            $data = JadwalModel::select('jadwal.*', "kapal.*")
                            ->join('kapal', 'kapal.id_kapal', '=', 'jadwal.id_kapal')
                            ->where('id_rute', 0)
                            ->where('tgl_berangkat', '>=', $r->tgl)
                            ->get();
            return response()->json($data);
        }

        $data = JadwalModel::select('jadwal.*', "kapal.*")
                            ->join('kapal', 'kapal.id_kapal', '=', 'jadwal.id_kapal')
                            ->where('id_rute', $checkRute->id_rute)
                            ->where('tgl_berangkat', '>=', $r->tgl)
                            ->get();


        foreach ($data as $d) {
            if ($d->jenis_kapal == "Penumpang") {
                $get = TiketModel::where('id_jadwal', $d->id_jadwal)->get();

                foreach ($get as $e) {
                    $tot = BookingModel::where('id_tiket', $e->id_tiket)->get();
                    $total = 0;
                    foreach ($tot as $e) {
                        $total += $e->penumpang_balita + $e->penumpang_dewasa;
                    }

                    $d->sisa_tiket_penumpang += $e->jumlah_tiket - $total;
                }

            }else if($d->jenis_kapal == "Kendaraan"){
                $get = TiketKendaraanModel::where('id_jadwal', $d->id_jadwal)->get();
                foreach ($get as $e) {
                    $total = BookingModel::where('id_tiket_kendaraan', $e->id_tiket_kendaraan)->count();

                    $d->sisa_tiket_kendaraan += $e->jumlah_tiket - $total;
                }
            }else {
                $penumpang = TiketModel::where('id_jadwal', $d->id_jadwal)->get();
                $kendaraan = TiketKendaraanModel::where('id_jadwal', $d->id_jadwal)->get();
                $total_p = 0;
                foreach ($penumpang as $e) {
                    $tot = BookingModel::where('id_tiket', $e->id_tiket)->get();
                    $total = 0;
                    foreach ($tot as $f) {
                        $total += $f->penumpang_balita + $f->penumpang_dewasa;
                    }

                    $total_p += $e->jumlah_tiket - $total;
                }
                $d->sisa_tiket_penumpang = $total_p;

                foreach ($kendaraan as $e) {
                    $acc = BookingModel::where('id_tiket_kendaraan', $e->id_tiket_kendaraan)->count();

                    $d->sisa_tiket_kendaraan += $e->jumlah_tiket - $acc;
                }
            }
        }

        // $data = KapalModel::where('id_rute', $id)->get();
        return response()->json($data);
    }

    public function getKapalRuteJadwalOld($id){
        $data = JadwalModel::select('jadwal.*', "kapal.*")
                            ->join('kapal', 'kapal.id_kapal', '=', 'jadwal.id_kapal')
                            ->where('id_rute', $id)
                            ->get();


        foreach ($data as $d) {
            if ($d->jenis_kapal == "Penumpang") {
                $get = TiketModel::where('id_jadwal', $d->id_jadwal)->get();

                foreach ($get as $e) {
                    $tot = BookingModel::where('id_tiket', $e->id_tiket)->get();
                    $total = 0;
                    foreach ($tot as $e) {
                        $total += $e->penumpang_balita + $e->penumpang_dewasa;
                    }

                    $d->sisa_tiket += $e->jumlah_tiket - $total;
                }

            }else if($d->jenis_kapal == "Kendaraan"){
                $get = TiketKendaraanModel::where('id_jadwal', $d->id_jadwal)->get();
                foreach ($get as $e) {
                    $total = BookingModel::where('id_tiket_kendaraan', $e->id_tiket_kendaraan)->count();

                    $d->sisa_tiket += $e->jumlah_tiket - $total;
                }
            }else {
                $penumpang = TiketModel::where('id_jadwal', $d->id_jadwal)->get();
                $kendaraan = TiketKendaraanModel::where('id_jadwal', $d->id_jadwal)->get();
                $total_p = 0;
                foreach ($penumpang as $e) {
                    $tot = BookingModel::where('id_tiket', $e->id_tiket)->get();
                    $total = 0;
                    foreach ($tot as $f) {
                        $total += $f->penumpang_balita + $f->penumpang_dewasa;
                    }

                    $total_p += $e->jumlah_tiket - $total;
                }
                $d->sisa_tiket_penumpang = $total_p;

                foreach ($kendaraan as $e) {
                    $acc = BookingModel::where('id_tiket_kendaraan', $e->id_tiket_kendaraan)->count();

                    $d->sisa_tiket_kendaraan += $e->jumlah_tiket - $acc;
                }
            }
        }

        // $data = KapalModel::where('id_rute', $id)->get();
        return response()->json($data);
    }

    public function getKelasKapalPenumpang($id){
        $data = TiketModel::where('id_jadwal', $id)->get();
        return response()->json($data);
    }

    public function getKelasKapalKendaraan($id){
        $data = TiketKendaraanModel::where('id_jadwal', $id)->get();
        return response()->json($data);
    }

    public function getKapalJadwal($id){
        $data = JadwalModel::select('jadwal.*', "kapal.*", "rute.*")
                            ->join('kapal', 'kapal.id_kapal', '=', 'jadwal.id_kapal')
                            ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                            ->where('id_jadwal', $id)
                            ->first();
        return response()->json($data);
    }

    public function getPembayaran(Request $r){
        $penum = TiketModel::where('id_tiket', $r->id_tiket)->first();
        $ken = TiketKendaraanModel::where('id_tiket_kendaraan', $r->id_tiket_kendaraan)->first();

        $penumHarBal = 0;
        $penumHarDew = 0;
        $kenHar = 0;

        if($penum){
            $penumHarBal = $penum->harga_balita;
            $penumHarDew = $penum->harga_dewasa;
            $jadwal = JadwalModel::select('jadwal.*', "tiket.*")
                                    ->join('tiket', 'tiket.id_jadwal', '=', 'jadwal.id_jadwal')
                                    ->where('id_tiket', $penum->id_tiket)
                                    ->first();

        }

        if($ken){
            $kenHar = $ken->harga;
            $jadwal = JadwalModel::select('jadwal.*', "tiket_kendaraan.*")
                                    ->join('tiket_kendaraan', 'tiket_kendaraan.id_jadwal', '=', 'jadwal.id_jadwal')
                                    ->where('id_tiket_kendaraan', $ken->id_tiket_kendaraan)
                                    ->first();

        }

        $tenggat = \Carbon\Carbon::parse($jadwal->tgl_berangkat." ".$jadwal->jam_berangkat);

        return response()->json([
            'respon' => true,
            'balita' => $penumHarBal,
            'dewasa' => $penumHarDew,
            'kendaraan' => $kenHar,
            'tenggat' => $tenggat->subHour(6)->format('Y-m-d h:i'),
        ], 200);
    }
}
