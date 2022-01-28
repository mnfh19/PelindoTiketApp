<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\JadwalModel;
use App\TiketModel;
use App\BookingModel;
use App\TiketKendaraanModel;

class TiketController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {

        $jadwal = JadwalModel::select('jadwal.*', 'kapal.*', 'rute.*')
                                    ->join('kapal', 'jadwal.id_kapal', '=', 'kapal.id_kapal')
                                    ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                    ->where('id_jadwal', $id)
                                    ->first();
        if ($jadwal->jenis_kapal == "Penumpang") {
            $get = TiketModel::where('id_jadwal', $id)->get();

            foreach ($get as $d) {
                $tot = BookingModel::where('id_tiket', $d->id_tiket)->get();
                $total = 0;
                foreach ($tot as $e) {
                    $total += $e->penumpang_balita + $e->penumpang_dewasa;
                }

                $d->sisa_tiket = $d->jumlah_tiket - $total;
            }
            $data['penumpang'] = $get;

        }else if($jadwal->jenis_kapal == "Kendaraan"){
            $get = TiketKendaraanModel::where('id_jadwal', $id)->get();
            foreach ($get as $d) {
                $total = BookingModel::where('id_tiket_kendaraan', $d->id_tiket_kendaraan)->count();

                $d->sisa_tiket = $d->jumlah_tiket - $total;
            }
            $data['kendaraan'] =$get;
        }else {
            $penumpang = TiketModel::where('id_jadwal', $id)->get();
            $kendaraan = TiketKendaraanModel::where('id_jadwal', $id)->get();

            foreach ($penumpang as $d) {
                $tot = BookingModel::where('id_tiket', $d->id_tiket)->get();
                $total = 0;
                foreach ($tot as $e) {
                    $total += $e->penumpang_balita + $e->penumpang_dewasa;
                }

                $d->sisa_tiket = $d->jumlah_tiket - $total;
            }

            foreach ($kendaraan as $d) {
                $total = BookingModel::where('id_tiket_kendaraan', $d->id_tiket_kendaraan)->count();

                $d->sisa_tiket = $d->jumlah_tiket - $total;
            }
            $data['penumpang'] = $penumpang;
            $data['kendaraan'] = $kendaraan;
        }

        return view('page/jadwal/detail_tiket', compact('jadwal'), $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
