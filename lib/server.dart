import 'package:cloud_firestore/cloud_firestore.dart';


class server{

  static void addData(String data) async{
   await Firestore.instance.collection("data").add({"data_name":data})
   .catchError((e){print(e);});
   print("executed");
  }

}