import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cs310_step3/services/authentication_file.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(NotLoggedIn()) {
    AuthService auth = AuthService();
    on<AppStarted>((event, emit) async {
      emit(NotLoggedIn());
    });

    on<GoogleLoginButtonPressed>((event, emit) async {
      UserCredential? user = await auth.signInWithGoogle();

      if (user != null && user.user != null) {
        emit(LoggedIn(user: user));
      } else {
        emit(NotLoggedIn());
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      auth.signOut();
      emit(NotLoggedIn());
    });
  /*
    on<LoginButtonPressed>((event, emit) async {
      UserCredential user = await auth.loginWithMailAndPass(event.mail,event.pass);

      if (user.user != null) {
        emit(LoggedIn(user: user));
      } else {
        emit(NotLoggedIn());
      }
    });
    */


    on<AnonButtonPressed>((event, emit) async {
      UserCredential user = await auth.signInAnon();

      if (user.user != null) {
        emit(AnonLoggedIn(user: user));
      } else {
        emit(NotLoggedIn());
      }
    });


  }
}
