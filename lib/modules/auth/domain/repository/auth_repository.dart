import 'package:dartz/dartz.dart';
import 'package:task_manger_app/core/errors/failure.dart';
import 'package:task_manger_app/modules/auth/domain/entities/user_entity.dart';
import 'package:task_manger_app/modules/auth/domain/parameters/login_parameters.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParameters parameters);
}
