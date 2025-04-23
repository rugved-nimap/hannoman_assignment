class DbHelper {
  static int version = 1;

  static String databaseName = "hanooman.db";
  static String tableName = "search_table";
  static String columnIdName = "id";
  static String columnDataName = "data";
  static String columnTimeStampName = "timeStamp";

  static String CREATE_TABLE = '''
          CREATE TABLE $tableName (
            $columnIdName INTEGER PRIMARY KEY,
            $columnDataName TEXT NOT NULL,
            $columnTimeStampName INTEGER NOT NULL
          )
          ''';
}
