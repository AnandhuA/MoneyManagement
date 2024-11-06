import 'package:flutter/material.dart';
import 'package:money_management/core/colors.dart';

Widget emptyScreen({
  required BuildContext context,
  required String text1,
  required double size1,
  required String text2,
  required double size2,
  required String text3,
  required double size3,
  int turns = 3,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: turns,
            child: Text(
              text1,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: size1,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text2,
                style: TextStyle(
                  fontSize: size2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                text3,
                style: TextStyle(
                  fontSize: size3,
                  fontWeight: FontWeight.w600,
                  color: AppColor.red,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
