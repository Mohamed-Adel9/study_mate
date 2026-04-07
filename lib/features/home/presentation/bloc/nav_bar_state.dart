class NavBarState {
  final int currentIndex;
  const NavBarState({this.currentIndex = 0});

  NavBarState copyWith({int? currentIndex}) =>
      NavBarState(currentIndex: currentIndex ?? this.currentIndex);
}