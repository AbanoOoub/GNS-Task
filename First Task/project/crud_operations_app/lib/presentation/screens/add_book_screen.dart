import 'package:crud_operations_app/business_logic/add_book_screen_logic/add_book_cubit.dart';
import 'package:crud_operations_app/helpers/app_routes.dart';
import 'package:crud_operations_app/helpers/shared_pref.dart';
import 'package:crud_operations_app/helpers/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/app_colors.dart';
import '../widgets/text_btn_widget.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/text_widget.dart';

class AddBookScreen extends StatelessWidget {
  AddBookScreen({Key? key}) : super(key: key);

  final _addBookFormKey = GlobalKey<FormState>();
  final TextEditingController bookTitleController = TextEditingController();
  final TextEditingController bookDesController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBookCubit(),
      child: BlocConsumer<AddBookCubit, AddBookState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is AddBookSuccessState){
            Navigator.restorablePushNamedAndRemoveUntil(context, AppRoutes.homeScreenRoute, (route) => false);
          }
        },
        builder: (context, state) {
          AddBookCubit addBookCubit = AddBookCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: CustomText(
                    text: 'Add New Book',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.white),
                backgroundColor: AppColors.mainColor,
              ),
              body: Form(
                key: _addBookFormKey,
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextForm(
                          label: 'Title',
                          hint: 'Enter Book Title',
                          withBorders: true,
                          controller: bookTitleController,
                          textInputType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          }),
                      CustomTextForm(
                          label: 'Description',
                          hint: 'Enter Book Description',
                          withBorders: true,
                          controller: bookDesController,
                          textInputType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          }),
                      CustomTextForm(
                          label: 'Price',
                          hint: 'Enter Book Price',
                          withBorders: true,
                          controller: bookPriceController,
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
                        child: state is AddBookLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.mainColor),
                              )
                            : CustomTextButton(
                                btnBackgroundColor: AppColors.mainColor,
                                hasBorder: false,
                                text: 'Save',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.mainTextColor,
                                onPressed: () {
                                  if (_addBookFormKey.currentState!
                                      .validate()) {
                                    int lastId = CacheHelper.getData(
                                        key: SharedPrefKeys.bookIdKey);
                                    addBookCubit.addBook(
                                        id: lastId+1,
                                        title: bookTitleController.text,
                                        des: bookDesController.text,
                                        price: int.parse(
                                            bookPriceController.text));
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
