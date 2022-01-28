@extends('master')


@section('content')
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Tambah Kapal</h1>
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
                        <h6 class="m-0 font-weight-bold text-primary">Form Tambah</h6>
                    </div>
                    <div class="card-body">
                        <form method="POST" action="{{ route('kapal.store') }}">
                            @csrf
                            <div class="form-group">
                                <label>KM</label>
                                <input type="text" class="form-control" name="KM" placeholder="">
                            </div>
                            <div class="form-group">
                                <label>Nama Pelayaran Kapal</label>
                                <input type="text" class="form-control" name="nama_kapal" placeholder="">
                            </div>
                            <div class="form-group">
                                <label>Rute</label>
                                <select class="form-control" name="id_rute">
                                    @foreach ($rute as $d)
                                        <option value="{{$d->id_rute}}">
                                            {{$d->rute_awal}} ⇆ {{$d->rute_akhir}}
                                        </option>
                                    @endforeach

                                </select>
                            </div>
                            <div class="form-group">
                                <label>Jenis Kapal</label>
                                <select class="form-control" name="jenis_kapal">
                                    <option>Penumpang</option>
                                    <option>Kendaraan</option>
                                    <option>Penumpang & Kendaraan</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Muatan</label>
                                <input type="number" class="form-control" name="muatan" placeholder="">
                            </div>
                            <div class="form-group">
                                <label>Status</label>
                                <select class="form-control" name="status_kapal">
                                    <option value="1">Aktif</option>
                                    <option value="0">NonAktif</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary float-right">

                                <span class="text">Tambah</span>
                            </button>
                        </form>
                    </div>
                </div>

            </div>

        </div>

    </div>
@endsection

