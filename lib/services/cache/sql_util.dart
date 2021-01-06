import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:path/path.dart';
import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:xianliao/models/user/login_entity.dart';

class DbUtil {
  static Database db;
  static String tableName = 'user';

  // 获取数据库中所有的表
  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['user', 'tb_history']; //将项目中使用的表的表名添加集合中

    List<String> tables = await getTables();

    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  //初始化数据库
  Future init() async {
    //Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'data.db');
    print(path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("error $e");
    }

    bool tableIsRight = await this.checkTableIsRight();

    if (!tableIsRight) {
    // if (1==1) {
      // 关闭上面打开的db，否则无法执行open
      db.close();
      //表不完整
      // Delete the database
      await deleteDatabase(path);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(SqlTable.sql_createTable_user);
        await db.execute(SqlTable.sql_createTable_order);
        await db.execute(SqlTable.sql_createTable_history);
        print('db created version is $version');
      }, onOpen: (Database db) async {
        print('new db opened');
      });
    } else {
      print("Opening existing database");
    }
  }

  static Future<int> insertUser(UserInfoData todo) async {
    print("insert user ${todo.toJson()}");
    int value = await db.insert(tableName, todo.toJson());
    return value;
  }

  static Future delUser(int id) async {
    await db.delete(tableName, where: "uid=$id");
  }

  static Future<UserInfoData> getUser() async {
    List<Map> maps = await db.query(tableName);
    if (maps.length > 0) {
      return UserInfoData().fromJson(maps.first);
    }
    return null;
  }

  static Future<int> getUserCount() async {
    List<Map> maps = await db.query(tableName);
    return maps.length;
  }

  static Future<int> updateUser(UserInfoData todo) async {
    return await db.update(tableName, todo.toJson(),
        where: 'id = ?', whereArgs: [todo.username]);
  }

  Future close() async => db.close();
}

class SqlTable {
  static final String sql_createTable_order = """
    CREATE TABLE tb_order (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    orderId Text NOT NULL, 
    type TEXT NOT NULL);
    """;
  static final String sql_createTable_user = """
    CREATE TABLE user (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    uid INTEGER NOT NULL UNIQUE, 
    phone TEXT NOT NULL UNIQUE, 
    username TEXT NOT NULL,
    progress double,
    name TEXT,
    email TEXT,
    assess_key TEXT,
    rule TEXT,
    max_size INT,
    use_size INT,
    roles TEXT
    );
    """;

  static final String sql_createTable_history = """
    CREATE TABLE tb_history (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    text Text NOT NULL UNIQUE);
    """;
}
