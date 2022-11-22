part of 'add_book_cubit.dart';

@immutable
abstract class AddBookState {}

class AddBookInitial extends AddBookState {}

class AddBookSuccessState extends AddBookState {}

class AddBookErrorState extends AddBookState {}

class AddBookLoadingState extends AddBookState {}
