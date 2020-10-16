import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lingkung_courier/screens/authenticate/login.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';

class Onboarding extends StatelessWidget {
  final pageDecoration = PageDecoration(
    titleTextStyle: PageDecoration().titleTextStyle.copyWith(
          fontFamily: "Poppins",
          color: green,
          fontSize: 34.0,
        ),
    bodyTextStyle: PageDecoration().bodyTextStyle.copyWith(
          fontFamily: "Poppins",
          color: grey,
          fontSize: 14.0,
        ),
    contentPadding: const EdgeInsets.all(20),
  );

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Image.asset("assets/images/reduce.png"),
        ),
        title: "REDUCE",
        body:
            "Mengurangi penggunaan barang dengan material sekali pakai dan dapat merusak lingkungan.",
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Image.asset("assets/images/reuse.png"),
        ),
        title: "REUSE",
        body:
            "Menggunakan kembali barang atau material sisa yang masih bisa dan aman untuk dipakai, dengan fungsi yang lain.",
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Image.asset("assets/images/recycle.png"),
        ),
        title: "RECYCLE",
        body:
            "Mendaur ulang atau Mengolah barang tidak terpakai (sampah) menjadi barang yang bermanfaat dan bahkan memiliki nilai jual.",
        decoration: pageDecoration,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: getPages(),
        onDone: () {},
        next: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: CustomText(
            text: 'LANJUT',
            color: green,
            weight: FontWeight.w700,
          ),
        ),
        done: FlatButton(
          color: green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: CustomText(
            text: 'MULAI',
            color: white,
            weight: FontWeight.w700,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(8.0),
          activeSize: const Size(10.0, 10.0),
          activeColor: green,
          color: green.withOpacity(0.5),
          spacing: const EdgeInsets.symmetric(horizontal: 4.0),
        ),
      ),
    );
  }
}
