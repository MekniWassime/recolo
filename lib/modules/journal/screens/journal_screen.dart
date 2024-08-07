import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recolo/models/journal_item.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/modules/journal/notifiers/journal_notifier.dart';
import 'package:recolo/modules/journal/screens/journal_edit_screen.dart';
import 'package:recolo/modules/journal/widgets/delete_confirm_alert.dart';
import 'package:recolo/modules/journal/widgets/empty_journal_list.dart';
import 'package:recolo/modules/journal/widgets/journal_entry.dart';
import 'package:recolo/modules/journal/widgets/journal_screen_scaffhold.dart';
import 'package:recolo/modules/journal/widgets/loading_journals.dart';
import 'package:recolo/modules/journal/widgets/password_input_popup.dart';
import 'package:recolo/modules/journal/widgets/password_input_with_confirmationpopup.dart';
import 'package:recolo/services/file_service.dart';
import 'package:recolo/services/journal_service.dart';
import 'package:recolo/utility/date_utility.dart';
import 'package:recolo/utility/navigation_utility.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final scrollController = ScrollController();
  final goToTopVIsibilityController = ValueNotifier<bool>(false);
  late final JournalNotifier journalNotifier;

  @override
  void initState() {
    journalNotifier = Provider.of<JournalNotifier>(context, listen: false);
    journalNotifier.refresh();
    scrollController.addListener(reactToScrollPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return JournalScreenScaffhold(
      onGoToTopButtonPressed: scrollToTopWithAdaptiveSpeed,
      goToTopVisibilityController: goToTopVIsibilityController,
      onFloatingButtonPressed: () => showPasswordInputWithConfirmationDialog(),
      body: Consumer<JournalNotifier>(builder: (context, value, child) {
        if (value.empty) {
          return EmptyJournalList(
              onCreateButtonPressed: showPasswordInputWithConfirmationDialog);
        }
        var itemcount = value.items.length + 1;
        return RefreshIndicator(
          onRefresh: journalNotifier.refresh,
          child: ListView.separated(
            separatorBuilder: (context, index) => Container(
                height: 2, decoration: BoxDecoration(color: backgroundColor)),
            padding: EdgeInsets.only(top: 3),
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index == value.items.length) {
                if (value.isLoading) {
                  return const LoadingJournals();
                } else {
                  return const SizedBox(height: 10);
                }
              }
              var item = value.items[index];
              return JournalEntry(
                metadata: item,
                onTap: () => passwordInputPopup(
                  context: context,
                  onConfirm: (password) => readDataFromFile(item, password),
                ),
                onLongPress: () => deleteConfirmAlert(
                  context: context,
                  onConfirm: () => journalNotifier.deleteItem(item),
                ),
              );
            },
            itemCount: itemcount,
          ),
        );
      }),
    );
  }

  void showPasswordInputWithConfirmationDialog() {
    PasswordInputWithConfirmationDialog.show(
      context: context,
      onConfirm: readDataFromFileCreateIfNotExists,
    );
  }

  void readDataFromFile(JournalMetadata metadata, String password) {
    JournalService.getItem(metadata, password).then((item) {
      NavigationUtility.of(context).pushScreen(JournalEditScreen(item: item));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          titlePadding: EdgeInsets.symmetric(vertical: 20),
          title: Center(child: Text("Wrong password")),
        ),
      );
    });
  }

  void readDataFromFileCreateIfNotExists(String password) async {
    var newMetaData = JournalMetadata(date: DateUtility.relevantNow());
    bool fileExists =
        await FileService.instance.fileExists(newMetaData.fileName);
    if (fileExists) {
      readDataFromFile(newMetaData, password);
    } else {
      final key = encrypt.Key(utf8.encode(password));
      final item = JournalItem.empty(metadata: newMetaData, key: key);
      await journalNotifier.createItem(item);
      NavigationUtility.of(context).pushScreen(JournalEditScreen(item: item));
    }
  }

  void scrollToTopWithAdaptiveSpeed() {
    scrollController.animateTo(
      0,
      duration: Duration(
          milliseconds:
              (250 * (min(scrollController.position.pixels / 1000, 6)))
                  .floor()),
      curve: Curves.decelerate,
    );
  }

  void reactToScrollPosition() {
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent - 1000) {
      journalNotifier.fetchNextPage();
    }
    if (goToTopVIsibilityController.value &&
        scrollController.position.pixels < 400) {
      goToTopVIsibilityController.value = false;
    } else if (scrollController.position.pixels > 600) {
      goToTopVIsibilityController.value = true;
    }
  }
}
