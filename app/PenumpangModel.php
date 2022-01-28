<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PenumpangModel extends Model
{
    protected $primaryKey = 'id_penumpang';
    protected $table = 'penumpang';
    protected $guarded = [];
    public $timestamps = false;
}
