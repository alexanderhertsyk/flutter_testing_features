class Sign {
  final bool isCross;
  final int fromMove;
  final bool _isWin;

  bool get isWin => _isWin;

  Sign({required this.isCross, required this.fromMove}) : _isWin = false;

  Sign.win(Sign sign)
      : isCross = sign.isCross,
        fromMove = sign.fromMove,
        _isWin = true;
}
