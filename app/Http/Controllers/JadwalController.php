<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\KapalModel;
use App\BookingModel;
use App\JadwalModel;
use App\TiketModel;
use App\TiketKendaraanModel;
use DateTime;


class JadwalController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data['get'] = JadwalModel::select('jadwal.*', 'kapal.*', 'rute.*')
                                    ->join('kapal', 'jadwal.id_kapal', '=', 'kapal.id_kapal')
                                    ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                    ->get();
        return view('page/jadwal/jadwal', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $data['kapal'] = KapalModel::select('kapal.*', 'rute.*')
                                    ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                    ->get();
        return view('page/jadwal/add_jadwal', $data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $tgl_awal = new DateTime("$request->tgl_berangkat $request->jam_berangkat");
        $tgl_akhir = new DateTime("$request->tgl_tiba $request->jam_tiba");
        $diff = $tgl_akhir->diff($tgl_awal);

        $days = $diff->d;
        $hours = $diff->h;
        $minutes = $diff->i;
        $hari = "";
        $jam = "";
        $menit = "";
        if ($days != 0) {
            $hari = $days." Hari";
        }
        if($hours != 0){
            $jam = $hours." Jam";
        }
        if($minutes != 0){
            $menit = $minutes." Menit";
        }

        $lama =  $hari." ".$jam." ".$menit;

        $kapal = KapalModel::where('id_kapal', $request->id_kapal)->first();
        $jadwal = JadwalModel::create([
            'id_kapal' => $request->id_kapal,
            'tgl_berangkat' => $request->tgl_berangkat,
            'tgl_tiba' => $request->tgl_tiba,
            'jam_berangkat' => $request->jam_berangkat,
            'jam_tiba' => $request->jam_tiba,
            'lama_perjalanan' => $lama,
            'status_jadwal' => 1,
        ]);

        if ($kapal->jenis_kapal == "Penumpang") {
            $countPenumpang = count($request->kelas_penumpang);
            for ($i=0; $i < $countPenumpang; $i++) {
                TiketModel::create([
                    'id_jadwal' => $jadwal->id_jadwal,
                    'kelas_tiket' => $request->kelas_penumpang[$i],
                    'jumlah_tiket' => $request->jumlah_penumpang[$i],
                    'harga_balita' => $request->balita_penumpang[$i],
                    'harga_dewasa' => $request->dewasa_penumpang[$i],
                ]);
            }
        }else if($kapal->jenis_kapal == "Kendaraan"){
            $countKendaraan = count($request->jenis_kendaraan);
            for ($i=0; $i < $countKendaraan; $i++) {
                TiketKendaraanModel::create([
                   'id_jadwal' => $jadwal->id_jadwal,
                   'jenis_kendaraan' => $request->jenis_kendaraan[$i],
                   'jumlah_tiket' => $request->jumlah_kendaraan[$i],
                   'harga' => $request->harga_kendaraan[$i],
               ]);
           }

        }else {
            $countPenumpang = count($request->kelas_penumpang);
            $countKendaraan = count($request->jenis_kendaraan);
            for ($i=0; $i < $countPenumpang; $i++) {
                TiketModel::create([
                    'id_jadwal' => $jadwal->id_jadwal,
                    'kelas_tiket' => $request->kelas_penumpang[$i],
                    'jumlah_tiket' => $request->jumlah_penumpang[$i],
                    'harga_balita' => $request->balita_penumpang[$i],
                    'harga_dewasa' => $request->dewasa_penumpang[$i],
                ]);
            }
            for ($i=0; $i < $countKendaraan; $i++) {
                TiketKendaraanModel::create([
                   'id_jadwal' => $jadwal->id_jadwal,
                   'jenis_kendaraan' => $request->jenis_kendaraan[$i],
                   'jumlah_tiket' => $request->jumlah_kendaraan[$i],
                   'harga' => $request->harga_kendaraan[$i],
               ]);
           }
        }





        return true;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
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

    //Custom
    public function masukin(){

        

    }
}
