import 'package:ids/models/people_model.dart';
import 'package:ids/view-models/people_viewmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AccountRepository {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      return await initDb();
    }
  }

  Future<Database?> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "ids.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          "CREATE TABLE PEOPLES(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, NAME TEXT, BIRTH_DATE TEXT, GENDER TEXT)");
    });
  }

  Future<List> getAllPeoples() async {
    List<PeopleModel> allPeoples = [];

    await db.then((database) async {
      List qryResult =
          await database!.rawQuery("SELECT * FROM PEOPLES ORDER BY ID DESC");
      for (var p in qryResult) {
        allPeoples.add(PeopleModel.fromJson(p));
      }
    });
    return allPeoples;
  }

  Future<int?> createPeople(PeopleModel peopleModel) async {
    int? id = 0;
    await db.then((database) async {
      await database?.insert("PEOPLES", peopleModel.toJson()).then((value) {
        id = value;
      });
    });
    return id;
  }

  Future<int?> deletePeople(PeopleViewModel peopleViewModel) async {
    int? rowsAffected = 0;
    await db.then((database) async {
      await database?.delete("PEOPLES", where: "id = ?", whereArgs: [
        peopleViewModel.id
      ]).then((value) => rowsAffected = value);
    });
    return rowsAffected;
  }

  Future<int?> updatePeople(PeopleModel peopleModel) async {
    int? rowsAffected = 0;
    await db.then((database) async {
      rowsAffected = await database?.update("PEOPLES", peopleModel.toJson(),
          where: "id = ?", whereArgs: [peopleModel.id]).then((value) {});
    });
    return rowsAffected;
  }

  Future<int?> getId() async {
    Database? dbPeoples = await db;
    return Sqflite.firstIntValue(
          await dbPeoples!.rawQuery("SELECT COUNT(*) FROM PEOPLES"),
        )! +
        1;
  }
}
