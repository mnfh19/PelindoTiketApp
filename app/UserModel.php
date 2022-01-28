<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserModel extends Model
{
    protected $primaryKey = 'id_user';
    protected $table = 'user';
    protected $guarded = [];
    public $timestamps = false;
}
