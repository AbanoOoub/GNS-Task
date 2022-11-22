import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/home_screen_logic/home_cubit.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_routes.dart';
import '../widgets/book_card_widget.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllBooks(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: CustomText(
                  text: 'Home',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.white),
              backgroundColor: AppColors.mainColor,
            ),
            body: Padding(
              padding: EdgeInsets.all(10.w),
              child: state is GetAllBooksLoadingState
                  ? Center(
                      child:
                          CircularProgressIndicator(color: AppColors.mainColor),
                    )
                  : homeCubit.bookList.isEmpty
                      ? CustomText(
                          text: 'No Books Yet',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.mainTextColor)
                      : ListView.builder(
                          itemCount: homeCubit.bookList.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: AppColors.red,
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.white,
                                ),
                              ),
                              onDismissed: (_)  {
                                 homeCubit.deleteBook(
                                    id: homeCubit.bookList[index].id!);
                              },
                              child: InkWell(
                                child: BookCardWidget(
                                    book: homeCubit.bookList[index]),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.editBookScreenRoute,
                                      arguments: {
                                        'book': homeCubit.bookList[index]
                                      });
                                },
                              ),
                            );
                          }),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.mainColor,
                child: Icon(Icons.add, color: AppColors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addBookScreenRoute);
                }),
          );
        },
      ),
    );
  }
}
