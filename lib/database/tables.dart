class Tables {
  static const count = "count";
  static const user = "user";

  static const tables = [
    "CREATE TABLE IF NOT EXISTS " +
        count +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "access_token TEXT,"
            "refresh_token TEXT,"
            "token_type TEXT,"
            "expire_time TEXT,"
            "created_at TEXT,"
            "expires_in TEXT"
            ")",
    "CREATE TABLE IF NOT EXISTS " +
        user +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "email TEXT,"
            "username TEXT,"
            "name TEXT"
            ")"
  ];
}
