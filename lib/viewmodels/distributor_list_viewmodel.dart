import 'package:flutter/widgets.dart';

class DistributorListViewmodel with ChangeNotifier {
  // All the DistributorListScreen logic manages here
  bool _isDistributorSelected = true;

  // getter
  bool get isDistributorSelected => _isDistributorSelected;

  void selectDistributor() {
    _isDistributorSelected = true;
    notifyListeners();
  }

  void selectRetailer() {
    _isDistributorSelected = false;
    notifyListeners();
  }
}
