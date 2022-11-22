part of 'update_book_cubit.dart';

@immutable
abstract class UpdateBookState {}

class UpdateBookInitial extends UpdateBookState {}
class UpdateBookSuccessState extends UpdateBookState {}
class UpdateBookErrorState extends UpdateBookState {}
class UpdateBookLoadingState extends UpdateBookState {}
