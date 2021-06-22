
abstract class AuthenticationState {}

class SignedInState extends AuthenticationState {
  SignedInState();
}

class SignedOutState extends AuthenticationState {
  SignedOutState();
}

class InitAuthState extends AuthenticationState {}

class ErrorAuthState extends AuthenticationState {
  final String message;
  ErrorAuthState({required this.message});
}

class LoadingAuthState extends AuthenticationState {
  LoadingAuthState();
}