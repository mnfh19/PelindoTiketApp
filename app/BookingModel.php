<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class BookingModel extends Model
{
    protected $primaryKey = 'id_booking';
    protected $table = 'booking';
    protected $guarded = [];
    public $timestamps = false;
}
