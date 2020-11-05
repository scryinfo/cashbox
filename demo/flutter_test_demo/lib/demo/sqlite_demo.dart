import 'package:sqflite/sqflite.dart';

class SQLiteDemo {
  Database database;

  SQLiteDemo() {}

  void initDB() async {
    // open the database
    var dbFilePath = "/data/data/wallet.cashbox.scry.info/files/cashbox_wallet_detail.db"; //todo
    //                /data/data/wallet.cashbox.scry.info/files/cashbox_wallet_detail.db
    database = await openDatabase(dbFilePath, version: 1, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      // await db.execute('CREATE TABLE detail.DefaultDigitBase (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
    testGetDbData();
  }

  void testInsertDbData() async {
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ['another name', 12345678, 3.1416]);
      print('inserted2: $id2');
    });
  }

  void testGetDbData() async {
    // Get the records
    var tableName = await database.rawQuery("select name from sqlite_master where type='table'");
    print(tableName);
    List<Map> addressList = await database.rawQuery('SELECT * FROM Address');
    print(addressList);
    List<Map> chainList = await database.rawQuery('SELECT * FROM Chain');
    print(chainList);
    List<Map> defaultDigitList = await database.rawQuery('SELECT * FROM DefaultDigitBase');
    print(defaultDigitList);
    List<Map> metaDataList = await database.rawQuery('SELECT * FROM android_metadata');
    print(metaDataList);
  }

  void testUpdateDbData() async {
    // Update some record
    int count = await database.rawUpdate('UPDATE Test SET name = ?, value = ? WHERE name = ?', ['updated name', '9876', 'some name']);
    print('updated: $count');
  }

  void testDeleteDbData() async {
    var count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
    count = await database.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    //log.d()
    print("count is ======>" + count.toString());
  }

  void destroy() async {
    await database.close();
  }
}
