abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class FailedToRegisterState extends AuthStates{
  final String message;
  FailedToRegisterState({required this.message});
}