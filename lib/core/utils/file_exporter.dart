import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// File export utilities for saving and sharing files
class FileExporter {
  /// Save content to file and return file path
  static Future<String> saveToFile({
    required String content,
    required String filename,
  }) async {
    try {
      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$filename';

      // Write file
      final file = File(filePath);
      await file.writeAsString(content);

      return filePath;
    } catch (e) {
      throw Exception('Failed to save file: $e');
    }
  }

  /// Share file using native share dialog
  static Future<void> shareFile({
    required String filePath,
    required String filename,
    String? text,
  }) async {
    try {
      final file = XFile(filePath);
      await Share.shareXFiles(
        [file],
        text: text ?? 'Exported from Geo Survey',
        subject: filename,
      );
    } catch (e) {
      throw Exception('Failed to share file: $e');
    }
  }

  /// Save and share file in one operation
  static Future<void> saveAndShare({
    required String content,
    required String filename,
    String? shareText,
  }) async {
    final filePath = await saveToFile(content: content, filename: filename);
    await shareFile(filePath: filePath, filename: filename, text: shareText);
  }
}
