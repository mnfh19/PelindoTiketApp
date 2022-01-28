<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class JadwalModel extends Model
{
    protected $primaryKey = 'id_jadwal';
    protected $table = 'jadwal';
    protected $guarded = [];
    public $timestamps = false;
}
