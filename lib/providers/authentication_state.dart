
abstract class AuthenticationState {}

class SignedInState implements AuthenticationState {
  SignedInState();
}

class SignedOutState implements AuthenticationState {
  SignedOutState();
}

class InitAuthState implements AuthenticationState {}

class ErrorAuthState implements AuthenticationState {
  ErrorAuthState({required this.message});
  final String message;
}

class LoadingAuthState implements AuthenticationState {
  const LoadingAuthState();
}