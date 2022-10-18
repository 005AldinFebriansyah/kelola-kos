import 'package:data_penghuni_kos/auth_service.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.house,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 75),
              Text(
                "Hallo!",
                style: GoogleFonts.bebasNeue(fontSize: 48),
              ),
              SizedBox(height: 10),
              Text(
                "Selamat Datang Kembali",
                style: GoogleFonts.bebasNeue(fontSize: 36),
              ),
              SizedBox(height: 10),
              Text(
                "Silahkan Masuk Menggunakan Akun Google",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 50),
              ElevatedButton.icon(
                label: Text("Masuk dengan Google"),
                onPressed: () {
                  AuthService().signInWithGoogle();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity, 50)
                ), 
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
