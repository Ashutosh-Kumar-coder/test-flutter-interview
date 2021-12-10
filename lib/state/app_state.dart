import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/model/model_data.dart';
import 'package:flutter_assignment/repository/image_repository.dart';

class AppState extends ChangeNotifier {
  List<InfoModel> _list = [];

  List<InfoModel> get list => [..._list];

  void updateList(List<InfoModel> list) {
    _list = list;
    notifyListeners();
  }

  void clearList() {
    _list.clear();
    notifyListeners();
  }


  bool isLoading = true;

  void updateLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }


  Future<void> getImage(BuildContext context) async {

    List<InfoModel> data = await ImageRepository().getImage(context);
    _list = data;
    isLoading=false;
    notifyListeners();
  }
}
