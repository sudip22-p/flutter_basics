import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginButtonPresssed>((event, emit) async {
      try {
        emit(AuthLoading());
        //get the email password and check the validity
        final email = event.email;
        final password = event.password;
        final RegExp emailRegex = RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        );
        if (!emailRegex.hasMatch(email)) {
          return emit(AuthFailure(errorMessage: "Invalid email address! "));
        }
        if (password.length < 6) {
          return emit(
            AuthFailure(
              errorMessage: "Password must be at least 6 character long.",
            ),
          );
        }

        await Future.delayed(const Duration(seconds: 1), () {
          //do db func then ...
          return emit(AuthSuccess(uid: email));
        });
      } catch (e) {
        return emit(AuthFailure(errorMessage: e.toString()));
      }
    });
    on<AuthLogoutButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(AuthInitial());
        });
      } catch (e) {
        emit(AuthFailure(errorMessage: e.toString()));
      }
    });
  }
}
