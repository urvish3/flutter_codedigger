import 'package:db_miner2/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random random = Random();
  List images = [
    "assets/images/1.jpg",
   "assets/images/3.jpg",
    "assets/images/5.jpg",
    "assets/images/2.jpg",
    "assets/images/4.jpg",
  ];

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LandingScreen(),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage(
                images[random.nextInt(images.length)],
              ),
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Animal Biography",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  "Ready to Watch?",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Animal biography is a global leader in real life entertainment serving a passionate audience of super fans around the world with content that inspires, informs and entertains.",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
