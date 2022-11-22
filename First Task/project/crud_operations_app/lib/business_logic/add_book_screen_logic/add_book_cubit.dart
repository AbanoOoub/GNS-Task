import 'package:bloc/bloc.dart';
import 'package:crud_operations_app/helpers/api_end_points.dart';
import 'package:crud_operations_app/helpers/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit() : super(AddBookInitial());

  static AddBookCubit get(context) => BlocProvider.of(context);

  void addBook(
      {required int id,
      required String title,
      required String des,
      required int price}) async {
    try {
      emit(AddBookLoadingState());
      await DioHelper.postData(endPoint: EndPoint.addBook, data: {
        "id": id,
        "title": title,
        "description": des,
        "price": price,
      }).then((value) {
        if(value.statusCode == 201){
          emit(AddBookSuccessState());
        }
      });
    } catch (error) {
      emit(AddBookErrorState());
    }
  }
}
