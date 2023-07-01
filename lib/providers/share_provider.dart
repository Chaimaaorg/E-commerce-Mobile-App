import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/Product.dart';

class ShareProvider extends ChangeNotifier {
  String? _tempImagePath;

  Future<void> createTempImagePath() async {
    final tempDir = await getTemporaryDirectory();
    _tempImagePath = '${tempDir.path}/screenshot.png';
  }

  Future<void> shareProduct(BuildContext context, GlobalKey globalKey, Product? product) async {
    await _captureScreenshot(globalKey);
    if (await File(_tempImagePath!).exists()) {
      await Share.shareFiles([_tempImagePath!],
          text: "Check out this amazing product: ${product!.name}. ${product!.description}",
          subject: "Product Details");
    }
  }

  Future<void> _captureScreenshot(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File(_tempImagePath!);
      await imgFile.writeAsBytes(pngBytes);
    } catch (e) {
      print("Error capturing screenshot: $e");
    }
  }
}

