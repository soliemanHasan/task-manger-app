import 'package:task_manger_app/modules/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String token;
  const UserModel({
    required super.email,
    required super.firstName,
    required super.gender,
    required super.id,
    required super.image,
    required super.lastName,
    required super.userName,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "image": image,
        "token": token,
      };
}
