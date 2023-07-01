import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:mailer/mailer.dart' as Mailer;

import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import '../models/CartDetailsArguments.dart';
import '../providers/sign_in_provider.dart';
import '../../pdf/pdf_screen.dart';



Future<void> sendPdfAsEmail(BuildContext context,CartDetailsArguments cartDetailsArguments,String orderId ) async {
  final sp = context.read<SignInProvider>();
  // Fetch data from Firebase before building the UI
  sp.getUserDataFromFirestore(sp.uid);
  final pdfData = await generatePdf(PdfPageFormat.a4,sp,cartDetailsArguments,orderId);

  String username = 'manonkrk99@gmail.com';
  String password = 'ghccoztfnzicorld';

  final smtpServer = gmail(username, password);

  final message = Mailer.Message()
    ..from = const Mailer.Address('manonkrk99@gmail.com', 'Manon Krook')
    ..recipients.add('chaimaaourgani84@gmail.com')
    ..subject = 'New order'
    ..html = 'Please find attached the PDF.'
    ..attachments.add(
      Mailer.FileAttachment(File(pdfData.path)),
    );

  try {
    final sendReport = await Mailer.send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on Mailer.MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}





TextStyle safeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}
