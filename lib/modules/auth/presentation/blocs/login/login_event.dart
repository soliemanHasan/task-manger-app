part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonTappedEvent extends LoginEvent {
  final String phoneNumber;
  final String password;

  const LoginButtonTappedEvent({
    required this.phoneNumber,
    required this.password,
  });
}
