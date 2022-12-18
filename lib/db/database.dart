import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/cmodel.dart';
import '../models/fmodel.dart';

class DBProvider {
  final String feedsTable = 'feeds';
  final String cacheTable = 'cache';
  final String _dbName = "feeda.db"; // change db name to update

  static DBProvider? _dbProvider;
  static Database? _database;

  DBProvider._createInstance();

  factory DBProvider() {
    if (_dbProvider == null) {
      _dbProvider = DBProvider._createInstance();
    }
    return _dbProvider!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets/db", _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }

  // Future<Database> initDB() async {
  //   Directory documentsDir = await getApplicationDocumentsDirectory();
  //   var path = join(documentsDir.path, _dbName);

  //   var exists = await databaseExists(path);

  //   if (!exists) {
  //     try {
  //       await Directory(dirname(path)).create(recursive: true);
  //     } catch (_) {}

  //     ByteData data = await rootBundle.load(join("assets/db", _dbName));
  //     List<int> bytes =
  //         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  //     await File(path).writeAsBytes(bytes, flush: true);
  //   }

  //   return await openDatabase(path);
  // }

  Future close() async {
    return _database!.close();
  }

  // --------------------------------------------
  // Feeds
  // --------------------------------------------
  Future<int> insertFeedItem(FModel fModel) async {
    final db = await database;
    var result = await db.insert(feedsTable, fModel.toMap());
    return result;
  }

  Future<List<FModel>> getAllFeedItems() async {
    final db = await database;
    var result = await db.query(feedsTable, orderBy: 'time DESC');
    List<FModel> items =
        result.isNotEmpty ? result.map((e) => FModel.fromMap(e)).toList() : [];
    return items;
  }

  Future<int?> getFeedCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $feedsTable'));
  }

  Future<FModel?> getFeedItemById(int id) async {
    final db = await database;
    List<Map> result =
        await db.query(feedsTable, where: 'id = ?', whereArgs: [id]);
    return (result.length > 0) ? FModel.fromMap(result.first) : null;
  }

  Future<int> deleteFeedItem(int id) async {
    final db = await database;
    return await db.delete(feedsTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateFeedItem(FModel fModel) async {
    final db = await database;
    return await db.update(feedsTable, fModel.toMap(),
        where: 'id = ?', whereArgs: [fModel.id]);
  }

  // --------------------------------------------
  // cache
  // --------------------------------------------
  Future<int> deleteCacheByTime(int offset) async {
    final db = await database;
    return await db.delete(cacheTable, where: 'time < ?', whereArgs: [offset]);
  }

  Future<int?> countCacheByFeedId(int feedid) async {
    final db = await database;
    return Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM $cacheTable WHERE feedid = $feedid'));
  }

  Future<List<CModel>> getCacheByFeedId() async {
    final db = await database;
    var result = await db.query(feedsTable, orderBy: 'time DESC');
    List<CModel> items =
        result.isNotEmpty ? result.map((e) => CModel.fromMap(e)).toList() : [];
    return items;
  }

  // Future<int> deleteCacheByFeedId(int feedid) async {
  //   final db = await database;
  //   return await db
  //       .delete(cacheTable, where: 'feedid = ?', whereArgs: [feedid]);
  // }

//  void populateDB() async {
//
//    var title = 'RT';
//    var link = 'https://www.rt.com/rss/news/';
//    var feedId = uuid.v4();
//    var time = new DateTime.now().microsecondsSinceEpoch;
//
//    Model model = Model(title, link, feedId, time);
//    await insertItem(model);
//  }

}
