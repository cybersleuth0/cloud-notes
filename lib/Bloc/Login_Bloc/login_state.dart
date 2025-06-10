abstract class LoginState {}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {
  final String? snackMsg;

  SuccessState({this.snackMsg});
}

class FailureState extends LoginState {
  final String errorMSG;

  FailureState({required this.errorMSG});
}
