<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\PenumpangModel;
use App\PenumpangTempModel;
use Carbon\Carbon;

class PenumpangController extends Controller
{

    public function __construct()
    {
        setlocale(LC_ALL, 'id_ID.UTF8', 'id_ID.UTF-8', 'id_ID.8859-1', 'id_ID', 'IND.UTF8', 'IND.UTF-8', 'IND.8859-1', 'IND', 'Indonesian.UTF8', 'Indonesian.UTF-8', 'Indonesian.8859-1', 'Indonesian', 'Indonesia', 'id', 'ID', 'en_US.UTF8', 'en_US.UTF-8', 'en_US.8859-1', 'en_US', 'American', 'ENG', 'English');

    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = PenumpangModel::get();
        return response()->json($data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create($id)
    {

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $r)
    {
        $data = PenumpangTempModel::where('id_user', $r->id_user)->get();
        foreach ($data as $d) {
           PenumpangTempModel::create([
                'id_booking' => $d->id_user,
                'jenis_penumpang' => $d->jenis_penumpang,
                'nama_penumpang' => $d->nama_penumpang,
                'jenis_identitas' => $d->jenis_identitas,
                'no_identitas' => $d->no_identitas,
                'ttl' => $d->ttl,
                'jenis_kelamin' => $d->jenis_kelamin,
                'telp' => $d->telp,
            ]);
        }
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
    public function getTempDewasa($id){
        $data = PenumpangTempModel::where('id_user', $id)->where('jenis_penumpang', 1)->get();
        return response()->json($data);
    }

    public function getTempBalita($id){
        $data = PenumpangTempModel::where('id_user', $id)->where('jenis_penumpang', 0)->get();
        return response()->json($data);
    }

    public function insertTemp(Request $r){
        $data = PenumpangTempModel::create([
            'id_user' => $r->id_user,
            'jenis_penumpang' => $r->jenis_penumpang,
            'nama_penumpang' => $r->nama_penumpang,
            'jenis_identitas' => $r->jenis_identitas,
            'no_identitas' => $r->no_identitas,
            'ttl' => $r->ttl,
            'jenis_kelamin' => $r->jenis_kelamin,
            'telp' => $r->telp,
        ]);

        if($data){
            return response()->json([
                'respon' => true,
            ]);
        }
    }



}
