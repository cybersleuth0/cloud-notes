abstract class Signup_State {}

class Initial_State extends Signup_State {}

class Loading_State extends Signup_State {}

class Success_State extends Signup_State {
  final String? snackMsg;

  Success_State({this.snackMsg});
}

class Failure_State extends Signup_State {
  final String errorMSG;

  Failure_State({required this.errorMSG});
}
