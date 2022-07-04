import 'package:flutter/material.dart';
import 'package:recolo/services/file_service.dart';
import 'package:recolo/services/journal_service.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    Key? key,
    required String title,
  }) : super(
          key: key, title: Text(title),
          // actions: [
          //         TextButton(
          //             onPressed: () => FileService.instance.deleteAll(),
          //             child: const Text("Delete all")),
          //         TextButton(
          //             onPressed: () => JournalService.addPlaceholderFiles(),
          //             child: const Text("Gen Files")),
          //       ]
        );
}
