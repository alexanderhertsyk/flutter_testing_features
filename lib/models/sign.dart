class Sign {
  final bool isCross;
  // TODO: replace w/ enum?
  final int order;
  final bool isWin;

  Sign({required this.isCross, required this.order, this.isWin = false});

  Sign.win(Sign sign)
      : isCross = sign.isCross,
        order = sign.order,
        isWin = true;
}
