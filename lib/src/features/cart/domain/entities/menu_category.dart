/// Entity representing a menu category
class MenuCategory {
  final String id;
  final String name;
  final String icon;
  final int? itemCount;

  MenuCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.itemCount,
  });
}
