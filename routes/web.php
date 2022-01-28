<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//php artisan make:controller C_Main
//php artisan make:model M_Main

Route::get('/', 'LaporanController@dashboard')->name('dashboard');
Route::get('/dashboard', 'LaporanController@dashboard')->name('dashboard');


Route::resource('admin', 'AdminController');
Route::resource('user', 'UserController');
Route::resource('kapal', 'KapalController');
Route::resource('rute', 'RuteController');
Route::resource('jadwal', 'JadwalController');
Route::resource('tiket', 'TiketController');

Route::get('/booking', 'BookingController@index')->name('booking');
Route::get('booking/getDetailTiket/{id}', 'BookingController@getDetailTiket');
Route::get('booking/cetakTiket/{id}', 'BookingController@cetakTiket');

// Route::get('/jadwal', 'C_Main@jadwal')->name('jadwal');
// Route::get('/add_jadwal', 'C_Main@add_jadwal')->name('add_jadwal');
Route::get('/masukin', 'JadwalController@masukin');

Route::get('/detail_tiket', 'C_Main@detail_tiket')->name('jadwal');



Route::get('/laporan', 'LaporanController@index')->name('laporan');
Route::get('/laporan/{awal}/{akhir}/{nama}', 'LaporanController@filtered')->name('laporan');
Route::post('/laporan/filteran', 'LaporanController@filteran')->name('laporan');



Route::get('/mail/{mail}', 'UserController@send_verification');

Route::post('/konfirmasiBooking/{id}', 'BookingController@konfirmasiBooking');
