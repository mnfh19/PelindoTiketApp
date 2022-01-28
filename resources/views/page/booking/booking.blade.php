@extends('master')

@section('css')
    <link href="{{ asset('vendor/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
@endsection


@section('content')
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row align-items-end">
            <div class="col-lg-10">
                <h1 class="h3 mb-2 text-gray-800">Data Pemesanan</h1>
            </div>


        </div>
        <div class="my-2"></div>


        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Daftar Kapal</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Nomor Booking</th>
                                <th>Nama Pemesan</th>
                                <th>Tgl Booking</th>
                                <th>Jumlah Penumpang</th>
                                <th>Harga Total</th>
                                <th>Bukti Pembayaran</th>
                                <th>Status Booking</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>No</th>
                                <th>Nomor Booking</th>
                                <th>Nama Pemesan</th>
                                <th>Tgl Booking</th>
                                <th>Jumlah Penumpang</th>
                                <th>Harga Total</th>
                                <th>Bukti Pembayaran</th>
                                <th>Status Booking</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            @foreach ($get as $d)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>
                                        {{-- <a href="#" class="btn btn-primary" data-toggle="modal"
                                            data-target="#DetailModal">{{ $d->id_tiket }}</a> --}}
                                        <a href="#" class="btn btn-primary showDetail"
                                            data="{{ $d->id_booking }}">{{ $d->no_booking }}</a>
                                    </td>

                                    <td>{{ $d->username }}</td>
                                    <td>{{ \Carbon\Carbon::parse($d->tgl_booking)->translatedFormat('j F Y, H:i') }}
                                    </td>
                                    <td>
                                        {{ $d->penumpang_dewasa }} Dewasa <br>
                                        @if ($d->penumpang_balita != 0)
                                            {{ $d->penumpang_balita }} Balita
                                        @endif
                                    </td>
                                    <td>{{ $d->harga_total }}</td>
                                    <td>
                                        @if ($d->status_bayar == 0)
                                            <span class="text-danger">Belum Mengupload Bukti Pembayaran</span>
                                        @else
                                            <a href="#" data="{{ $d->bukti_pembayaran }}" class="btn btn-primary buktiLihat">
                                                <span class="text">Lihat</span>
                                            </a>
                                        @endif

                                    </td>
                                    <td>
                                        @if ($d->status_booking == 0)
                                            <span>Belum Dibayar</span>
                                        @elseif ($d->status_booking == 1)
                                            <span class="text-warning">Menunggu Konfirmasi</span>
                                        @elseif ($d->status_booking == 2)
                                            <span class="text-info">Sedang Berjalan</span>
                                        @elseif ($d->status_booking == 3)
                                            <span class="text-success">Selesai</span>
                                        @elseif ($d->status_booking == 4)
                                            <span class="text-danger">Ditolak</span>
                                        @endif
                                    </td>

                                    <td>
                                        @if ($d->status_booking == 0 || $d->status_booking == 1)
                                            <a href="#" class="btn btn-success konfirmasi"
                                                data="{{ url('konfirmasiBooking/'.$d->id_booking) }}">
                                                <span class="icon text-white">
                                                    <i class="fas fa-check"></i>
                                                </span>
                                            </a>
                                            <a href="#" class="btn btn-danger">
                                                <span class="icon text-white">
                                                    <i class="fas fa-times"></i>
                                                </span>
                                            </a>
                                        @endif

                                        @if ($d->status_booking == 2 || $d->status_booking == 3)
                                            <a href="#" class="btn btn-primary cetakTiket" data="{{ $d->id_booking }}">
                                                <span class="icon text-white">
                                                    <i class="fas fa-print"></i>
                                                </span>
                                            </a>
                                        @endif

                                    </td>
                                </tr>
                            @endforeach


                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

    <!-- Modal -->
    <div class="modal fade" id="DetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Detail Tiket</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h5>Detail Perjalanan</h5>
                    <table class="table ">

                        <tbody>
                            <tr>
                                <th>Nama Pelayaran Kapal</th>
                                <td colspan="3"><span id="nama_kapal"></span> <br><span id="km"></span> </td>
                            </tr>
                            <tr>
                                <th>Tanggal Berangkat</th>
                                <td><span id="tgl_berangkat"></span> <br><span id="jam_berangkat"></span> </td>
                                <th>Tanggal Tiba</th>
                                <td><span id="tgl_tiba"></span> <br><span id="jam_tiba"></span> </td>
                            </tr>
                            <tr>
                                <th>Lama Perjalanan</th>
                                <td colspan="3"><span id="lama_perjalanan"></span> </td>
                            </tr>
                            <tr>
                                <th>Rute</th>
                                <td colspan="3"><span id="rute"></span>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                    <h5 class="mt-5">Detail Tiket</h5>
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Balita</th>
                                <td class="text-left" id="balita"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <th>Dewasa</th>
                                <td class="text-left" colspan="10" id="dewasa"></td>
                            </tr>
                            <tr>
                                <th>Kendaraan</th>
                                <td class="text-left" colspan="10" id="kendaraan"></td>
                            </tr>


                        </tbody>
                    </table>
                    <h5 class="mt-5">Detail Harga</h5>
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Kelas Tiket </th>
                                <td colspan="3" id="kelas_tiket"></td>
                            </tr>
                            <tr>
                                <th colspan="4">Harga Tiket Penumpang</th>

                            </tr>
                            <tr>
                                <td>Balita </td>
                                <td><span id="penumpang_balita"></span> x <span id="harga_balita"></span> = </td>
                                <th class="text-right" id="total_balita"></th>
                            </tr>
                            <tr>
                                <td>Dewasa </td>
                                <td><span id="penumpang_dewasa"></span> x <span id="harga_dewasa"></span> = </td>
                                <th class="text-right" id="total_dewasa"></th>
                            </tr>

                            <tr>
                                <th colspan="4">Harga Tiket Kendaraan</th>

                            </tr>
                            <tr>
                                <td id="kendaraan2"> </td>
                                <td><span id="total_kendaraan">1</span> x <span id="harga_kendaraan"></span> = </td>
                                <th class="text-right"><span id="harga_kendaraan2"></th>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                            </tr>
                            <tr>
                                <th>Total Harga </th>
                                <th class="text-right" colspan="3" id="harga_total"></th>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="BuktiModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Bukti Pembayaran</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <img id="gambarBukti" style="width: 100%;"  src="{{asset('images/bukti_example.jpg')}}" alt="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="CetakModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Cetak Tiket</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nama Penumpang</th>
                                <th>Cetak Tiket</th>
                            </tr>
                        </thead>
                        <tbody id="listPenumpang">


                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

@endsection


@section('js')
    <!-- Page level plugins -->
    <script src="{{ asset('vendor/datatables/jquery.dataTables.min.js') }}"></script>
    <script src="{{ asset('vendor/datatables/dataTables.bootstrap4.min.js') }}"></script>

    <!-- Page level custom scripts -->
    <script src="{{ asset('js/demo/datatables-demo.js') }}"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.3.3/dist/sweetalert2.all.min.js"></script>


    <script>
        $(document).on('click', ".showDetail", function(e) {
            e.preventDefault();
            var id = $(this).attr("data");

            $.ajax({
                url: "{{ url('booking/getDetailTiket') }}/" + id,
                method: "GET",
                async: false,
                dataType: "JSON",
                success: function(data) {
                    // alert(data.a[0]);
                    // alert(data.b.nama_kapal);
                    if (data != "") {
                        $("#DetailModal").modal("show");

                        //Kembali Ke Fitrah
                        $("#nama_kapal").html("");
                        $("#km").html("");
                        $("#tgl_berangkat").html("");
                        $("#tgl_tiba").html("");
                        $("#jam_berangkat").html("");
                        $("#jam_tiba").html("");
                        $("#lama_perjalanan").html("");
                        $("#rute").html("");
                        $("#total_kendaraan").html("");
                        $("#kelas_tiket").html("");
                        $("#penumpang_balita").html("");
                        $("#harga_balita").html("");
                        $("#penumpang_dewasa").html("");
                        $("#harga_dewasa").html("");
                        $("#total_balita").html("");
                        $("#total_dewasa").html("");
                        $("#kendaraan").html("");
                        $("#kendaraan2").html("");
                        $("#harga_kendaraan").html("");
                        $("#harga_kendaraan2").html("");
                        $("#harga_total").html("");
                        $("#balita").html("");
                        $("#dewasa").html("");

                        // Insert Data
                        $("#nama_kapal").html(data.main.nama_kapal);
                        $("#km").html(data.main.km);
                        $("#tgl_berangkat").html(data.main.tgl_berangkat);
                        $("#tgl_tiba").html(data.main.tgl_tiba);
                        $("#jam_berangkat").html(data.main.jam_berangkat);
                        $("#jam_tiba").html(data.main.jam_tiba);
                        $("#lama_perjalanan").html(data.main.lama_perjalanan);
                        $("#rute").html(data.main.rute);
                        $("#total_kendaraan").html(1);
                        $("#kelas_tiket").html(data.main.kelas_tiket);
                        $("#penumpang_balita").html(data.main.penumpang_balita);
                        $("#harga_balita").html(format(data.main.harga_balita));
                        $("#penumpang_dewasa").html(data.main.penumpang_dewasa);
                        $("#harga_dewasa").html(format(data.main.harga_dewasa));
                        $("#total_balita").html(format(data.main.total_balita));
                        $("#total_dewasa").html(format(data.main.total_dewasa));
                        $("#kendaraan").html(data.main.kendaraan);
                        $("#kendaraan2").html(data.main.kendaraan);
                        $("#harga_kendaraan").html(format(data.main.harga_kendaraan));
                        $("#harga_kendaraan2").html(format(data.main.harga_kendaraan));
                        $("#harga_total").html(format(data.main.harga_total));

                        if (data.main.penumpang_dewasa == 0) {
                            $("#kelas_tiket").html("-");
                            $("#balita").html("-");
                            $("#dewasa").html("-");
                            $("#penumpang_balita").html(0);
                            $("#harga_balita").html(format(0));
                            $("#penumpang_dewasa").html(0);
                            $("#harga_dewasa").html(format(0));
                            $("#total_balita").html(format(0));
                            $("#total_dewasa").html(format(0));
                            $("#total_kendaraan").html(1);
                        }

                        if (data.main.harga_kendaraan == 0) {
                            $("#total_kendaraan").html(0);
                            $("#kendaraan").html("-");
                            $("#kendaraan2").html("-");
                            $("#harga_kendaraan").html(format(0));
                            $("#harga_kendaraan2").html(format(0));
                        }

                        if (data.main.penumpang_balita == 0) {
                            $("#balita").html("- <br>");
                            $("#penumpang_balita").html(0);
                            $("#harga_balita").html(format(0));
                            $("#total_balita").html(format(0));
                        }

                        for (i = 0; i < data.list_balita.length; ++i) {
                            $("#balita").append(data.list_balita[i] + "</br>");
                        }

                        for (i = 0; i < data.list_dewasa.length; ++i) {
                            $("#dewasa").append(data.list_dewasa[i] + "</br>");
                        }

                        // $("#balita").html(bal);

                        // $("#balita").html(data.main.rute);


                        // $("#selectAkunUbah").val(data.jenis_akun);
                        // $("#namaUbah").val(data.nama_akun);
                    }
                }
            });

            function format(num) {
                const format = num.toString().split('').reverse().join('');
                const convert = format.match(/\d{1,3}/g);
                const rupiah = 'Rp ' + convert.join('.').split('').reverse().join('')
                return rupiah;
            };
        });

        $(document).on('click', ".cetakTiket", function(e) {
            e.preventDefault();
            var id = $(this).attr("data");

            $.ajax({
                url: "{{ url('booking/cetakTiket') }}/" + id,
                method: "GET",
                async: false,
                dataType: "JSON",
                success: function(data) {
                    if (data != "") {
                        $("#CetakModal").modal("show");
                        var html = "";
                        var z = 1;
                        for (i = 0; i < data.length; i++) {
                            html += '<tr>' +
                                '<td>' + z + '</td>' +
                                '<td>' + data[i].nama_penumpang + '</td>' +
                                '<td>' +
                                '<a href="#" class="btn btn-primary btn-icon-split"data="' + data[i]
                                .id_penumpang + '" >' +
                                '<span class="icon text-white-50" >' +
                                '<i class="fas fa-print"></i>' +
                                '</span>' +
                                '<span class="text">Cetak</span>' +
                                '</a>' +
                                '</td>' +
                                '</tr>';
                            z++;
                        }

                        $("#listPenumpang").append(html);
                    }
                }
            });

        });

        $(".konfirmasi").on('click', function() {
            var z = $(this).attr('data');
            Swal.fire({
                title: 'Apakah anda yakin ingin Mengkonfirmasi pembayaran ?',
                text: "Pastikan bukti transfer merupakan data yang asli dan benar !",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Konfirmasi !'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        type: 'POST',
                        url: z,
                        success: function(res) {
                            Swal.fire({
                                title: "Sukses",
                                text: "Pesanan Terkonfirmasi!",
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

        $('.buktiLihat').on('click', function(e) {
            e.preventDefault();
            $("#BuktiModal").modal("show");
            var z = $(this).attr('data');
            // print(z);

            var img = "{{asset('images')}}/"+z;

            $("#gambarBukti").attr("src",img);
        });
    </script>
@endsection
