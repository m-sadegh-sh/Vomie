import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xoomie/src/sign_out/bloc/sign_out_event.dart';
import 'package:xoomie/src/sign_out/bloc/sign_out_repository.dart';
import 'package:xoomie/src/sign_out/bloc/sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEventBase, SignOutStateBase> {
  final SignOutRepositoryBase repository;

  SignOutBloc({
    required this.repository,
  }) : super(const SignOutInitialState()) {
    on<SignOutSignOutEvent>(_onSignOut);
  }

  Future<void> _onSignOut(
    SignOutEventBase event,
    Emitter<SignOutStateBase> emit,
  ) async {
    try {
      emit(const SignOutSigningOutState());

      await repository.signOut();

      emit(const SignOutSignedOutState());
    } catch (e) {
      emit(SignOutSignOutFailedState(
        (x) => x.authBlocSignInFailed,
      ));
    }
  }
}
