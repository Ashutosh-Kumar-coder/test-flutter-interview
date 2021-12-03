import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/repository/image_repository.dart';

class AppState extends ChangeNotifier {
  List<dynamic> _list = [];

  List<dynamic> get list => [..._list];
List<dynamic> carouselList=[];
  void updateList(List<dynamic> list) {
    _list = list;
    notifyListeners();
  }

  void clearList() {
    _list.clear();
    notifyListeners();
  }
 void getCarouselList(){
    for(int i=0;i<=4;i++){
      carouselList.add(list[i]);
    }
    notifyListeners();
  }

  bool isLoading = true;

  void updateLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }


  Future<void> getImage(BuildContext context) async {

    List<dynamic> data = await ImageRepository().getImage(context, 20);

    _list = data;
    getCarouselList();
    isLoading=false;
    notifyListeners();
  }
}
