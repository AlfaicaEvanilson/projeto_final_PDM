import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pagina/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'pagina/pagina_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NewEntryBloc? newEntryBloc;

  @override
  void initState() {
    // TODO: implement initState
    newEntryBloc = NewEntryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NewEntryBloc>.value(
      value: newEntryBloc!,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Pill Reminder',
            theme: ThemeData.dark().copyWith(
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: kScaffoldColor,
                appBarTheme: AppBarTheme(
                    toolbarHeight: 7.h,
                    backgroundColor: kPrimaryColor,
                    elevation: 0,
                    iconTheme: IconThemeData(
                      color: kScaffoldColor,
                      size: 20.sp,
                    ),
                    titleTextStyle: GoogleFonts.mulish(
                      color: kTextColor,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    )),
                textTheme: TextTheme(
                  headlineLarge: TextStyle(
                      fontSize: 28.sp,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w400),
                  headlineMedium: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    color: kTextColor,
                  ),
                  headlineSmall: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w100,
                  ),
                  bodySmall: GoogleFonts.poppins(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                  labelMedium: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kTextLightColor,
                      width: 0.7,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kTextLightColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
                timePickerTheme: TimePickerThemeData(
                    backgroundColor: kScaffoldColor,
                    hourMinuteColor: kTextColor,
                    hourMinuteTextColor: kScaffoldColor,
                    dayPeriodColor: kTextColor,
                    dayPeriodTextColor: kScaffoldColor,
                    dialBackgroundColor: kTextColor,
                    dialHandColor: kPrimaryColor,
                    dialTextColor: kScaffoldColor,
                    entryModeIconColor: kScaffoldColor,
                    dayPeriodTextStyle: GoogleFonts.aBeeZee(fontSize: 8.sp))),
            home: const PaginaInicial(),
          );
        },
      ),
    );
  }
}
