import 'dart:io';

import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class PdfService {
  static Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }
}
