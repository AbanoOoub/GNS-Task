import 'package:crud_operations_app/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/book_model.dart';
import '../../helpers/app_colors.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100.w,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: CustomText(
                    text: book.title!,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black),
              ),
              Expanded(
                flex: 1,
                child: CustomText(
                    text: book.description!,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.secondColor),
              ),
              Expanded(
                flex: 1,
                child: CustomText(
                    text: 'Price: ${book.price!.toString()}\$',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.mainTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
