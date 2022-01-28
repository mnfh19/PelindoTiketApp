<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TiketKendaraanModel extends Model
{
    protected $primaryKey = 'id_tiket_kendaraan';
    protected $table = 'tiket_kendaraan';
    protected $guarded = [];
    public $timestamps = false;
}
