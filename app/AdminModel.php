<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AdminModel extends Model
{
    protected $primaryKey = 'id_admin';
    protected $table = 'admin';
    protected $guarded = [];
    public $timestamps = false;
}
