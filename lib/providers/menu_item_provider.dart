import 'package:potagenieux/providers/illuminable.dart';

class MenuItemProvider extends Illuminable {
  late ShadingItem selectedItem;

  MenuItemProvider() {
    selectedItem = ShadingItem.home;
  }
  select(ShadingItem item) {
    selectedItem = item;
    notifyListeners();
  }
}
