enum Tables {
  novels("novels", "id", {
    "id": "INTEGER NOT NULL",
    "created_at": "DATETIME DEFAULT CURRENT_TIMESTAMP",
    "updated_at": "DATETIME DEFAULT CURRENT_TIMESTAMP",
    "deleted_at": "DATETIME",
    "status": "INTEGER NOT NULL",
    "url": "TEXT NOT NULL",
    "title": "TEXT NOT NULL",
    "author": "TEXT NOT NULL",
    "description": "TEXT NOT NULL",
  }),
  episodes("episodes", "id", {
    "id": "INTEGER NOT NULL",
    "created_at": "DATETIME DEFAULT CURRENT_TIMESTAMP",
    "updated_at": "DATETIME DEFAULT CURRENT_TIMESTAMP",
    "deleted_at": "DATETIME",
    "url": "TEXT NOT NULL",
    "novelId":
        "INTEGER NOT NULL REFERENCES ${"novels"} (${"id"}) ON DELETE CASCADE",
    "title": "TEXT NOT NULL",
    "content": "TEXT",
  });

  const Tables(this.tablename, this.pkey, this.columns);
  final String tablename;
  final String pkey;
  final Map<String, String> columns; // col-name, options
}
