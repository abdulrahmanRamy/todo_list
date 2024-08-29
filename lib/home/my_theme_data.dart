import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class MyThemeData{
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backGroundLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        side: BorderSide(
          color: AppColors.blackColor,
          width: 4,
        )
      )
    ),
    floatingActionButtonTheme:FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        )
      )
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(35),
      //   side: BorderSide(
      //     color: AppColors.whiteColor,
      //     width: 4,
      //   )
      // ),

    ) ,
    useMaterial3: false,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor
      ),
      titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor
      ),
      bodyLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor
      ),
      bodyMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor
      ),
    )
  );
  static final ThemeData darkTheme = ThemeData(
    hoverColor: Colors.white,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backGroundDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        side: BorderSide(
          color: AppColors.blackColor,
          width: 4,
        )
      )
    ),
    floatingActionButtonTheme:FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        )
      )
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(35),
      //   side: BorderSide(
      //     color: AppColors.whiteColor,
      //     width: 4,
      //   )
      // ),

    ) ,
    useMaterial3: false,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.whiteColor,
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.backGroundDarkColor
      ),
      titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor
      ),
      bodyLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor
      ),
      bodyMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor
      ),
    )
  );

}
