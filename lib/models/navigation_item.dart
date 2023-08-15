/// 底部导航
class NavigationItemModel {
  final String label;
  final String selectIcon;
  final String unselectIcon;
  final int count;

  NavigationItemModel({
    required this.label,
    required this.selectIcon,
    required this.unselectIcon,
    this.count = 0,
  });
}
