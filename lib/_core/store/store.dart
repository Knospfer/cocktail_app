import 'package:flutter/cupertino.dart';
import 'package:sembast/sembast.dart';

abstract class Store<T> {
  final Database _database;
  late final StoreRef<int, Map<String, Object?>> _store;

  @protected
  String getItemKey(T item);

  @protected
  String getItemKeyName();

  @protected
  Map<String, dynamic> itemToJson(T item);

  @protected
  T fromJson(Map<String, dynamic> json);

  Store(this._database, {required name}) {
    _store = intMapStoreFactory.store(name);
  }

  Future<List<T>> get() async {
    final items = await _store.find(_database);
    return items.map((e) => fromJson(e.value)).toList();
  }

  Future<void> add(T item) async {
    await _database.transaction((transaction) async {
      await _store.add(transaction, itemToJson(item));
    });
  }

  Future<void> delete(T item) async {
    await _database.transaction((transaction) async {
      final finder = Finder(
        filter: Filter.custom(
          (record) => record[getItemKeyName()] == getItemKey(item),
        ),
      );
      await _store.delete(transaction, finder: finder);
    });
  }
}
