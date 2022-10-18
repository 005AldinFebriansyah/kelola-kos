import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dbservices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchText = TextEditingController();

  @override
  void dispose() {
    _searchText.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    _searchText.addListener(onSearch);
    // TODO: implement initState
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> onSearch(){
    setState(() {
      
    });
    return DataBase.getData(_searchText.text);
  }
  int _currentIndex = 0;
  int _jumlah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: Column(
          children: [
            TextField(
              controller: _searchText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue)
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("EROR");
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String lvNama = dsData['Nama'];
                          String lvNIK = dsData['NIK'];
                          String lvNoHP = dsData['No HP'];
                          String lvAlamat = dsData['Alamat'];
                          String lvNoKmr = dsData['No Kamar'];
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
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 8.0),
                        itemCount: snapshot.data!.docs.length);
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
