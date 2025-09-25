import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

abstract class StorageService {
  Future<String> uploadImage(Uint8List imageBytes, String fileName);
  Future<void> deleteImage(String fileName);
  Future<bool> imageExists(String fileName);
}

class LocalStorageService implements StorageService {
  late Directory _appDirectory;
  late Directory _imagesDirectory;

  LocalStorageService() {
    _initializeDirectories();
  }

  Future<void> _initializeDirectories() async {
    if (!kIsWeb) {
      _appDirectory = await getApplicationDocumentsDirectory();
      _imagesDirectory = Directory(
        path.join(_appDirectory.path, 'product_images'),
      );

      if (!await _imagesDirectory.exists()) {
        await _imagesDirectory.create(recursive: true);
      }
    }
  }

  @override
  Future<String> uploadImage(Uint8List imageBytes, String fileName) async {
    if (kIsWeb) {
      final blob = html.Blob([imageBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      return url;
    } else {
      try {
        await _initializeDirectories();

        String filePath = path.join(_imagesDirectory.path, fileName);

        File imageFile = File(filePath);
        await imageFile.writeAsBytes(imageBytes);

        return filePath;
      } catch (e) {
        throw Exception('Failed to save image locally: $e');
      }
    }
  }

  @override
  Future<void> deleteImage(String fileName) async {
    if (kIsWeb) {
      return;
    } else {
      try {
        await _initializeDirectories();

        String filePath = path.join(_imagesDirectory.path, fileName);
        File imageFile = File(filePath);

        if (await imageFile.exists()) {
          await imageFile.delete();
        }
      } catch (e) {
        throw Exception('Failed to delete image: $e');
      }
    }
  }

  @override
  Future<bool> imageExists(String fileName) async {
    if (kIsWeb) {
      return false;
    } else {
      try {
        await _initializeDirectories();

        String filePath = path.join(_imagesDirectory.path, fileName);
        File imageFile = File(filePath);

        return await imageFile.exists();
      } catch (e) {
        return false;
      }
    }
  }

  Future<String> getImagesDirectory() async {
    if (kIsWeb) {
      return '';
    } else {
      await _initializeDirectories();
      return _imagesDirectory.path;
    }
  }
}

class StorageServiceFactory {
  static StorageService createStorageService() {
    return LocalStorageService();
  }
}
