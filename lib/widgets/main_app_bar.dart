import 'package:flutter/material.dart';
import 'package:recolo/services/file_service.dart';
import 'package:recolo/services/journal_service.dart';

class MainAppBar extends PreferredSize {
  MainAppBar({
    Key? key,
    required String title,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Image.asset(
                      "assets/recolo-logo-trimmed.png",
                      height: 27.5,
                    ),
                  ),
                  Text(
                    "ecolo",
                    style: TextStyle(fontSize: 25),
                  ),
                ]),
            // actions: [
            //   TextButton(
            //       onPressed: () => FileService.instance.deleteAll(),
            //       child: const Text("Delete all")),
            //   TextButton(
            //       onPressed: () => JournalService.addPlaceholderFiles(),
            //       child: const Text("Gen Files")),
            // ],
          ),
        );
}
