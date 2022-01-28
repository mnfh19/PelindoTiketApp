<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\BookingModel;
use App\TiketModel;
use App\TiketKendaraanModel;
use App\PenumpangModel;
use App\JadwalModel;
use App\KapalModel;
use App\RuteModel;
use App\QTiketModel;
use App\GraphModel;
use JsonException;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class LaporanController extends Controller
{
    function dashboard(){


        $now = Carbon::now();
        $hariini = BookingModel::get();


        // //Card
        $today = 0;
        $monthly = 0;
        $bayar = 0;
        foreach ($hariini as $d) {
            $dt = Carbon::parse($d->tgl_booking);
            $tgl = $dt->toDateString();
            $bln = $dt->format('m');
            if ($tgl == $now->toDateString()) {
                $today += $d->harga_total;
            }

            if ($bln == $now->month) {
                $monthly +=  $d->harga_total;
            }

            if ($d->status_booking == 1) {
                $bayar++;
            }



        }


        // line Graph
        $bookPerBulan = BookingModel::select('id_booking', 'tgl_booking')
                        ->get()
                        ->groupBy(function ($date) {
                            return Carbon::parse($date->tgl_booking)->format('m');
                        });

        $usermcount = [];
        $userArr = [];

        foreach ($bookPerBulan as $key => $value) {
            $usermcount[(int)$key] = count($value);
        }

        for ($i = 1; $i <= 12; $i++) {
            if (!empty($usermcount[$i])) {
                $dat = GraphModel::where('month',$i)->first();
                $userArr[] = $dat->total;
            } else {
                $userArr[] = 0;
            }
        }

        //PIE Graph
        // $booking= BookingModel::all();
        // $kapal = KapalModel::get();



        // foreach ($kapal as $d) {
        //     $tiketP['penumpang'][$d->id_kapal] = 0;
        // }



        // foreach ($booking as $d) {
        //     if ($d->penumpang_dewasa != 0) {

        //         $tiket = QTiketModel::where('id_tiket', $d->id_tiket)->get();
        //         foreach ($tiket as $e) {
        //             $tot = BookingModel::where('id_tiket', $e->id_tiket)->get();
        //             $total = 0;
        //             foreach ($tot as $f) {
        //                 $total += $f->penumpang_balita + $f->penumpang_dewasa;
        //             }
        //             echo $e->id_tiket." terjual ".$total."</br>";
        //             $tiketP['penumpang'][$e->id_kapal] = $total;

        //         }
        //     }

        //     if ($d->id_tiket_kendaraan != 0) {

        //         $tiket = QTiketModel::where('id_tiket', $d->id_tiket)->get();
        //         foreach ($tiket as $e) {
        //             $tot = BookingModel::where('id_tiket', $e->id_tiket)->get();
        //             $total = 0;
        //             foreach ($tot as $f) {
        //                 $total += $f->penumpang_balita + $f->penumpang_dewasa;
        //             }
        //             echo $e->id_tiket." terjual ".$total."</br>";
        //             $tiketP['penumpang'][$e->id_kapal] = $total;

        //         }
        //     }
        // }





        // echo json_encode($monthly);

        $data['bayar'] = $bayar;
        $data['monthly'] = $monthly;
        $data['today'] = $today;
        $data['line_graph'] = $userArr;

        return view('page/dashboard', $data);
    }

    public function index()
    {

        $data['booking'] = BookingModel::get();
        foreach ($data['booking'] as $d) {



            if ($d->id_tiket != 0) {
                $data['tiket'][$d->id_booking] = TiketModel::where('id_tiket', $d->id_tiket)->first();
                $data['jadwal'][$d->id_booking] = JadwalModel::where('id_jadwal', $data['tiket'][$d->id_booking]->id_jadwal)->first();
                $data['kapal'][$d->id_booking] = KapalModel::where('id_kapal', $data['jadwal'][$d->id_booking]->id_kapal)->first();
                $data['rute'][$d->id_booking] = RuteModel::where('id_rute', $data['kapal'][$d->id_booking]->id_rute)->first();

                $data['booking']->kelas_tiket = $data['tiket'][$d->id_booking]->kelas_tiket;
            }else {
                $data['tiket'][$d->id_booking] = new TiketModel();
                $data['tiket'][$d->id_booking]->kelas_tiket = "-";

            }

            if ($d->id_tiket_kendaraan != 0) {
                $data['tiket_kendaraan'][$d->id_booking] = TiketKendaraanModel::where('id_tiket_kendaraan', $d->id_tiket_kendaraan)->first();
                $data['jadwal'][$d->id_booking] = JadwalModel::where('id_jadwal', $data['tiket_kendaraan'][$d->id_booking]->id_jadwal)->first();
                $data['kapal'][$d->id_booking] = KapalModel::where('id_kapal', $data['jadwal'][$d->id_booking]->id_kapal)->first();
                $data['rute'][$d->id_booking] = RuteModel::where('id_rute', $data['kapal'][$d->id_booking]->id_rute)->first();
            }else {
                $data['tiket_kendaraan'][$d->id_booking] = new TiketModel();
                $data['tiket_kendaraan'][$d->id_booking]->jenis_kendaraan = "-";
                // $penumpang = 0;
            }

            $penumpang = PenumpangModel::where('id_booking', $d->id_booking)->get();
            if ($penumpang->isEmpty()) {
                $data['penumpang'][$d->id_booking] = "Kosong";
            }else {
                $data['penumpang'][$d->id_booking] = $penumpang;
            }
        }

        $data['jalan'] = RuteModel::get();

        return view('page/laporan/laporan', $data);
        // echo json_encode($data['tiket'][1]);
    }

    public function filtered($awal, $akhir, $nama)
    {

        $book = BookingModel::whereBetween('reservation_from', [$awal, ""])->get();
        json_encode($book);

        // $data['booking'] = BookingModel::get();
        // foreach ($data['booking'] as $d) {

        //     if ($d->id_tiket != 0) {
        //         $data['tiket'][$d->id_booking] = TiketModel::where('id_tiket', $d->id_tiket)->first();
        //         $data['jadwal'][$d->id_booking] = JadwalModel::where('id_jadwal', $data['tiket'][$d->id_booking]->id_jadwal)->first();
        //         $data['kapal'][$d->id_booking] = KapalModel::where('id_kapal', $data['jadwal'][$d->id_booking]->id_kapal)->first();
        //         $data['rute'][$d->id_booking] = RuteModel::where('id_rute', $data['kapal'][$d->id_booking]->id_rute)->first();

        //         $data['booking']->kelas_tiket = $data['tiket'][$d->id_booking]->kelas_tiket;
        //     }else {
        //         $data['tiket'][$d->id_booking] = new TiketModel();
        //         $data['tiket'][$d->id_booking]->kelas_tiket = "-";

        //     }

        //     if ($d->id_tiket_kendaraan != 0) {
        //         $data['tiket_kendaraan'][$d->id_booking] = TiketKendaraanModel::where('id_tiket_kendaraan', $d->id_tiket_kendaraan)->first();
        //         $data['jadwal'][$d->id_booking] = JadwalModel::where('id_jadwal', $data['tiket_kendaraan'][$d->id_booking]->id_jadwal)->first();
        //         $data['kapal'][$d->id_booking] = KapalModel::where('id_kapal', $data['jadwal'][$d->id_booking]->id_kapal)->first();
        //         $data['rute'][$d->id_booking] = RuteModel::where('id_rute', $data['kapal'][$d->id_booking]->id_rute)->first();
        //     }else {
        //         $data['tiket_kendaraan'][$d->id_booking] = new TiketModel();
        //         $data['tiket_kendaraan'][$d->id_booking]->jenis_kendaraan = "-";
        //         // $penumpang = 0;
        //     }

        //     $penumpang = PenumpangModel::where('id_booking', $d->id_booking)->get();
        //     if ($penumpang->isEmpty()) {
        //         $data['penumpang'][$d->id_booking] = "Kosong";
        //     }else {
        //         $data['penumpang'][$d->id_booking] = $penumpang;
        //     }
        // }

        // return view('page/laporan/laporan', $data);

    }

    function filteran($nama, $awal, $akhir){

    }
}
