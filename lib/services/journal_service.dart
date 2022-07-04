import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:recolo/models/journal_item.dart';
import 'package:recolo/models/journal_metadata.dart';

import 'package:recolo/services/file_service.dart';
import 'package:recolo/utility/date_utility.dart';

class JournalService {
  int pageSize = 30;
  Map<String, JournalMetadata> fileMetaDataCache = {};

  Future<List<JournalItem>> fetchAll() async {
    var files = await FileService.instance.fetchFileList();
    debugPrint(files.toString());
    return <JournalItem>[];
  }

  void reset() {
    fileMetaDataCache = {};
  }

  Future<Iterable<JournalMetadata>> fetchNextPage() async {
    var files = await FileService.instance.fetchFileList();
    files.sort((a, b) => -a.path.compareTo(b.path));
    var notCachedFiles =
        files.where((element) => !fileMetaDataCache.containsKey(element.path));
    var filesToAdd = notCachedFiles.take(pageSize);
    var result = <JournalMetadata>[];
    for (var file in filesToAdd) {
      var metaData = await JournalMetadata.fromFile(file);
      fileMetaDataCache.addAll({file.path: metaData});
      result.add(metaData);
    }
    return result;
  }

  static Future<JournalItem> getItem(
      JournalMetadata metadata, String password) async {
    var file = await FileService.instance.getFile(metadata.fileName);
    var item = await JournalItem.fromFile(file, password);
    return item;
  }

  Future<bool> delete(JournalMetadata item) async {
    try {
      FileService.instance.delete(item.fileName);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> save(JournalItem item) async {
    try {
      await FileService.instance
          .writeToFile(item.fileName, item.toJsonString());
      return true;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return false;
    }
  }

  static addPlaceholderFiles() async {
    var today = DateUtility.now();
    int numberOfFileToAdd = 1000;
    for (var i = 0; i < numberOfFileToAdd; i++) {
      var shifted = today.subtract(Duration(days: i));
      var item = JournalItem(
        password: "wassime",
        data: "Top secret secrets",
        metadata: JournalMetadata(
          date: shifted,
          rating: Random().nextInt(5) - 2,
          title: Random().nextBool() ? "password: wassime" : "",
        ),
      );
      await FileService.instance
          .writeToFile(item.fileName, item.toJsonString());
    }
    debugPrint("added $numberOfFileToAdd files");
  }
}
