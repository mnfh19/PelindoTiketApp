<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\BookingModel;
use App\TiketModel;
use App\TiketKendaraanModel;
use App\PenumpangModel;
use App\PenumpangTempModel;
use App\JadwalModel;
use App\KapalModel;

use App\UserModel;
use Carbon\Carbon;

class BookingController extends Controller
{
    public function index()
    {
        $data['get'] = BookingModel::select('booking.*', 'user.*')
                                    ->join('user', 'booking.id_user', '=', 'user.id_user')
                                    ->get();
        return view('page/booking/booking', $data);
        // dd($data);
    }

    public function getDetailTiket($id){
        // $data = BookingModel::select('booking.id_booking', 'penumpang.*', 'tiket.*', 'tiket_kendaraan.*', 'kapal.*', 'rute.*', 'jadwal.*')
        //             ->join('tiket', 'booking.id_tiket', '=', 'tiket.id_tiket')
        //             ->join('tiket_kendaraan', 'booking.id_tiket_kendaraan', '=', 'tiket_kendaraan.id_tiket_kendaraan')
        //             ->join('user', 'booking.id_user', '=', 'user.id_user')
        //             ->get();

        $booking = BookingModel::where('id_booking', $id)->first();



        if ($booking->id_tiket != 0) {
            $tiket = TiketModel::where('id_tiket', $booking->id_tiket)->first();
            $jadwal = JadwalModel::where('id_jadwal', $tiket->id_jadwal)->first();
        }

        if ($booking->id_tiket_kendaraan != 0) {
            $tiketKend = TiketKendaraanModel::where('id_tiket_kendaraan', $booking->id_tiket_kendaraan)->first();
            $jadwal = JadwalModel::where('id_jadwal', $tiketKend->id_jadwal)->first();
        }


        $kapal = KapalModel::select('kapal.*', 'rute.*')
                                ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                ->where('id_kapal', $jadwal->id_kapal)
                                ->first();

        $penumpang = PenumpangModel::where('id_booking', $id)->get();

        $balita = [];
        $dewasa = [];

        $bal= 0;
        $dew= 0;
        foreach ($penumpang as $d) {
            if ($d->jenis_penumpang == 1) {

                $dewasa[$dew++] = $d->nama_penumpang;
            }

            if ($d->jenis_penumpang == 0) {

                $balita[$bal++] = $d->nama_penumpang;
            }
        }



        $data = [
            "nama_kapal" => $kapal->nama_kapal,
            "km" => $kapal->km,
            "tgl_berangkat" => \Carbon\Carbon::parse($jadwal->tgl_berangkat)->translatedFormat('j F Y'),
            "tgl_tiba" => \Carbon\Carbon::parse($jadwal->tgl_tiba)->translatedFormat('j F Y'),
            "jam_berangkat" => \Carbon\Carbon::parse($jadwal->jam_berangkat)->translatedFormat('H:i')." WIB",
            "jam_tiba" => \Carbon\Carbon::parse($jadwal->jam_tiba)->translatedFormat('H:i')." WIB",
            "lama_perjalanan" => $jadwal->lama_perjalanan,
            "rute" => $kapal->rute_awal." ⇆ ".$kapal->rute_akhir,
            "kendaraan" => $booking->id_tiket_kendaraan != 0 ? $tiketKend->jenis_kendaraan : "",
            "kelas_tiket" => $booking->id_tiket != 0 ? $tiket->kelas_tiket : "",
            "harga_balita" => $booking->id_tiket != 0 ? $tiket->harga_balita : 0,
            "harga_dewasa" => $booking->id_tiket != 0 ? $tiket->harga_dewasa : 0,
            "penumpang_dewasa" => $booking->penumpang_dewasa,
            "penumpang_balita" => $booking->penumpang_balita,
            "harga_kendaraan" => $booking->id_tiket_kendaraan != 0 ? $tiketKend->harga : 0,
            "total_balita" => $booking->id_tiket != 0 ? $tiket->harga_balita*$booking->penumpang_balita : 0,
            "total_dewasa" => $booking->id_tiket != 0 ? $tiket->harga_dewasa*$booking->penumpang_dewasa : 0,
            "harga_total" => $booking->harga_total,
        ];

        // echo json_encode($dewasa);
        // echo response()->json([ 'dewasa' => $dewasa, 'balita' => $dew  ]);
        echo json_encode(array("main" => $data, "list_dewasa" => $dewasa, "list_balita" => $balita));
    }

    public function cetakTiket($id){
        $get = PenumpangModel::where('id_booking', $id)->get();
        echo json_encode($get);
    }

    public function book(Request $r){

        $date = Carbon::parse($r->tgl_booking)->translatedFormat('dmYhi');
        $no_booking = $r->id_user.$r->id_tiket.$r->id_tiket_kendaraan.$date;


        $book = BookingModel::create([
            'no_booking' => $no_booking,
            'id_tiket' => $r->id_tiket,
            'id_tiket_kendaraan' => $r->id_tiket_kendaraan,
            'id_user' => $r->id_user,
            'penumpang_dewasa' => $r->penumpang_dewasa,
            'penumpang_balita' => $r->penumpang_balita,
            'harga_total' => $r->harga_total,
            'tgl_booking' => $r->tgl_booking,
            'status_booking' => 0,
            'bukti_pembayaran' => ' ',
            'status_bayar' => 0,
        ]);

        if($book){
            $data = PenumpangTempModel::where('id_user', $r->id_user)->get();
            foreach ($data as $d) {
                $random = rand ( 1000 , 9999 );
                $no_tiket = $date.$random;

                PenumpangModel::create([
                        'id_booking' => $book->id_booking,
                        'no_tiket' => $no_tiket,
                        'jenis_penumpang' => $d->jenis_penumpang,
                        'nama_penumpang' => $d->nama_penumpang,
                        'jenis_identitas' => $d->jenis_identitas,
                        'no_identitas' => $d->no_identitas,
                        'ttl' => $d->ttl,
                        'jenis_kelamin' => $d->jenis_kelamin,
                        'telp' => $d->telp,
                ]);


            }

            PenumpangTempModel::where('id_user', $r->id_user)->delete();

            return response()->json([
                'respon' => true,
            ]);
        }


    }


    public function accPembayaran(Request $request){
        if ($request->hasFile('image')) {
            $name = time() . "_" . $request->file('image')->getClientOriginalName();
            $request->file('image')->move(public_path('images'), $name);
        }

        return $name;
    }

    public function setPembayaran(Request $r){

        BookingModel::where('id_booking', '=', $r->id_booking)->update(['status_bayar' => 1, 'bukti_pembayaran' => $r->bukti]);
        return response()->json([
            'respon' => true,
            'msg' => 'Berhasil Upload Bukti Pembayaran, silahkan tunggu konfirmasi dari admin'
        ], 200);
    }

    public function status($id){
        $get = BookingModel::where('id_user', $id)
                            ->orderBy('id_booking', 'desc')->first();

        if(empty($get)){
            return response()->json($get);
        }


        if($get->id_tiket != 0){
            $pick = BookingModel::select('booking.*', 'jadwal.*', 'tiket.*', 'kapal.*', 'rute.*')
                                    ->join('tiket', 'booking.id_tiket', '=', 'tiket.id_tiket')
                                    ->join('jadwal', 'tiket.id_jadwal', '=', 'jadwal.id_jadwal')
                                    ->join('kapal', 'jadwal.id_kapal', '=', 'kapal.id_kapal')
                                    ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                    ->where('id_booking', $get->id_booking)->first();
        }

        if($get->id_tiket_kendaraan != 0){
            $pick = BookingModel::select('booking.*', 'jadwal.*', 'tiket_kendaraan.*', 'kapal.*', 'rute.*')
                                    ->join('tiket_kendaraan', 'booking.id_tiket_kendaraan', '=', 'tiket_kendaraan.id_tiket_kendaraan')
                                    ->join('jadwal', 'tiket_kendaraan.id_jadwal', '=', 'jadwal.id_jadwal')
                                    ->join('kapal', 'jadwal.id_kapal', '=', 'kapal.id_kapal')
                                    ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                    ->where('id_booking', $get->id_booking)->first();
        }

        if($get->id_tiket != 0 &&$get->id_tiket_kendaraan != 0){
            $pick = BookingModel::select('booking.*', 'jadwal.*', 'tiket.*', 'kapal.*', 'rute.*', 'tiket_kendaraan.*')
                                    ->join('tiket', 'booking.id_tiket', '=', 'tiket.id_tiket')
                                    ->join('tiket_kendaraan', 'booking.id_tiket_kendaraan', '=', 'tiket_kendaraan.id_tiket_kendaraan')
                                    ->join('jadwal', 'tiket.id_jadwal', '=', 'jadwal.id_jadwal')
                                    ->join('kapal', 'jadwal.id_kapal', '=', 'kapal.id_kapal')
                                    ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
                                    ->where('id_booking', $get->id_booking)->first();
        }

        return response()->json($pick);
        // echo $get->status_booking;
    }

    public function getPenumpang($id){
        $get = PenumpangModel::where('id_booking', $id)->get();
        echo json_encode($get);
    }

    public function konfirmasiBooking($id){
        BookingModel::where('id_booking', '=', $id)->update(['status_booking' => 2]);
        return true;
    }

}
