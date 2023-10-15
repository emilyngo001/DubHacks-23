import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> isSecondPageNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: ValueListenableBuilder<bool>(
            valueListenable: isSecondPageNotifier,
            builder: (context, isSecondPage, child) {
              return isSecondPage ? SecondPageContent() : FirstPageContent();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            isSecondPageNotifier.value = !isSecondPageNotifier.value;
          },
          child: const Icon(Icons.swap_horiz),
        ),
      ),
    );
  }
}

class FirstPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      width: 500,
      height: 700,
      padding: const EdgeInsets.only(
        top: 259,
        left: 64,
        right: 65,
        bottom: 320,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0x49BBB0FF)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Welcome!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      width: 412,
      height: 732,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          const Positioned(
            left: 70,
            top: 135,
            child: Text(
              'What are \nyour goals?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          const Positioned(
            left: 70,
            top: 273,
            child: Text(
              'Let’s personalize your affirmations\nbased on the goals that you choose',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 92,
            top: 337,
            child: Container(
              width: 227,
              height: 41,
              decoration: ShapeDecoration(
                color: const Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 92,
            top: 392,
            child: Container(
              width: 227,
              height: 41,
              decoration: ShapeDecoration(
                color: const Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 92,
            top: 447,
            child: Container(
              width: 227,
              height: 40,
              decoration: ShapeDecoration(
                color: const Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 92,
            top: 501,
            child: Container(
              width: 227,
              height: 41,
              decoration: ShapeDecoration(
                color: const Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 147,
            top: 348,
            child: SizedBox(
              width: 118,
              height: 21,
              child: Text(
                'Inspiration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 133,
            top: 402,
            child: SizedBox(
              width: 146,
              height: 21,
              child: Text(
                'Goal-oriented',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 104,
            top: 511,
            child: SizedBox(
              width: 203,
              height: 21,
              child: Text(
                'Change-oriented',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 92,
            top: 556,
            child: Container(
              width: 227,
              height: 41,
              decoration: ShapeDecoration(
                color: const Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 149,
            top: 566,
            child: SizedBox(
              width: 114,
              height: 21,
              child: Text(
                'Gratitude',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 126,
            top: 457,
            child: SizedBox(
              width: 159,
              height: 21,
              child: Text(
                'Complementary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}