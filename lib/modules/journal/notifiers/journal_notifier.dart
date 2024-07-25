import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:recolo/models/journal_item.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/services/journal_service.dart';

class JournalNotifier extends ChangeNotifier {
  List<JournalMetadata> _items = [];
  NewsNotifierState _state = NewsNotifierState.loading;
  bool endOfPage = false;
  bool alreadyFetching = false;

  UnmodifiableListView<JournalMetadata> get items =>
      UnmodifiableListView(_items);
  bool get isLoading => _state == NewsNotifierState.loading;
  bool get hasData => _state == NewsNotifierState.hasData;
  bool get empty => _state == NewsNotifierState.notFound;

  final journalService = JournalService();

  Future<void> fetchNextPage() async {
    if (endOfPage || alreadyFetching) return;
    alreadyFetching = true;
    if (!isLoading) {
      _state = NewsNotifierState.loading;
      notifyListeners();
    }
    var response = await journalService.fetchNextPage();
    if (response.isEmpty) {
      endOfPage = true;
    }
    _items.addAll(response);
    _items.sort((a, b) => -a.fileName.compareTo(b.fileName));
    _updateItemsState();
    notifyListeners();
    alreadyFetching = false;
  }

  Future<void> refresh() async {
    endOfPage = false;
    _items = [];
    journalService.reset();
    var response = await journalService.fetchNextPage();
    _items.addAll(response);
    _items.sort((a, b) => -a.fileName.compareTo(b.fileName));
    _updateItemsState();
    notifyListeners();
  }

  Future<bool> deleteItem(JournalMetadata item) {
    return journalService.delete(item).then((value) {
      if (_items.remove(item)) {
        notifyListeners();
        _updateItemsState();
      }
      return value;
    });
  }

  Future<bool> saveItem(JournalItem item) {
    return JournalService.save(item).then((value) {
      if (!value) return false;
      debugPrint("changes saved");
      bool exists = false;
      for (var i = 0; i < _items.length; i++) {
        if (_items[i].fileName == item.metadata.fileName) {
          _items.replaceRange(i, i + 1, [item.metadata]);
          exists = true;
          break;
        }
      }
      notifyListeners();
      assert(exists, "all metadata should exist in the items list");
      return true;
    });
  }

  Future<bool> createItem(JournalItem item) async {
    return JournalService.save(item).then((didSave) {
      if (didSave) {
        _items.insert(0, item.metadata);
        _updateItemsState();
        notifyListeners();
      }
      return didSave;
    });
  }

  void _updateItemsState() {
    if (items.isEmpty) {
      _state = NewsNotifierState.notFound;
    } else {
      _state = NewsNotifierState.hasData;
    }
  }
}

enum NewsNotifierState { loading, hasData, notFound }
