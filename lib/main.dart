import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FirstPageContent(),
      ),
    );
  }
}

class FirstPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event to navigate to the second page
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPageContent()));
      },
      child: Container(
        width: 412,
        height: 732,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 70,
              top: 222,
              child: Text(
                'AffirmMe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 732,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 70,
            top: 222,
            child: Text(
              'AffirmMe',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 293,
            child: Text(
              'Another day, another affirmation',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
