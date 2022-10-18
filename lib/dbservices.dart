import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_penghuni_kos/dataclass.dart';
import 'dataclass.dart';
CollectionReference tblData = FirebaseFirestore.instance.collection('dataPghniKmr');

class DataBase{
  static Stream<QuerySnapshot> getData(String nama){
    if(nama == "")
      return tblData.snapshots();
    else
      return tblData
      .orderBy("Nama")
      .startAt([nama]).endAt([nama + '\uf8ff'])
      .snapshots();
  }
  static Stream<QuerySnapshot> lihatData(){
    return tblData.snapshots();
  }
  static Future<void> tambahData({required itemPenghuni item}) async {
    DocumentReference docRef = tblData.doc(item.itemNIK);

    await docRef
    .set(item.toJson())
    .whenComplete(() => print("data berhasil dimasukkan"))
    .catchError((e) => print(e));
  }
  static Future<void> ubahData({required itemPenghuni item}) async{
    DocumentReference docRef = tblData.doc(item.itemNIK);

    await docRef
    .update(item.toJson())
    .whenComplete(() => print("data berhasil diubah"))    
    .catchError((e) => print(e));
  }
  static Future<void> hapusData({required String nikhapus}) async{
    DocumentReference docRef = tblData.doc(nikhapus);

    await docRef
    .delete()
    .whenComplete(() => print("data berhasil dihapus"))    
    .catchError((e) => print(e));
  }
}