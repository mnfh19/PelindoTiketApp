<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\KapalModel;
use App\RuteModel;

class KapalController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data['get'] = KapalModel::select('kapal.*', 'rute.*')
        ->join('rute', 'kapal.id_rute', '=', 'rute.id_rute')
        ->get();
        return view('page/kapal/kapal', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $data['rute'] = RuteModel::all();
        return view('page/kapal/add_kapal', $data);
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
            'KM' => 'required|max:255',
            'nama_kapal' => 'required',
            'id_rute' => 'required',
            'jenis_kapal' => 'required',
            'muatan' => 'required|numeric',
            'status_kapal' => 'required|numeric',
        ]);
        $show = KapalModel::create($validatedData);

        return redirect('/kapal')->with('success', 'Sukses Tersimpan');
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
        $kapal = KapalModel::findOrFail($id);
        $data['rute'] = RuteModel::all();

        return view('page/kapal/edit_kapal', $data, compact('kapal'));
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
        $validatedData = $request->validate([
            'KM' => 'required|max:255',
            'nama_kapal' => 'required',
            'id_rute' => 'required',
            'jenis_kapal' => 'required',
            'muatan' => 'required|numeric',
            'status_kapal' => 'required|numeric',
        ]);
        KapalModel::where('id_kapal', $id)->update($validatedData);


        return redirect('/kapal')->with('success', 'Sukses Tersimpan');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $del = KapalModel::findOrFail($id);
        $del->delete();

        return true;
    }
}
