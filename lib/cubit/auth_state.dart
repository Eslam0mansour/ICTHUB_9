abstract class AuthState {}

class AuthInitial extends AuthState {}

// login states
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String error;

  LoginError(this.error);
}

// signup states

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupError extends AuthState {
  final String error;

  SignupError(this.error);
}
