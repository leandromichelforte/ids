import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ids/views/home_view.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashScreenView(
          navigateRoute: HomeView(),
          duration: 3000,
          text: "Desenvolvimento de Software e Acessoria LTDA",
          textType: TextType.ColorizeAnimationText,
          imageSrc: "assets/images/ids_logo.png",
          colors: [
            Colors.blue[900]!,
            Colors.blue,
          ],
          textStyle: GoogleFonts.raleway(
            color: Colors.blue[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
