import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/theme/color_theme.dart';

TextStyle h1({bold =true}) => GoogleFonts.notoSans(fontSize : 30.0, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());
TextStyle h2({bold =true}) => GoogleFonts.notoSans(fontSize : 25.0, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());
TextStyle h3({bold =true}) => GoogleFonts.notoSans(fontSize : 20.0, color: mainTextColor());

TextStyle warning({bold =true}) =>GoogleFonts.notoSans(fontSize : 15.0, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: Colors.red.shade400);

TextStyle bold({fontSize=20.0,bold =true}) => GoogleFonts.notoSans(fontSize : fontSize, fontWeight: FontWeight.bold, color: mainTextColor());

TextStyle body({fontSize=20.0,bold =true}) => GoogleFonts.notoSans(fontSize : fontSize, fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());

TextStyle small({fontSize=10.0,bold =true}) => GoogleFonts.notoSans(fontSize : fontSize,fontWeight : bold?FontWeight.bold:FontWeight.normal, color: mainTextColor());

TextStyle footerStyle({fontSize=10.0}) => GoogleFonts.notoSans(fontSize : fontSize, color: footerTextColor());

