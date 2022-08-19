import 'dart:convert';

class User {
  int id_user;
  String username;
  String email;
  String pass;
  String no_ktp;
  String ttl;
  String jenis_kelamin;
  String telp;
  String pin;
  String status_user;

  User(
      {this.id_user,
      this.username,
      this.email,
      this.pass,
      this.no_ktp,
      this.ttl,
      this.telp,
      this.jenis_kelamin,
      this.pin,
      this.status_user});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id_user: map["id_user"],
        username: map["username"],
        email: map["email"],
        pass: map["pass"],
        no_ktp: map["no_ktp"],
        ttl: map["ttl"],
        telp: map["telp"],
        jenis_kelamin: map["jenis_kelamin"],
        pin: map["pin"],
        status_user: map["status_user"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": id_user,
      "username": username,
      "email": email,
      "pass": pass,
      "no_ktp": no_ktp,
      "ttl": ttl,
      "telp": telp,
      "jenis_kelamin": jenis_kelamin,
      "pin": pin,
      "status_user": status_user,
    };
  }

  @override
  String toString() {
    return 'User{id_user: $id_user, username: $username, email: $email, pass: $pass, no_ktp: $no_ktp, ttl: $ttl, telp: $telp, jenis_kelamin: $jenis_kelamin, pin: $pin, status_user: $status_user,}';
  }
}

List<User> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
