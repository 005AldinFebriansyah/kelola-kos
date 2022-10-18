import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_penghuni_kos/auth_service.dart';
import 'package:data_penghuni_kos/dataclass.dart';
import 'package:data_penghuni_kos/tambahdata.dart';
import 'package:flutter/material.dart';
import 'dbservices.dart';

class ViewPage extends StatelessWidget {
  ViewPage({Key? key}) : super(key: key);

  int _jumlah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Penghuni Kos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detData(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(        
        stream: DataBase.lihatData(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text("ERROR");
          } else if (snapshot.hasData || snapshot.data != null){
            return ListView.separated(
              itemBuilder: (context, index) {
                DocumentSnapshot dcData = snapshot.data!.docs[index];
                String lvNama = dcData['Nama'];
                String lvNIK = dcData['NIK'];
                String lvNoHP = dcData['No HP'];
                String lvAlamat = dcData['Alamat'];
                String lvNoKmr = dcData['No Kamar'];
                _jumlah = snapshot.data!.docs.length;
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  color: Color.fromARGB(255, 206, 217, 237),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lvNama,
                        style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        lvNIK,
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        lvNoHP,
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        lvAlamat,
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        lvNoKmr,
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final dtBaru = itemPenghuni(itemNama: lvNama, itemNIK: lvNIK, itemNoHP: lvNoHP, itemAlamat: lvAlamat, itemNoKmr: lvNoKmr);
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => detData(dataDet: dtBaru,)
                                  ),
                                );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.blue,),
                              ]
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DataBase.hapusData(nikhapus: lvNIK);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red,),
                              ]
                            ),
                          ),
                        ],
                      )
                    ]
                  )
                ); 
              },
              separatorBuilder: (context, index) => SizedBox(height: 5,),
              itemCount: snapshot.data!.docs.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.pinkAccent,
              ),
            ),
          );
        },
      ),
    );     
  }
}