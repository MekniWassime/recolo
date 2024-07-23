import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recolo/models/journal_item.dart';
import 'package:recolo/modules/journal/notifiers/journal_notifier.dart';
import 'package:recolo/utility/date_utility.dart';
import 'package:recolo/utility/error_handler_utility.dart';
import 'package:recolo/widgets/editor_app_bar.dart';
import 'package:recolo/widgets/my_scaffhold.dart';

class JournalEditScreen extends StatefulWidget {
  const JournalEditScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  final JournalItem item;
  @override
  State<JournalEditScreen> createState() => _JournalEditScreenState();
}

class _JournalEditScreenState extends State<JournalEditScreen> {
  late final ValueNotifier<int> ratingController;
  late final TextEditingController titleController;
  late final TextEditingController textController;
  late final FocusNode titleFocusNode;
  late final FocusNode textFocusNode;
  static const int autoSaveDelay = 10;
  bool saveOnCooldown = false;
  late JournalItem currentItem;
  late final JournalNotifier journalNotifier;

  @override
  void initState() {
    currentItem = widget.item;
    String title = currentItem.metadata.title;
    ratingController = ValueNotifier(currentItem.metadata.rating);
    titleController =
        TextEditingController(text: title.isEmpty ? "Enter Title" : title);
    textController = TextEditingController(text: currentItem.data);
    titleFocusNode = FocusNode();
    textFocusNode = FocusNode();
    ratingController.addListener(markAsDirty);
    titleFocusNode.addListener(emulateDefaultLabel);
    titleController.addListener(markAsDirty);
    textController.addListener(markAsDirty);
    journalNotifier = Provider.of<JournalNotifier>(context, listen: false);
    Future.delayed(Duration.zero).then((value) => textFocusNode.requestFocus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: saveChanges,
      child: MyScaffhold(
        appBar: EditorAppBar(
          context: context,
          textController: titleController,
          focusNode: titleFocusNode,
          ratingController: ratingController,
          subTitle: DateUtility.toddMMyyyy(currentItem.metadata.date),
        ),
        body: TextField(
          controller: textController,
          maxLines: null,
          minLines: 100,
          focusNode: textFocusNode,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
          ),
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }

  void emulateDefaultLabel() {
    if (titleFocusNode.hasFocus && titleController.text == "Enter Title") {
      titleController.text = "";
    }
    if (!titleFocusNode.hasFocus && titleController.text.isEmpty) {
      titleController.text = "Enter Title";
    }
  }

  void markAsDirty() async {
    if (saveOnCooldown) return;
    saveOnCooldown = true;
    await Future.delayed(const Duration(seconds: autoSaveDelay));
    saveOnCooldown = false;
    await saveChanges();
  }

  String getTitle(String title) => title == "Enter Title" ? "" : title;

  Future<bool> saveChanges() async {
    if (!didChange()) return true;
    var tempItem = currentItem.copyWith(
      newData: textController.text,
      newRating: ratingController.value,
      newTitle: getTitle(titleController.text),
    );
    try {
      await journalNotifier.saveItem(tempItem);
      currentItem = tempItem;
      return true;
    } catch (error, stackTrace) {
      ErrorHandlerUtility.handle(error, stackTrace);
      return false;
    }
  }

  bool didChange() {
    return getTitle(titleController.text) != currentItem.metadata.title ||
        ratingController.value != currentItem.metadata.rating ||
        textController.text != currentItem.data;
  }

  @override
  void dispose() {
    ratingController.dispose();
    titleController.dispose();
    textController.dispose();
    titleFocusNode.dispose();
    textFocusNode.dispose();
    super.dispose();
  }
}
