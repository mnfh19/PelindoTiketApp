@extends('master')

@section('css')
    <link href="{{ asset('vendor/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.1.0/css/buttons.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/datetime/1.1.1/css/dataTables.dateTime.min.css" rel="stylesheet">
@endsection


@section('content')
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Laporan</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm filter"><i
                    class="fas fa-print fa-sm text-white-50"></i> &nbspFilter Laporan</a>
        </div>
        <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-3 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Pilih Tanggal Awal</div>
                                <input type="date" class="form-control tgl_awal" id="max" name="max">
                                {{-- <input type="text" id="min" name="min"> --}}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-3 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Pilih Tanggal Akhir</div>
                                {{-- <input type="text" id="max" name="max"> --}}
                                <input type="date" class="form-control tgl_akhir" id="min" name="min">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-3 mb-4">
                <div class="card border-left-info shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                    Pilih Kapal</div>
                                <select class="form-control nama_kapal">
                                    <option value="">Semua Kapal</option>
                                    <option value="PELNI">PELNI</option>
                                    <option value="Dharma Lautan Utama (DLU)">Dharma Lautan Utama (DLU)</option>
                                    <option value="Damai Lautan Nusantara (DLN)">Damai Lautan Nusantara (DLN)</option>

                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-3 mb-4">
                <div class="card border-left-info shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                    Pilih Rute</div>
                                <select class="form-control rute">
                                    <option value="">Semua Rute</option>
                                    @foreach ($jalan as $d)
                                        <option value="{{ $d->rute_awal }} ⇆ {{ $d->rute_akhir }}">
                                            {{ $d->rute_awal }} ⇆ {{ $d->rute_akhir }}
                                        </option>
                                    @endforeach

                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {{-- <form method="POST" id="filterin" action="{{url('laporan/filtered')}}">
                @csrf
                <input type="hidden" value="" name="awal">
                <input type="hidden" value="" name="akhir">
                <input type="hidden" value="" name="nama">
            </form> --}}


            <!-- Pending Requests Card Example -->

        </div>


        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Daftar Kapal</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="lapDataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Nama Pelayaran Kapal</th>
                                <th>Nama KM</th>
                                <th>Nomor Booking</th>
                                <th>Rute</th>
                                <th>Tanggal Berangkat</th>
                                <th>Tanggal Tiba</th>
                                <th>Nama Penumpang</th>
                                <th>Jumlah Penumpang</th>
                                <th>Kelas Tiket</th>
                                <th>Kendaraan</th>
                                <th>Total Harga</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>No</th>
                                <th>Nama Pelayaran Kapal</th>
                                <th>Nama KM</th>
                                <th>Nomor Booking</th>
                                <th>Rute</th>
                                <th>Tanggal Berangkat</th>
                                <th>Tanggal Tiba</th>
                                <th>Nama Penumpang</th>
                                <th>Jumlah Penumpang</th>
                                <th>Kelas Tiket</th>
                                <th>Kendaraan</th>
                                <th>Total Harga</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            @foreach ($booking as $d)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $kapal[$d->id_booking]->nama_kapal }}</td>
                                    <td>{{ $kapal[$d->id_booking]->KM }}</td>
                                    <td>{{ $d->no_booking }}</td>
                                    <td>{{ $rute[$d->id_booking]->rute_awal . ' ⇆ ' . $rute[$d->id_booking]->rute_akhir }}
                                    </td>
                                    <td>{{ $jadwal[$d->id_booking]->tgl_berangkat }}</td>
                                    <td>{{ $jadwal[$d->id_booking]->tgl_tiba }}</td>
                                    <td>
                                        @if ($penumpang[$d->id_booking] != 'Kosong')
                                            @foreach ($penumpang[$d->id_booking] as $e)
                                                <ul>
                                                    <li>{{ $e->nama_penumpang }}</li>
                                                </ul>
                                            @endforeach
                                        @else
                                            -
                                        @endif
                                    </td>
                                    <td>{{ $d->penumpang_dewasa + $d->penumpang_balita }}</td>
                                    <td>{{ $tiket[$d->id_booking]->kelas_tiket }}</td>
                                    <td>{{ $tiket_kendaraan[$d->id_booking]->jenis_kendaraan }}</td>
                                    <td>{{ $d->harga_total }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

@endsection


@section('js')
    <!-- Page level plugins -->
    <script src="{{ asset('vendor/datatables/jquery.dataTables.min.js') }}"></script>
    <script src="{{ asset('vendor/datatables/dataTables.bootstrap4.min.js') }}"></script>
    <script src="https://cdn.datatables.net/buttons/2.1.0/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.1.0/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.1.0/js/buttons.print.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="{{ asset('js/demo/datatables-demo.js') }}"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.3.3/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <script src="https://cdn.datatables.net/datetime/1.1.1/js/dataTables.dateTime.min.js"></script>

    <script>
        $(document).ready(function() {

            var table = $('#lapDataTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    // 'copy', 'csv', 'excel', 'pdf', 'print',
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'LEGAL'
                    },
                    {
                        extend: 'excel',
                    },
                    {
                        extend: 'print',
                    }


                ],
            });

            var minDateFilter = "";
            var maxDateFilter = "";

            $(".filter").on('click', function() {
                var awal = $('.tgl_awal').val();
                var akhir = $('.tgl_akhir').val();
                var nama = $('.nama_kapal').val();

                minDateFilter = awal;
                maxDateFilter = akhir;

                table.draw();


            });

            $.fn.dataTable.ext.search.push(
                function(settings, data, dataIndex) {
                    var min = $('.tgl_awal').val();
                    var max = $('.tgl_akhir').val();
                    var nama = $('.nama_kapal').val();
                    var rute = $('.rute').val();
                    var date = new Date(data[5]);

                    if (
                        (min === "" && max === "") ||
                        (min === "" && data[5] <= max) || (min === "" && data[6] <= max) ||
                        (min <= data[5] && max === "") || (min <= data[6] && max === "") ||
                        (min <= data[5] && data[5] <= max) || (min <= data[6] && data[6] <= max)

                        // (nama === "") || (nama == data[1])

                    ) {

                        if (nama === "") {
                            if (rute === "") {
                                return true;
                            } else if (rute === data[4]) {
                                return true;
                            } else {
                                return false;
                            }

                            return true;
                        } else if (nama === data[1]) {
                            if (rute === "") {
                                return true;
                            } else if (rute === data[4]) {
                                return true;
                            } else {
                                return false;
                            }

                            return true;
                        }



                        // return true;
                        return false;
                    }




                    // console.log(min);
                    return false;
                }
            );

            // $(".filter").on('click', function() {
            //     var awal = $('.tgl_awal').val();
            //     var akhir = $('.tgl_akhir').val();
            //     var nama = $('.nama').val();

            //     if (awal == "") {
            //         awal = "all";
            //     }

            //     if (akhir == "") {
            //         akhir = "all";
            //     }

            //     // $("input[name='awal']").val(awal);
            //     // $("input[name='akhir']").val(akhir);
            //     // $("input[name='nama']").val(nama);
            //     // alert(nama);
            //     // $.ajax({
            //     //     headers: {
            //     //         'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            //     //     },
            //     //     type: 'GET',
            //     //     url: "{{ url('laporan/filtered') }}",
            //     //     params:{
            //     //         awal: awal,
            //     //         akhir: akhir,
            //     //         nama: nama,
            //     //     },
            //     //     success: function(data) {
            //     //        alert(data);

            //     //     }
            //     // });
            //     // window.location.href = "{{ URL::to('laporan/"+awal+"/"+akhir+"/"+nama+"') }}";
            //     var url = "{{ URL('laporan') }}" + "/" + awal + "/" + akhir + "/" + nama;
            //     location.replace(url);
            //     // alert(url);


            // });


        });
    </script>

@endsection
