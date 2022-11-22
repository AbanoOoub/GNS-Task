part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetAllBooksErrorState extends HomeState {}

class GetAllBooksLoadingState extends HomeState {}

class GetAllBooksSuccessState extends HomeState {}

class DeleteBookSuccessState extends HomeState {}

class DeleteBookErrorState extends HomeState {}
