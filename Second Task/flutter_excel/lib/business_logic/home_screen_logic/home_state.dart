part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SavedFilesSuccessState extends HomeState {}

class SolveSuccessState extends HomeState {}

class ReadFilesSucessState extends HomeState {}
