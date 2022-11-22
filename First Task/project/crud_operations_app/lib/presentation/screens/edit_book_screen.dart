import 'package:crud_operations_app/business_logic/update_book_screen_logic/update_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/book_model.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_routes.dart';
import '../widgets/text_btn_widget.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/text_widget.dart';

class EditBookScreen extends StatelessWidget {
  EditBookScreen({Key? key}) : super(key: key);

  final _editBookFormKey = GlobalKey<FormState>();
  final TextEditingController newTitleController = TextEditingController();
  final TextEditingController newDesController = TextEditingController();
  final TextEditingController newPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBookCubit(),
      child: BlocConsumer<UpdateBookCubit, UpdateBookState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UpdateBookSuccessState) {
            Navigator.restorablePushNamedAndRemoveUntil(
                context, AppRoutes.homeScreenRoute, (route) => false);
          }
        },
        builder: (context, state) {
          UpdateBookCubit updateBookCubit = UpdateBookCubit.get(context);
          final arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;

          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: CustomText(
                    text: 'Edit a Book',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.white),
                backgroundColor: AppColors.mainColor,
              ),
              body: Form(
                key: _editBookFormKey,
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextForm(
                          label: 'New Title',
                          hint: 'Enter New Title',
                          withBorders: true,
                          controller: newTitleController,
                          textInputType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          }),
                      CustomTextForm(
                          label: 'New Description',
                          hint: 'Enter New Description',
                          withBorders: true,
                          controller: newDesController,
                          textInputType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          }),
                      CustomTextForm(
                          label: 'New Price',
                          hint: 'Enter New Price',
                          withBorders: true,
                          controller: newPriceController,
                          textInputType: TextInputType.number,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          }),
                      SizedBox(
                        width: 200.w,
                        height: 35.w,
                        child: state is UpdateBookLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.mainColor),
                              )
                            : CustomTextButton(
                                btnBackgroundColor: AppColors.mainColor,
                                hasBorder: false,
                                text: 'Update',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.mainTextColor,
                                onPressed: () {
                                  if (_editBookFormKey.currentState!
                                      .validate()) {
                                    Book selectedBook = arguments['book'];
                                    updateBookCubit.updateBook(
                                        id: selectedBook.id!,
                                        newTitle: newTitleController.text,
                                        newDes: newDesController.text,
                                        newPrice:
                                            int.parse(newPriceController.text));
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
