@extends('master')


@section('content')
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Ubah Kapal</h1>
        </div>


        <div class="row">

            <div class="col-lg-12">

                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul>
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div><br />
                @endif

                <!-- Basic Card Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Form Ubah</h6>
                    </div>
                    <div class="card-body">
                        <form method="POST" action="{{ route('kapal.update', $kapal->id_kapal ) }}">
                            @csrf
                            @method('PATCH')
                            <div class="form-group">
                                <label>KM</label>
                                <input type="text" class="form-control" name="KM" placeholder="" value="{{$kapal->KM}}">
                            </div>
                            <div class="form-group">
                                <label>Nama Pelayaran Kapal</label>
                                <input type="text" class="form-control" name="nama_kapal" placeholder="" value="{{$kapal->nama_kapal}}">
                            </div>
                            <div class="form-group">
                                <label>Rute</label>
                                <input type="hidden" value="{{$kapal->id_rute}}" class="getIDRute">
                                <select class="form-control rute" name="id_rute">
                                    @foreach ($rute as $d)
                                        <option value="{{$d->id_rute}}" >
                                            {{$d->rute_awal}} ⇆ {{$d->rute_akhir}}
                                        </option>
                                    @endforeach

                                </select>
                            </div>
                            <div class="form-group">
                                <label>Jenis Kapal</label>
                                <input type="hidden" class="jenisKapal" value="{{$kapal->jenis_kapal}}">
                                <select class="form-control jenis" name="jenis_kapal">

                                    <option value="Penumpang">Penumpang</option>
                                    <option value="Kendaraan">Kendaraan</option>
                                    <option value="Penumpang & Kendaraan">Penumpang & Kendaraan</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Muatan</label>
                                <input type="number" class="form-control" name="muatan" placeholder="" value="{{$kapal->muatan}}">
                            </div>
                            <div class="form-group">
                                <label>Status</label>
                                <input type="hidden" class="statusKapal" value="{{$kapal->status_kapal}}">
                                <select class="form-control status" name="status_kapal">
                                    <option value="1">Aktif</option>
                                    <option value="0">NonAktif</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary float-right">

                                <span class="text">Ubah</span>
                            </button>
                        </form>
                    </div>
                </div>

            </div>

        </div>

    </div>
@endsection

@section('js')
<script>
   $(document).ready(function(){
    var rute = $(".getIDRute").val();
    $(".rute").val(rute);
    var jenis = $(".jenisKapal").val();
    $(".jenis").val(jenis);
    var status = $(".statusKapal").val();
    $(".status").val(status);
   });
</script>
@endsection
