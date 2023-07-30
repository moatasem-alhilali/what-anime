import 'package:anime_finder/features/home/model/anime_model.dart';
import 'package:anime_finder/features/search/model/search_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static String anime = '''
    CREATE TABLE anime(
    id INTEGER PRIMARY KEY,
    frameCount INTEGER,
    date TEXT NOT NULL,
    image TEXT UNIQUE NOT NULL
  )
''';
  static String info = '''
     CREATE TABLE info(
        id INTEGER PRIMARY KEY,
        animeId INTEGER,
        anilist INTEGER NOT NULL,
        episode INTEGER NOT NULL,
        froms INTEGER NOT NULL,
        tos INTEGER NOT NULL,
        filename TEXT NOT NULL,
        similarity INTEGER NOT NULL,
        video TEXT NOT NULL,
        image TEXT NOT NULL,
        FOREIGN KEY (animeId) REFERENCES anime(id)
      )
''';
  static Database? _db;
  static final String _tablename = 'recently';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}anime.db';
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(anime);
          await db.execute(info);

          print("data opend");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<List<AnimeModel>> getAll() async {
    // print("query function called");
    final List<Map<String, dynamic>> maps = await _db!.query('anime');
    return List.generate(maps.length, (i) => AnimeModel.fromJson(maps[i]));
  }

  static Future<List<InfoModel>> getInfo() async {
    // print("query function called");
    final List<Map<String, dynamic>> maps = await _db!.query('info');
    return List.generate(maps.length, (i) => InfoModel.fromJson(maps[i]));
  }

  //

  static Future<List<InfoModel>> getInfoForAnime(int animeId) async {
    final List<Map<String, dynamic>> maps = await _db!.rawQuery('''
      SELECT info.id, info.anilist, info.filename, info.episode, info.froms, info.tos, info.similarity, info.video, info.image
      FROM info
      JOIN anime ON info.animeId = anime.id
      WHERE anime.id = ?
    ''', [animeId]);
    print(maps);
    return List.generate(maps.length, (i) => InfoModel.fromJson(maps[i]));
  }

  static Future<int> insertAnime(AnimeModel result) async {
    return await _db!.insert('anime', result.toJson());
  }

  static Future<int> insertInfo(InfoModel result) async {
    return await _db!.insert('info', result.toJson());
  }

  static Future<int> delete(AnimeModel result) async {
    return await _db!
        .delete(_tablename, where: 'id = ?', whereArgs: [result.id]);
  }
}
