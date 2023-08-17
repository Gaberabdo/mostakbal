part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}



/// todo create user
class CreateUserLoadingState extends AuthState {}
class CreateUserSuccessState extends AuthState {}
class CreateUserErrorState extends AuthState {}


/// todo create user Using Google
class CreateUserUsingGoogleLoadingState extends AuthState {}
class CreateUserUsingGoogleSuccessState extends AuthState {}
class CreateUserUsingGoogleErrorState extends AuthState {}
