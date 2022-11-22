import 'package:bloc/bloc.dart';
import 'package:crud_operations_app/helpers/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book_model.dart';
import '../../helpers/api_end_points.dart';
import '../../helpers/dio.dart';
import '../../helpers/shared_pref.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Book> bookList = [];

  void getAllBooks() async {
    try {
      emit(GetAllBooksLoadingState());
      await DioHelper.getData(endPoint: EndPoint.getAllBooks).then((value) {
        if (value.statusCode == 200) {
          bookList = List<Book>.from(value.data.map((x) => Book.fromJson(x)));
          if(bookList.isNotEmpty){
            bookList.sort((a, b) => a.id!.compareTo(b.id!));
            CacheHelper.saveData(key: SharedPrefKeys.bookIdKey, val: bookList.last.id);
          }else{
            CacheHelper.saveData(key: SharedPrefKeys.bookIdKey, val: 0);
          }
          emit(GetAllBooksSuccessState());
        }
      });
    } catch (error) {
      emit(GetAllBooksErrorState());
    }
  }

  void deleteBook({required int id}) async {
    try {
      await DioHelper.deleteData(endPoint: EndPoint.deleteBook + "/$id")
          .then((value) {
        if (value.statusCode == 200) {
          bookList.removeWhere((book) => book.id == id);
          emit(DeleteBookSuccessState());
        }
      });
    } catch (error) {
      emit(DeleteBookErrorState());
    }
  }
}
