import 'package:flutter/cupertino.dart';
import 'package:todo/models/task.dart';

import '../service/local_db/database_helper.dart';

class HomeScreenProvider extends ChangeNotifier {

  DatabaseHelper db = DatabaseHelper();

  List<Map<String, dynamic>> myTaskList = [];

  void fetchAllTask() async{
    print("fetchalltask called");
    myTaskList = await db.fetchAllTask();
    print("MyTaskList is ${myTaskList}");
    notifyListeners();
  }


}