import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_excel/business_logic/home_screen_logic/home_cubit.dart';
import 'package:flutter_excel/helpers/app_colors.dart';
import 'package:flutter_excel/presentation/widgets/custom_text_button.dart';
import 'package:flutter_excel/presentation/widgets/custom_text_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _homeScreenFormKey = GlobalKey<FormState>();
  final TextEditingController fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ReadFilesSucessState) {
            // Timer(const Duration(seconds: 2),
            //     () => HomeCubit.get(context).solve());
            HomeCubit.get(context).solve();
          }
          if (state is SolveSuccessState) {
            HomeCubit.get(context).saveExcelFiles();
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Web'),
            ),
            body: Form(
              key: _homeScreenFormKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30.w),
                      child: CustomTextForm(
                          label: 'File Name',
                          hint: 'ex: excel',
                          controller: fileNameController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 25.w,
                      width: 200.w,
                      child: CustomTextButton(
                          btnBackgroundColor: AppColors.mainColor,
                          hasBorder: false,
                          text: 'Solve',
                          onPressed: () {
                            if (_homeScreenFormKey.currentState!.validate()) {
                              homeCubit.readExcelFile(
                                  fileName: fileNameController.text);
                            }
                          },
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
