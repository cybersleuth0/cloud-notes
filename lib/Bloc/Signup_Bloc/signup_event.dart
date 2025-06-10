abstract class Signup_Event {}

class SignupBTN_Event extends Signup_Event {
  final String mail;
  final String passwd;
  final String name;

  SignupBTN_Event(
      {required this.mail, required this.passwd, required this.name});
}
