<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class C_Main extends Controller
{
    function index(){
        return view('page/dashboard');
    }

    function admin(){
        return view('page/admin/admin');
    }

    function add_admin(){
        return view('page/admin/add_admin');
    }

    function user(){
        return view('page/user/user');
    }

    function add_user(){
        return view('page/user/add_user');
    }

    function kapal(){
        return view('page/kapal/kapal');
    }

    function add_kapal(){
        return view('page/kapal/add_kapal');
    }

    function rute(){
        return view('page/rute/rute');
    }

    function add_rute(){
        return view('page/rute/add_rute');
    }

    function jadwal(){
        return view('page/jadwal/jadwal');
    }

    function add_jadwal(){
        return view('page/jadwal/add_jadwal');
    }

    function detail_tiket(){
        return view('page/jadwal/detail_tiket');
    }

    function booking(){
        return view('page/booking/booking');
    }

    function laporan(){
        return view('page/laporan/laporan');
    }



}
