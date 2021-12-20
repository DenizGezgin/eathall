part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends UserEvent {
  @override
  String toString() => 'Login/Logout Process started';
}

class LoginButtonPressed extends UserEvent {
  final String mail;
  final String pass;

  LoginButtonPressed(this.mail,this.pass);

  @override
  String toString() => 'Login button pressed';
}

class GoogleLoginButtonPressed extends UserEvent {
  @override
  String toString() => 'Google login button pressed';
}

class LogoutButtonPressed extends UserEvent {
  @override
  String toString() => 'Logout button pressed';
}

class AnonButtonPressed extends UserEvent {
  @override
  String toString() => 'Anon button pressed';
}