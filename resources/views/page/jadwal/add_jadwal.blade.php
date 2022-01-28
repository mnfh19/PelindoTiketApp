@extends('master')

@section('css')
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet"
        type="text/css">
    <style>
        p {
            color: grey
        }

        #heading {
            text-transform: uppercase;
            color: #4e73df;
            font-weight: normal
        }

        #msform {
            text-align: center;
            position: relative;
            margin-top: 20px;
            padding: 18px;
        }

        .card {
            text-align: left !important;
        }

        #msform fieldset:not(:first-of-type) {
            display: none
        }



        #msform .action-button {
            width: 100px;
            background: #4e73df;
            font-weight: bold;
            color: white;
            border: 0 none;
            border-radius: 0px;
            cursor: pointer;
            padding: 10px 5px;
            margin: 10px 0px 10px 5px;
            float: right
        }

        #msform .action-button:hover,
        #msform .action-button:focus {
            background-color: #4e73df
        }

        #msform .action-button-previous {
            width: 100px;
            background: #616161;
            font-weight: bold;
            color: white;
            border: 0 none;
            border-radius: 0px;
            cursor: pointer;
            padding: 10px 5px;
            margin: 10px 5px 10px 0px;
            float: right
        }

        #msform .action-button-previous:hover,
        #msform .action-button-previous:focus {
            background-color: #000000
        }

        .card {
            z-index: 0;
            border: none;
            position: relative
        }

        .fs-title {
            font-size: 25px;
            color: #4e73df;
            margin-bottom: 15px;
            font-weight: normal;
            text-align: left
        }

        .purple-text {
            color: #4e73df;
            font-weight: normal
        }

        .steps {
            font-size: 25px;
            color: gray;
            margin-bottom: 10px;
            font-weight: normal;
            text-align: right
        }

        .fieldlabels {
            color: gray;
            text-align: left
        }

        #progressbar {
            margin-bottom: 30px;
            overflow: hidden;
            color: lightgrey
        }

        #progressbar .active {
            color: #4e73df
        }

        #progressbar li {
            list-style-type: none;
            font-size: 15px;
            width: 33.33%;
            float: left;
            position: relative;
            font-weight: 400
        }

        #progressbar #account:before {
            font-family: FontAwesome;
            content: "\f073"
        }

        #progressbar #personal:before {
            font-family: FontAwesome;
            content: "\f007"
        }

        #progressbar #payment:before {
            font-family: FontAwesome;
            content: "\f0d1"
        }


        #progressbar li:before {
            width: 50px;
            height: 50px;
            line-height: 45px;
            display: block;
            font-size: 20px;
            color: #ffffff;
            background: lightgray;
            border-radius: 50%;
            margin: 0 auto 10px auto;
            padding: 2px
        }

        #progressbar li:after {
            content: '';
            width: 100%;
            height: 2px;
            background: lightgray;
            position: absolute;
            left: 0;
            top: 25px;
            z-index: -1
        }

        #progressbar li.active:before,
        #progressbar li.active:after {
            background: #4e73df
        }

        .progress {
            height: 20px
        }

        .progress-bar {
            background-color: #4e73df
        }

        .fit-image {
            width: 100%;
            object-fit: cover
        }

    </style>
@endsection


@section('content')
    <div class="container-fluid">


        <h1 class="h3 mb-2 text-gray-800">Tambah Jadwal</h1>
        <p class="mb-4">Pengguna dapat menambah jadwal kapal baru, terdapat 3 tahapan yang harus di inputkan untuk
            menambah jadwal baru.</p>

        <div class="row">

            <div class="col-lg-12">
                <div class="card mt-3 mb-3">
                    <form id="msform">
                        <!-- progressbar -->
                        <div class="row justify-content-md-center">
                            <div class="col-lg-10 align-self-center">
                                <ul id="progressbar">
                                    <li class="active" id="account"><strong>Jadwal</strong></li>
                                    <li id="personal"><strong>Tiket Penumpang</strong></li>
                                    <li id="payment"><strong>Tiket Kendaraan</strong></li>
                                </ul>
                            </div>
                        </div>





                        <fieldset>
                            <div class="col-lg-12 mb-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Tambah Jadwal Kapal Baru</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label>Pilih Kapal</label>
                                            <select class="form-control pilihKapal" name="id_kapal">
                                                <option disabled selected hidden>Pilih Kapal</option>
                                                @foreach ($kapal as $d)
                                                    <option value="{{ $d->id_kapal }}"
                                                        data-jenis="{{ $d->jenis_kapal }}">
                                                        {{ $d->nama_kapal }} -
                                                        {{ $d->KM }} ({{ $d->rute_awal }} ⇆ {{ $d->rute_akhir }})
                                                    </option>
                                                @endforeach
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label>Tanggal Berangkat</label>
                                            <input type="date" class="form-control" name="tgl_berangkat" placeholder="">
                                        </div>
                                        <div class="form-group">
                                            <label>Tanggal Tiba</label>
                                            <input type="date" class="form-control" name="tgl_tiba" placeholder="">
                                        </div>
                                        <div class="form-group">
                                            <label>Jam Berangkat</label>
                                            <input type="time" class="form-control" name="jam_berangkat" placeholder="">
                                        </div>
                                        <div class="form-group">
                                            <label>Jam Tiba</label>
                                            <input type="time" class="form-control" name="jam_tiba" placeholder="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="button" name="next" class="next action-button checkForm" value="Next" />
                        </fieldset>
                        <fieldset>
                            <div class="alert alert-danger kendaraanAlert" style="display: none">
                                <span class="alert-text">Anda Memilih Jenis Kapal Kendaraan, Silahkan lewati Form ini</span>
                            </div>
                            <br>
                            <div class="col-lg-12 mb-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <div class="row align-items-center">
                                            <div class="col-lg-12 my-auto">
                                                <span class="m-0 d-flex    font-weight-bold text-primary">Tambah Tiket
                                                    Penumpang</span>
                                                {{-- <a href="{{ url('detail_tiket') }}" style="float: right!important"
                                                class="btn btn-primary">
                                                <span class="text">
                                                    Detail
                                                </span>
                                            </a> --}}
                                            </div>

                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-group row mb-5">
                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Kelas Tiket</label>
                                                <input type="text" class="form-control" id="kelas" value="">
                                            </div>
                                            <div class="col-md-2">
                                                <label class="col-form-label mb-6">Jumlah Tiket</label>
                                                <input type="number" class="form-control" id="jumlah" value="">
                                            </div>

                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Harga Tiket Balita</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">Rp</span>
                                                    </div>
                                                    <input type="number" id="balita" class="form-control"
                                                        aria-label="Balita" aria-describedby="basic-addon1">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Harga Tiket Dewasa</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">Rp</span>
                                                    </div>
                                                    <input type="number" id="dewasa" class="form-control"
                                                        aria-label="Dewasa" aria-describedby="basic-addon1">
                                                </div>
                                            </div>
                                            <div class="col-md-1">
                                                <label class="col-form-label mb-6 text-white">a</label>
                                                <br>
                                                <button type="button" id="tambahTiketPenumpang"
                                                    class="btn btn-success btn-icon-split">
                                                    <span class="icon text-white-50">
                                                        <i class="fas fa-plus"></i>
                                                    </span>
                                                    <span class="text">Tambah</span>
                                                </button>
                                            </div>

                                        </div>

                                        <h3 class="titleTiketPenumpang" style="display: none;">Daftar Tiket</h3>
                                        <div class="loopTiketPenumpang" id="loopTiketPenumpang"> </div>


                                    </div>
                                </div>
                            </div> <input type="button" name="next" class="next action-button" value="Next" /> <input
                                type="button" name="previous" class="previous action-button-previous" value="Previous" />
                        </fieldset>
                        <fieldset>
                            <div class="alert alert-danger penumpangAlert" style="display: none">
                                <span class="alert-text">Anda Memilih Jenis Kapal Penumpang, Silahkan lewati Form
                                    ini</span>
                            </div>
                            <br>
                            <div class="col-lg-12 mb-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Tambah Tiket Kendaraan</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-group row mb-5">
                                            <div class="col-md-4">
                                                <label class="col-form-label mb-6">Jenis Kendaraan</label>
                                                <select class="form-control" id="jenisKendaraan">
                                                    <option hidden>Pilih Jenis Kendaraan</option>
                                                    <option value="Sepeda Motor 2.A (s.d 249CC)">Sepeda Motor 2.A (s.d
                                                        249CC)</option>
                                                    <option value="Truk Sedang 4.B (Kosong)">Truk Sedang 4.B (Kosong)
                                                    </option>
                                                    <option value="Truk Sedang 4.B">Truk Sedang 4.B</option>
                                                    <option value="Kend. Kecil 3.A (s.d 2000CC)">Kend. Kecil 3.A (s.d
                                                        2000CC)</option>
                                                    <option value="Kend. Kecil 3.B (2001CC ke Atas)"> Kend. Kecil 3.B
                                                        (2001CC ke Atas)</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Jumlah Tiket</label>
                                                <input type="number" class="form-control" id="jumlahKendaraan" value="">
                                            </div>

                                            <div class="col-md-4">
                                                <label class="col-form-label mb-6">Harga Tiket</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">Rp</span>
                                                    </div>
                                                    <input type="number" class="form-control" id="hargaKendaraan"
                                                        aria-label="Harga" aria-describedby="basic-addon1">
                                                </div>
                                            </div>
                                            <div class="col-md-1">
                                                <label class="col-form-label mb-6 text-white">a</label>
                                                <br>
                                                <button type="button" id="tambahTiketKendaraan"
                                                    class="btn btn-success btn-icon-split">
                                                    <span class="icon text-white-50">
                                                        <i class="fas fa-plus"></i>
                                                    </span>
                                                    <span class="text">Tambah</span>
                                                </button>
                                            </div>

                                        </div>
                                        <h3 class="titleTiketKendaraan" style="display: none;">Daftar Tiket</h3>
                                        <div class="loopTiketKendaraan" id="loopTiketKendaraan"> </div>

                                    </div>
                                </div>
                            </div>
                            <input type="button" class="submit action-button" value="Submit" /> <input type="button"
                                name="previous" class="previous action-button-previous" value="Previous" />
                        </fieldset>

                    </form>

                </div>
            </div>
        </div>

    </div>

@endsection

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.3.3/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js"></script>



    <script id="loop-penumpang" type="text/x-handlebars-template">
        <div class="form-group row mb-3 hapusRowPenumpang">
                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Kelas Tiket</label>
                                                <input type="text" class="form-control" value="@{{ kelas }}" name="kelas_penumpang[]">
                                            </div>
                                            <div class="col-md-2">
                                                <label class="col-form-label mb-6">Jumlah Tiket</label>
                                                <input type="number" class="form-control" value="@{{ jumlah }}"
                                                    placeholder="Jumlah Tiket Tiket" name="jumlah_penumpang[]">
                                            </div>
                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Harga Tiket Balita</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">Rp</span>
                                                    </div>
                                                    <input type="number" class="form-control"
                                                        aria-label="Balita" aria-describedby="basic-addon1" value="@{{ balita }}" name="balita_penumpang[]">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="col-form-label mb-6">Harga Tiket Dewasa</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">Rp</span>
                                                    </div>
                                                    <input type="number"  class="form-control"
                                                        aria-label="Dewasa" aria-describedby="basic-addon1" value="@{{ dewasa }}" name="dewasa_penumpang[]">
                                                </div>
                                            </div>
                                            <div class="col-md-1">
                                                <label class="col-form-label mb-6 text-white">a</label>
                                                <br>
                                                <button type="button" id="hapusPenumpang" class="btn btn-danger btn-icon-split hapusPenumpang">
                                                    <span class="icon text-white-50">
                                                        <i class="fas fa-times"></i>
                                                    </span>
                                                    <span class="text">Hapus</span>
                                                </button>
                                            </div>
                                        </div>
                                    </script>



    <script id="loop-kendaraan" type="text/x-handlebars-template">
        <div class="form-group row mb-5 hapusRowKendaraan">
                                        <div class="col-md-4">
                                            <label class="col-form-label mb-6">Jenis Kendaraan</label>
                                            <select class="form-control" name="jenis_kendaraan[]">
                                                <option value="@{{ jenis }}" selected>@{{ jenis }}</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="col-form-label mb-6">Jumlah Tiket</label>
                                            <input type="number" class="form-control" name="jumlah_kendaraan[]" value="@{{ jumlah }}">
                                        </div>

                                        <div class="col-md-4">
                                            <label class="col-form-label mb-6">Harga Tiket</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Rp</span>
                                                </div>
                                                <input type="number" class="form-control" name="harga_kendaraan[]"
                                                    aria-label="Harga" aria-describedby="basic-addon1" value="@{{ harga }}">
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <label class="col-form-label mb-6 text-white">a</label>
                                            <br>
                                            <button type="button" id="hapusKendaraan" class="btn btn-danger btn-icon-split hapusKendaraan">
                                                <span class="icon text-white-50">
                                                    <i class="fas fa-times"></i>
                                                </span>
                                                <span class="text">Hapus</span>
                                            </button>
                                        </div>

                                    </div>
                                </script>

    <script>
        $(document).ready(function() {



            var current_fs, next_fs, previous_fs; //fieldsets
            var opacity;
            var current = 1;
            var steps = $("fieldset").length;

            setProgressBar(current);

            $(".next").click(function() {

                current_fs = $(this).parent();
                next_fs = $(this).parent().next();

                //Add Class Active
                $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

                //show the next fieldset
                next_fs.show();
                //hide the current fieldset with style
                current_fs.animate({
                    opacity: 0
                }, {
                    step: function(now) {
                        // for making fielset appear animation
                        opacity = 1 - now;

                        current_fs.css({
                            'display': 'none',
                            'position': 'relative'
                        });
                        next_fs.css({
                            'opacity': opacity
                        });
                    },
                    duration: 500
                });
                setProgressBar(++current);
            });

            $(".previous").click(function() {

                current_fs = $(this).parent();
                previous_fs = $(this).parent().prev();

                //Remove class active
                $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

                //show the previous fieldset
                previous_fs.show();

                //hide the current fieldset with style
                current_fs.animate({
                    opacity: 0
                }, {
                    step: function(now) {
                        // for making fielset appear animation
                        opacity = 1 - now;

                        current_fs.css({
                            'display': 'none',
                            'position': 'relative'
                        });
                        previous_fs.css({
                            'opacity': opacity
                        });
                    },
                    duration: 500
                });
                setProgressBar(--current);
            });

            function setProgressBar(curStep) {
                var percent = parseFloat(100 / steps) * curStep;
                percent = percent.toFixed();
                $(".progress-bar")
                    .css("width", percent + "%")
            }

            $(document).on('click', '#tambahTiketPenumpang', function(e) {
                e.preventDefault();
                $(".titleTiketPenumpang").show();

                var kelas = $("#kelas").val();
                var jumlah = $("#jumlah").val();
                var dewasa = $("#dewasa").val();
                var balita = $("#balita").val();
                var source = $("#loop-penumpang").html();
                var template = Handlebars.compile(source);

                var data = {
                    kelas: kelas,
                    jumlah: jumlah,
                    dewasa: dewasa,
                    balita: balita,
                }

                var html = template(data);
                $("#loopTiketPenumpang").append(html);
                $("#kelas").val("");
                $("#jumlah").val("");
                $("#dewasa").val("");
                $("#balita").val("");

            });

            $(document).on('click', '.hapusPenumpang', function(event) {
                $(this).closest('.hapusRowPenumpang').remove();

            });


            $(document).on('click', '#tambahTiketKendaraan', function(e) {
                e.preventDefault();
                $(".titleTiketKendaraan").show();

                var jenis = $("#jenisKendaraan").val();
                var jumlah = $("#jumlahKendaraan").val();
                var harga = $("#hargaKendaraan").val();
                var source = $("#loop-kendaraan").html();
                var template = Handlebars.compile(source);

                var data = {
                    jenis: jenis,
                    jumlah: jumlah,
                    harga: harga,
                }

                var html = template(data);
                $("#loopTiketKendaraan").append(html);
                $("#jumlahKendaraan").val("");
                $("#hargaKendaraan").val("");
                $("#jenisKendaraan").val("");
            });

            $(document).on('click', '.hapusKendaraan', function(event) {
                $(this).closest('.hapusRowKendaraan').remove();

            });

            $(".submit").click(function() {
                var id = "asd";

                //first form
                var id_kapal = $('select[name="id_kapal"]').val();
                var tgl_berangkat = $('input[name="tgl_berangkat"]').val();
                var tgl_tiba = $('input[name="tgl_tiba"]').val();
                var jam_berangkat = $('input[name="jam_berangkat"]').val();
                var jam_tiba = $('input[name="jam_tiba"]').val();

                //second form
                var kelas_penumpang = $('input[name="kelas_penumpang[]"]').map(function() {
                    return this.value;
                }).get();
                var jumlah_penumpang = $('input[name="jumlah_penumpang[]"]').map(function() {
                    return this.value;
                }).get();
                var balita_penumpang = $('input[name="balita_penumpang[]"]').map(function() {
                    return this.value;
                }).get();
                var dewasa_penumpang = $('input[name="dewasa_penumpang[]"]').map(function() {
                    return this.value;
                }).get();


                //third form
                var jenis_kendaraan = $('select[name="jenis_kendaraan[]"]').map(function() {
                    return this.value;
                }).get();
                var jumlah_kendaraan = $('input[name="jumlah_kendaraan[]"]').map(function() {
                    return this.value;
                }).get();
                var harga_kendaraan = $('input[name="harga_kendaraan[]"]').map(function() {
                    return this.value;
                }).get();

                Swal.fire({
                    title: 'Apakah anda yakin ingin menambah data ?',
                    text: "Silahkan Cek Kembali data yang diinputkan, apakah sudah lengkap atau belum !",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sudah lengkap!'
                }).then((result) => {

                    if (result.isConfirmed) {
                        $.ajax({
                            headers: {
                                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                            },
                            type: 'POST',
                            url: "{{ route('jadwal.store') }}",
                            data: {
                                id_kapal: id_kapal,
                                tgl_berangkat: tgl_berangkat,
                                tgl_tiba: tgl_tiba,
                                jam_berangkat: jam_berangkat,
                                jam_tiba: jam_tiba,
                                kelas_penumpang: kelas_penumpang,
                                jumlah_penumpang: jumlah_penumpang,
                                balita_penumpang: balita_penumpang,
                                dewasa_penumpang: dewasa_penumpang,
                                jenis_kendaraan: jenis_kendaraan,
                                jumlah_kendaraan: jumlah_kendaraan,
                                harga_kendaraan: harga_kendaraan,
                            },
                            success: function(res) {
                                Swal.fire({
                                    title: "Sukses",
                                    text: "Data Berhasil Ditambahkan !",
                                    type: "success",
                                    icon: "success",
                                }).then((result) => {
                                    // Reload the Page
                                    location.reload();
                                });

                            }
                        });
                    }
                })
            });

            $(".checkForm").on('click', function() {
                var dat = $(".pilihKapal").find(':selected').data('jenis');

                switch (dat) {
                    case "Penumpang":
                        $(".penumpangAlert").show();
                        $(".kendaraanAlert").hide();
                        break;
                    case "Kendaraan":
                        $(".kendaraanAlert").show();
                        $(".penumpangAlert").hide();
                        break;

                    default:
                    $(".kendaraanAlert").hide();
                        $(".penumpangAlert").hide();
                        break;
                }

            });

        });
    </script>
@endsection
