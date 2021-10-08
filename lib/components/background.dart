import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 150,
            child: Image.asset(
              'assets/images/top1.png',
              width: size.width,
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 50,
          //   child: Image.asset(
          //     'assets/images/top2.png',
          //     width: size.width,
          //   ),
          // ),
          Positioned(
            top: 0,
            right: 230,
            bottom: size.height / 1.45,
            child:
                Image.asset('assets/images/logo.png', width: size.width * 0.35),
          ),
          Positioned(
            bottom: -20,
            right: 100,
            child: Image.asset("assets/images/bottom1.png", width: size.width),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Image.asset("assets/images/bottom2.png", width: size.width),
          // ),
          child
        ],
      ),
    );
  }
}
