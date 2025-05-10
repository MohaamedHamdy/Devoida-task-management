import 'package:bloc/bloc.dart';
import 'package:devoida_front/features/authentication/signup/data/repo/signup_repo.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());
  final SignUpRepo signUpRepo;
  Future<void> signUp({
    required String username,
    required String pass,
    required String email,
  }) async {
    print(username);
    print("pass: " + pass);
    print(email);
    emit(SignUpLoading());
    await Future.delayed(const Duration(seconds: 1));
    var result = await signUpRepo.signUp(
      username: username,
      pass: pass,
      email: email,
      profilePicture: "",
    );
    result.fold(
      (failure) => emit(SignUpFailure(errorMessage: failure.errorMessage)),
      (success) => emit(SignUpSuccess(status: success)),
    );
  }
}
