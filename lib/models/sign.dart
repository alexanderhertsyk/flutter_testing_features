class Sign {
  final bool isCross;
  final int move;
  final bool _isWin;

  bool get isWin => _isWin;

  Sign({required this.isCross, required this.move}) : _isWin = false;

  Sign.win(Sign sign)
      : isCross = sign.isCross,
        move = sign.move,
        _isWin = true;
}
