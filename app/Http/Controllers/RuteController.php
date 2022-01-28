<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\RuteModel;

class RuteController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data['get'] = RuteModel::all();
        return view('page/rute/rute',$data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('page/rute/add_rute');
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
            'rute_awal' => 'required',
            'rute_akhir' => 'required',
        ]);

        RuteModel::create($validatedData);

        return redirect('/rute')->with('success', 'Sukses Tersimpan');
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
        $rute = RuteModel::findOrFail($id);

        return view('page/rute/edit_rute', compact('rute'));
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
            'rute_awal' => 'required',
            'rute_akhir' => 'required',
        ]);

        RuteModel::where('id_rute', $id)->update($validatedData);

        return redirect('/rute')->with('success', 'Sukses Tersimpan');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $del = RuteModel::findOrFail($id);
        $del->delete();

        return true;
    }
}
