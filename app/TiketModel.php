<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TiketModel extends Model
{
    protected $primaryKey = 'id_tiket';
    protected $table = 'tiket';
    protected $guarded = [];
    public $timestamps = false;
}
