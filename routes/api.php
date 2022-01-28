<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/login', 'UserController@login');
Route::post('/register', 'UserController@register');
Route::post('/sendAgain', 'UserController@send_again');
Route::post('/pin', 'UserController@aktivasi');

Route::get('/rute', 'GetController@getRute');
Route::get('/getRuteAwal', 'GetController@getRuteAwal');
Route::get('/getRuteAkhir', 'GetController@getRuteAkhir');
Route::post('/kapalWhereRute', 'GetController@getKapalRuteJadwal');
// Route::get('/kapalWhereRute/{awal}/{akhir}/{tgl}', 'GetController@getKapalRuteJadwal');
// Route::get('/kapalWhereRute/{id}', 'GetController@getKapalRuteJadwal');
Route::get('/getKelasKapalPenumpang/{id}', 'GetController@getKelasKapalPenumpang');
Route::get('/getKelasKapalKendaraan/{id}', 'GetController@getKelasKapalKendaraan');


Route::get('/getTempPenumpangDewasa/{id}', 'PenumpangController@getTempDewasa');
Route::get('/getTempPenumpangBalita/{id}', 'PenumpangController@getTempBalita');
Route::post('/createTempPenumpang', 'PenumpangController@insertTemp');


Route::post('/booking', 'BookingController@book');

Route::get('/getStatusBooking/{id}', 'BookingController@status');
Route::get('/getPenumpangTiket/{id}', 'BookingController@getPenumpang');


Route::get('/getUser', 'UserController@getUser');

Route::get('/getKapalJadwal/{id}', 'GetController@getKapalJadwal');

Route::post('/getPembayaran', 'GetController@getPembayaran');

Route::post('/accPembayaran', 'BookingController@accPembayaran');
Route::post('/setPembayaran', 'BookingController@setPembayaran');
