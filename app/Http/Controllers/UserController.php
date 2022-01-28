<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\UserModel;
use App\Mail\VerificationMail;



class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data['get'] = UserModel::all();

        return view('page/user/user', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('page/user/add_user');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'username' => 'required|max:255',
            'email' => 'required|email',
            'pass' => 'required',
            'no_ktp' => 'required|numeric',
            'tanggal' => 'required',
            'tempat' => 'required',
            'jenis_kelamin' => 'required',
            'status_user' => 'required|numeric',
        ]);

        $date =  \Carbon\Carbon::parse($request->tanggal)->locale('id');
        $date->settings(['formatFunction' => 'translatedFormat']);
        $ttl=  $request->tempat.", ".$date->format('j F Y');

        $post = UserModel::create([
            'username' => $request->username,
            'email' => $request->email,
            'pass' => $request->pass,
            'no_ktp' => $request->no_ktp,
            'ttl' => $ttl,
            'telp' => $request->telp,
            'jenis_kelamin' => $request->jenis_kelamin,
            'status_user' => $request->status_user,
        ]);

        return redirect('/user')->with('success', 'Sukses Tersimpan');

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

    public function login(Request $r){
        $user = UserModel::where('email', $r->post('email'))->first();
        $get = UserModel::where('email', $r->post('email'))->get();

        if($get->isEmpty()){
                return response()->json([
                'respon' => false,
                'msg' => 'Email Belum Terdaftar'
            ], 401);
        }

        if($user->pass != $r->post('pass')){
                return response()->json([
                'respon' => false,
                'msg' => 'Password Salah'
            ], 401);
        }

        if($user->status_user == 0){
            return response()->json([
                'respon' => false,
                'msg' => 'User Belum Aktif, Silahkan Aktivasi Akun Anda'
            ], 401);
        }


        return response()->json([
            'respon' => true,
            'user' => $get,
        ], 200);
    }

    public function register(Request $r)
    {
        $digits = 4;
        $pin = rand(pow(10, $digits-1), pow(10, $digits)-1);

        $user = new UserModel();
        $user->username = $r->post('username');
        $user->email = $r->post('email');
        $user->pass = $r->post('pass');
        $user->telp = $r->post('telp');
        $user->status_user = 0;
        $user->pin = $pin;



        if (UserModel::where('email', '=', $user->email)->count() > 0) {
            UserModel::where('email', '=', $user->email)->update(['pin' => $pin]);
         }else {
            $user->save();
         }

        $this->send_verification($user->email, $pin);

        return response()->json([
            'respon' => true
        ], 200);



    }


    public function send_verification($email, $pin){
        $details = [
            'title' => 'Verifikasi Email Anda',
            'body' => 'Silahkan Masukkan PIN Code dibawah ini untuk menyelesaikan aktivasi akun anda',
            'pin' => $pin,
            ];

            Mail::to($email)->send(new \App\Mail\VerificationMail($details));

            return response()->json([
                'respon' => true,
                'msg' => 'Email Terkirim, Silahkan Cek Email untuk Aktivasi Akun'
            ], 200);
    }

    public function send_again(Request $r){
        $digits = 4;
        $pin = rand(pow(10, $digits-1), pow(10, $digits)-1);

        if (UserModel::where('email', '=', $r->email)->count() > 0) {
            UserModel::where('email', '=', $r->email)->update(['pin' => $pin]);
         }else {
            return response()->json([
                'respon' => false,
                'msg' => 'Email Tidak Ditemukan, Silahkan cek kembali apakah anda sudah registrasi',
            ], 401);
         }

        $details = [
            'title' => 'Verifikasi Email Anda',
            'body' => 'Silahkan Masukkan PIN Code dibawah ini untuk menyelesaikan aktivasi akun anda',
            'pin' => $pin,
            ];

            Mail::to($r->email)->send(new \App\Mail\VerificationMail($details));

            return response()->json([
                'respon' => true,
                'msg' => 'Email Terkirim, Silahkan Cek Email untuk Aktivasi Akun'
            ], 200);
    }

    public function aktivasi(Request $r){
        $d = UserModel::where('email', $r->email)->first();
        if($d->pin == $r->pin){
            UserModel::where('email', '=', $r->email)->update(['status_user' => 1]);
            return response()->json([
                'respon' => true,
                'msg' => 'Akun Berhasil Diaktivasi, Anda Sudah bisa melakukan login'
            ], 200);
        }else {
            return response()->json([
                'respon' => false,
                'msg' => 'Pin Salah, Silahkan Cek Kembali'
            ], 401);
        }
    }

    public function getUser(){
        $get = UserModel::get();
        echo json_encode($get);
    }
}
