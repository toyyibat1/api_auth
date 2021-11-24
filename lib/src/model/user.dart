import 'dart:convert';

// UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

// String userLoginToJson(UserLogin data) => json.encode(data.toJson());

// class UserLogin {
//   UserLogin({
//     this.email,
//     this.password,
//   });

//   String? email;
//   String? password;

//   factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
//     email: json["mobile"],
//     password: json["password"],
//   );

//   Map<String, dynamic> toJson() => {
//     "mobile": email,
//     "password": password,
//   };
// }

class User {
  int? id;
  String? name;
  String? email;

  User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json['email']
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    "name": name,
    'email': email
  };

}