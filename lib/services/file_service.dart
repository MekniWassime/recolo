import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  FileService._();

  static final FileService _instance = FileService._();

  static FileService get instance => _instance;

  String directory = "";

  static Future initService() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Directory journalDirectory =
        await Directory("${appDocumentsDirectory.path}/journal")
            .create(recursive: true);
    instance.directory = journalDirectory.path;
  }

  Future writeToFile(String fileName, String content) async {
    try {
      var file = File(_getFilePath(fileName));
      await file.writeAsString(content);
      return true;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return false;
    }
  }

  Future<List<File>> fetchFileList() async {
    var result = <File>[];
    await for (var entry in Directory(directory).list()) {
      result.add(File(entry.path));
    }
    return result;
  }

  Future<File> getFile(String fileName) async {
    String filePath = _getFilePath(fileName);
    var file = File(filePath);
    if (file.existsSync()) {
      return file;
    } else {
      throw FileNotFoundException(path: filePath);
    }
  }

  Future<bool> fileExists(String fileName) async {
    return File(_getFilePath(fileName)).exists();
  }

  Future delete(String fileName) async {
    await File(_getFilePath(fileName)).delete();
  }

  String _getFilePath(String fileName) {
    return "$directory/$fileName";
  }

  Future deleteAll() async {
    await for (var entry in Directory(directory).list()) {
      await File(entry.path).delete();
    }
    return true;
  }
}

class FileNotFoundException extends FileSystemException {
  FileNotFoundException({required String path}) : super("File Not Found", path);
}
