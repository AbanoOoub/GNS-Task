import 'package:bloc/bloc.dart';
import 'package:crud_operations_app/helpers/api_end_points.dart';
import 'package:crud_operations_app/helpers/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/book_model.dart';

part 'update_book_state.dart';

class UpdateBookCubit extends Cubit<UpdateBookState> {
  UpdateBookCubit() : super(UpdateBookInitial());

  static UpdateBookCubit get(context) => BlocProvider.of(context);

  void updateBook(
      {required int id,
      required String newTitle,
      required String newDes,
      required newPrice}) async {
    try {
      emit(UpdateBookLoadingState());
      await DioHelper.updateData(endPoint: EndPoint.editBook + '/$id', data: {
        "id": id,
        "title": newTitle,
        "description": newDes,
        "price": newPrice
      }).then((value) {
        if (value.statusCode == 200) {
          emit(UpdateBookSuccessState());
        }
      });
    } catch (error) {
      emit(UpdateBookErrorState());
    }
  }
}
