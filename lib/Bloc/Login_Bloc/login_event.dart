abstract class LoginEvent {}

class Login_BTN_Event extends LoginEvent {
  final String mail;
  final String passwd;

  Login_BTN_Event({required this.mail, required this.passwd});
}
