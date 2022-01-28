@extends('master')

@section('css')
    <link href="{{ asset('vendor/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
@endsection


@section('content')
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row align-items-end">
            <div class="col-lg-10">
                <h1 class="h3 mb-2 text-gray-800">Rute</h1>
                <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed rutrum nibh sit amet
                    diam fermentum fermentum. Nullam eu sapien dapibus magna dapibus ultricies. Pellentesque facilisis nibh
                    et ipsum vehicula convallis. Nunc non ex non ipsum tristique fermentum aliquet sed risus. Nullam vel
                    dolor ac orci mattis pellentesque. Quisque magna sem, pharetra placerat sagittis sit amet, aliquet id
                    nisi. Curabitur nec diam ut massa auctor maximus nec non sem.</p>
            </div>
            <div class="col-lg-2">
                <a href="{{ Route('rute.create') }}" class="btn btn-primary btn-icon-split float-right">
                    <span class="icon text-white-50">
                        <i class="fas fa-plus"></i>
                    </span>
                    <span class="text">Tambah Baru</span>
                </a>
            </div>

        </div>
        <div class="my-2"></div>


        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Daftar Rute</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Rute</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>No</th>
                                <th>Rute</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            @foreach ($get as $d)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $d->rute_awal }}
                                        <span class="icon text-grey">
                                            <i class="fas fa-exchange-alt"></i>
                                        </span>
                                        {{ $d->rute_akhir }}
                                    </td>

                                    <td>
                                        <a href="{{ route('rute.edit', $d->id_rute) }}" class="btn btn-info">
                                            <span class="icon text-white">
                                                <i class="fas fa-pen"></i>
                                            </span>
                                        </a>
                                        <button class="btn btn-danger deleteButton" type="button"
                                            data="{{ route('rute.destroy', $d->id_rute) }}"><span class="icon text-white">
                                                <i class="fas fa-trash"></i>
                                            </span>
                                        </button>
                                    </td>
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

    <!-- Page level custom scripts -->
    <script src="{{ asset('js/demo/datatables-demo.js') }}"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.3.3/dist/sweetalert2.all.min.js"></script>

    <script>
        $(document).ready(function() {
            var timestamp = '{{ Session::get('success') }}';
            if (timestamp) {
                Swal.fire(
                    'Tersimpan !',
                    timestamp,
                    'success'
                )
            }

        });

        $(".deleteButton").on('click', function() {
            var z = $(this).attr('data');
            Swal.fire({
                title: 'Apakah anda yakin ingin menghapus data ?',
                text: "Data yang terhapus tidak akan bisa dikembalikan !",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Delete !'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        type: 'DELETE',
                        url: z,
                        success: function(res) {
                            Swal.fire({
                                title: "Sukses",
                                text: "Data Sukses Terhapus!",
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
    </script>
@endsection
