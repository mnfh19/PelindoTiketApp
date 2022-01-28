@extends('master')



@section('content')
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Tambah Admin</h1>
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
                        <form method="POST" action="{{ route('admin.store') }}">
                            @csrf
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" class="form-control" name="username" placeholder="">
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control" name="password" id="pass" placeholder="">
                                <input type="checkbox" onclick="myFunction()"> Show Password

                            </div>
                            <div class="form-group">
                                <label>Status</label>
                                <select class="form-control" name="status_admin">
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


@section('js')
    <script>
        function myFunction() {
            var x = document.getElementById("pass");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
    </script>
@endsection
