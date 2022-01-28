<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class KapalModel extends Model
{
    protected $primaryKey = 'id_kapal';
    protected $table = 'kapal';
    protected $guarded = [];
    public $timestamps = false;
}
