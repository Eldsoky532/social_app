import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/Loginscreen/loggin.dart';
import 'package:social_app/utiles/constant.dart';

import 'Model/model.dart';

class onBoardingScreen extends StatelessWidget {
  onBoardingScreen({Key? key}) : super(key: key);
  var Boardcontroller = PageController();
  List<Boarding> Bmodel = [
    Boarding(
        image: 'assets/images/c.png', title: title1, description: desciption1),
    Boarding(
        image: 'assets/images/cc.png', title: title2, description: desciption2),
    Boarding(
        image: 'assets/images/ccc.png',
        title: title3,
        description: desciption3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => onBoardingItem(Bmodel[index]),
                itemCount: Bmodel.length,
                controller: Boardcontroller,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: Boardcontroller, count: Bmodel.length,

                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: .5
                ),

                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>LoginScreen()),
                    );
                    },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(Boarding boarding) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image(image: AssetImage('${boarding.image}'))),
            SizedBox(
              height: 30,
            ),
            Text(
              '${boarding.title}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '${boarding.description}',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      );
}
