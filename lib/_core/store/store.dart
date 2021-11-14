import 'package:flutter/cupertino.dart';
import 'package:sembast/sembast.dart';

abstract class Store<T> {
  final Database _database;
  late final StoreRef<int, Map<String, Object?>> _store;

  late final Stream<List> storeStatus;

  @protected
  String getItemKey(T item);

  @protected
  String getItemKeyName();

  @protected
  Map<String, dynamic> itemToJson(T item);

  @protected
  T fromJson(Map<String, dynamic> json);

  Finder _finderForSingleItem(T item) => Finder(
        filter: Filter.custom(
          (record) => record[getItemKeyName()] == getItemKey(item),
        ),
      );

  Store(this._database, {required name}) {
    _store = intMapStoreFactory.store(name);

    storeStatus = _store.query().onSnapshots(_database).map(
          (event) => event.map((e) => fromJson(e.value)).toList(),
        );
  }

  Future<List<T>> get() async {
    final list = await _store.find(_database);
    return list.map((e) => fromJson(e.value)).toList();
  }

  Future<void> add(T item) async {
    await _database.transaction((transaction) async {
      await _store.add(transaction, itemToJson(item));
    });
  }

  Future<void> addList(List<T> items) async {
    await _database.transaction((transaction) async {
      for (final item in items) {
        await _store.add(transaction, itemToJson(item));
      }
    });
  }

  Future<void> upsert(T item) async {
    _database.transaction((transaction) async {
      await _store.update(transaction, itemToJson(item),
          finder: _finderForSingleItem(item));
    });
  }

  Future<void> upsertList(List<T> items) async {
    _database.transaction((transaction) async {
      for (final item in items) {
        await _store.update(
          transaction,
          itemToJson(item),
          finder: _finderForSingleItem(item),
        );
      }
    });
  }

  Future<void> delete(T item) async {
    await _database.transaction((transaction) async {
      await _store.delete(transaction, finder: _finderForSingleItem(item));
    });
  }
}
