class Settings {
  static const int kDefaultWinCount = 3;
  static const int kDefaultRowCount = kDefaultWinCount;
  static const int kDefaultColumnCount = kDefaultWinCount;
  static const int kDefaultPlayers = 2;
  static final Settings _instance = Settings._();

  int rowCount = kDefaultRowCount;
  int columnCount = kDefaultColumnCount;
  int winCount = kDefaultWinCount;

  Settings._();

  factory Settings() => _instance;

  bool save(
      {int rowCount = kDefaultRowCount,
      int columnCount = kDefaultColumnCount,
      int winCount = kDefaultWinCount}) {
    this.winCount = winCount;
    this.rowCount = rowCount;
    this.columnCount = columnCount;
    // TODO: add possibility checks
    return true;
  }
}
