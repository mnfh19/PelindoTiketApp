<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class RuteModel extends Model
{
    protected $primaryKey = 'id_rute';
    protected $table = 'rute';
    protected $guarded = [];
    public $timestamps = false;
}
