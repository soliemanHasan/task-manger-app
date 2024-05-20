import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  const UserEntity({
    required this.id,
    required this.userName,
    required this.email,
    required this.lastName,
    required this.gender,
    required this.firstName,
    required this.image,
  });

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      email,
      lastName,
      gender,
      firstName,
      image,
    ];
  }
}
