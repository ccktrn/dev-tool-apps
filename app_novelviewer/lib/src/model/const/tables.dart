

enum Tables {
  novels (NovelTable.tablename, NovelTable.pkey),
  episodes (EpisodeTable.tablename, EpisodeTable.pkey),
  chapters (ChapterTable.tablename, ChapterTable.pkey);

  const Tables (this.tablename,this.pkey);
  final String tablename;
  final String pkey;
}


// Database type

enum NovelTable { //columns
  id ("INTEGER") ,
  downloadTs ("DATETIME DEFAULT CURRENT_TIMESTAMP"),
  updateTs ("DATETIME DEFAULT CURRENT_TIMESTAMP"),
  deleteTs ("DATETIME"),
  status ("INTEGER NOT NULL"), //  enum Status...deleted(0), downloaded(1),downloading(2)
  nvUpdate ("DATETIME DEFAULT CURRENT_TIMESTAMP"),
  url ("TEXT NOT NULL"),
  title ("TEXT NOT NULL"),
  author ("TEXT NOT NULL"),
  description ("TEXT NOT NULL"),
  type ("INTEGER DEFAULT 0"),
  bookmarkedEp ("INTEGER"),
  epNum ("INTEGER DEFAULT 0"),
  epViewed ("INTEGER DEFAULT 0");

  const NovelTable(this.options);
  final String options;

  static const tablename = "novels"; 
  static const pkey = "id"; 

}
enum EpisodeTable { //columns
  id ("INTEGER"),
  updateTs ("DATETIME DEFAULT CURRENT_TIMESTAMP"),
  url ("TEXT NOT NULL"),
  epUpdate ("DATETIME DEFAULT CURRENT_TIMESTAMP"),
  novelId ("INTEGER NOT NULL REFERENCES ${NovelTable.tablename} (${NovelTable.pkey}) ON DELETE CASCADE"),
  chOrder ("INTEGER"),
  epOrder ("INTEGER NOT NULL"),
  title ("TEXT NOT NULL"),
  viewed ("BOOLEAN DEFAULT 0"),;

  const EpisodeTable(this.options);
  final String options;

  static const tablename = "episodes"; 
  static const pkey = "id"; 
}
enum ChapterTable { //columns
  id ("INTEGER"),
  updateTs ("DATETIME DEFAULT CURRENT_TIMESTAMP"),
  novelId ("INTEGER NOT NULL REFERENCES ${NovelTable.tablename} (${NovelTable.pkey}) ON DELETE CASCADE"),
  title ("TEXT NOT NULL"),
  description ("TEXT"),
  chOrder ("INTEGER NOT NULL"),
  epNum ("INTEGER DEFAULT 0"),
  firstEpOrder ("INTEGER NOT NULL");

  const ChapterTable(this.options);
  final String options;

  static const tablename = "chapters"; 
  static const pkey = "id"; 
}



//     novels[id]
//         ├─updateTs
//         ├─status downloaded,downloading,deleted
//         ├─url
//         ├─title
//         ├─author
//         ├─description
//         ├─completed
//         ├─bookmarkedEp  //eporder
//         ├─epViewed
//         └─epNum
//     episodes[id]
//         ├─url
//         ├─update
//         ├─novelId -> novels[]
//         ├─order 
//         ├─title
//         ├─viewed
//         └─text //別途txtで保存してそのpath? 
//     chapters[id] 
//         ├─novelId -> novels[]
//         ├─title
//         └─firstEp -> episodes[]
//
//     histories[id]
//         ├─delete
//         ├─url
//         ├─title
//         └─author



