import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:data_penghuni_kos/auth_service.dart';
import 'package:data_penghuni_kos/user.dart';
import 'package:data_penghuni_kos/button.dart';
import 'package:data_penghuni_kos/dialogCard.dart';

class ProfilePage extends StatelessWidget {
  String id;
  ProfilePage(this.id){
    if (id == 'a'){
      id = AuthService().user.uid;
    }
  }
  //const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      backgroundColor: Colors.white,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Container(
          color: Color.fromARGB(255, 245, 247, 254),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: data(context),
            ),
          ),
        ),
      ),
    );
  }
  List<Widget> data(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> list = [];
    list.add(
      StreamBuilder<dynamic>(
        stream: User().getUser(AuthService().user.uid),
        builder: (_, snapshot) {
          if (snapshot.hasData == true) {
            var my_data = snapshot.data;
            return info(context, my_data['name'], my_data['email'],
                my_data['noHP'], my_data['profilePhoto'], size);
          } else {
            return Text("Loading");
          }
        },
      ),
    );
    return list;
  }
  Widget info(
      BuildContext context, var name, var email, var noHP, var img, var size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 50),
            height: size.height / 5,
            width: size.width,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.only(left: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ListTile(
                      title: Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      subtitle:
                          Text(email, style: TextStyle(fontFamily: 'Poppins')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        noHP,
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            child: Button(
                                text: Text('Edit Profil'),
                                color: Colors.green,
                                onPressed: () => DialogCard()
                                    .call(context, updateData(context)))),
                        Button(
                            text: Text("Logout"),
                            color: Colors.red,
                            onPressed: () => DialogCard().call(
                                context,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Yakin ingin keluar ?',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Button(
                                            text: Text('Batal'),
                                            onPressed: () =>
                                                Navigator.pop(context)),
                                        Button(
                                            text: Text('Logout'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              AuthService().signOut();
                                            },
                                            color: Colors.red)
                                      ],
                                    )
                                  ],
                                )))
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: size.height / 25),
                height: size.height / 7,
                width: size.height / 7,
                child: Material(
                  elevation: 10,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(img),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget updateData(BuildContext context) {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerPhoto = TextEditingController();
    TextEditingController controllerNoHP = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text('Edit Data',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700))),
        Container(
            margin: EdgeInsets.only(top: 30),
            child: Input(controllerName, 'Nama Lengkap')),
        Input(controllerPhoto, 'Foto Profil'),
        Input(controllerNoHP, 'noHP'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Button(
                    text: Text('Batal'),
                    color: Colors.red,
                    onPressed: () => Navigator.pop(context))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Button(
                    text: Text('Reset'),
                    color: Colors.green.shade800,
                    onPressed: () {
                      User().reset();
                      Navigator.pop(context);
                    })),
            Button(
              text: Text('Simpan'),
              color: Colors.green.shade800,
              onPressed: () {
                User().update(controllerName.text, controllerNoHP.text,
                    controllerPhoto.text);
                Navigator.pop(context);
              },
            )
          ],
        )
      ],
    );
  }
  Container Input(TextEditingController controllerName, String name) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: controllerName,
          decoration: InputDecoration(
            label: Text(name,
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
            hintStyle: TextStyle(fontFamily: 'Poppins'),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
          ),
        ));
  }
}