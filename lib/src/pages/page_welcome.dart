import 'dart:math';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart" show AnimatedContainer, AppBar, BorderRadius, BoxDecoration, BuildContext, Colors, Column, EdgeInsets, Expanded, MainAxisAlignment, Padding, PageView, Row, SafeArea, Scaffold, SizedBox, Spacer, State, StatefulWidget, Widget;


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:structurepublic/src/pages/loginEmail.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePage createState() => _WelcomePage();
}
class _WelcomePage extends State<WelcomePage> {
  List<PageViewModel> getPages() {
    return [

      PageViewModel(
          image: Image.asset("assets/img/welcome3.jpg",height: 500,),
          title: "مرحبا",
          body: "لنقم بالتسوق من المنزل بسهولة",
        //  footer: Text("Footer Text here "),
          decoration: const PageDecoration(
            bodyTextStyle: TextStyle(color: Colors.black,fontSize: 18),
        //  pageColor:   Color.fromRGBO(143, 148, 251, .6),
            titleTextStyle: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold)
          )
      ),
      PageViewModel(
        image: Image.asset("assets/img/welcome2.jpg"),
        title: "الهدف",
        body: "نحن نساعد الناس على التواصل مع المتجر لتلبية احتياجاتهم في جميع أنحاء سوريا",
       // footer: Text("Footer Text  here "),
          decoration: const PageDecoration(
              bodyTextStyle: TextStyle(color: Colors.black,fontSize: 18),

              titleTextStyle: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold)
          )
      ),
      PageViewModel(
        image: Image.asset("assets/img/welcome1.jpg"),
        title: "ابقى في المنزل",
        body: "نعرض لك الطريقة السهلة للتسوق حول العالم\n فقط ابق في المنزل معنا",
          decoration: const PageDecoration(
              bodyTextStyle: TextStyle(color: Colors.black,fontSize: 18),
            //pageColor: Colors.black12,
              titleTextStyle: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold)
          )

        // footer: Text("Footer Text  here "),
      ),
      PageViewModel(
        image: Image.asset("assets/img/welcome4.jpg"),
        title: "هل انت جاهز",
        body: "مرحبًا بكم في متجر إنفينيتي",
   //     footer: Text("Footer Text  here "),
          decoration: const PageDecoration(
              bodyTextStyle: TextStyle(color: Colors.black,fontSize: 18),
            //pageColor: Colors.black12,
              titleTextStyle: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold)
          )
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Introduction Screen"),
      // ),
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        showNextButton: true,
        dotsDecorator: DotsDecorator(
          color: Colors.red[900],
          activeColor: Colors.white,
        ),
        showSkipButton: true,
        skip: Text("تخطي"),
        done: Text("اذهب"),
        onDone: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ( context) => LoginEmail() ) );
        },

      ),
    );
  }
}



// class DotsIndicator extends AnimatedWidget {
//   DotsIndicator({
//     this.controller,
//     this.itemCount,
//     this.onPageSelected,
//     this.color: Colors.white,
//   }) : super(listenable: controller);
//
//   /// The PageController that this DotsIndicator is representing.
//   final PageController controller;
//
//   /// The number of items managed by the PageController
//   final int itemCount;
//
//   /// Called when a dot is tapped
//   final ValueChanged<int> onPageSelected;
//
//   /// The color of the dots.
//   ///
//   /// Defaults to `Colors.white`.
//   final Color color;
//
//   // The base size of the dots
//   static const double _kDotSize = 8.0;
//
//   // The increase in the size of the selected dot
//   static const double _kMaxZoom = 2.0;
//
//   // The distance between the center of each dot
//   static const double _kDotSpacing = 25.0;
//
//   Widget _buildDot(int index) {
//     double selectedness = Curves.easeOut.transform(
//       max(
//         0.0,
//         1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
//       ),
//     );
//     double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
//     return new Container(
//       width: _kDotSpacing,
//       child: new Center(
//         child: new Material(
//           color: color,
//           type: MaterialType.circle,
//           child: new Container(
//             width: _kDotSize * zoom,
//             height: _kDotSize * zoom,
//             child: new InkWell(
//               onTap: () => onPageSelected(index),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget build(BuildContext context) {
//     return new Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: new List<Widget>.generate(itemCount, _buildDot),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State createState() => new MyHomePageState();
// }
//
// class MyHomePageState extends State<MyHomePage> {
//
//   final _controller = new PageController();
//
//   static const _kDuration = const Duration(milliseconds: 300);
//
//   static const _kCurve = Curves.ease;
//
//   final _kArrowColor = Colors.black.withOpacity(0.8);
//
//   final List<Widget> _pages = <Widget>[
//     new ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//       child: new FlutterLogo(colors: Colors.blue),
//     ),
//     new ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//       child: new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
//     ),
//     new ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//       child: new FlutterLogo(style: FlutterLogoStyle.horizontal, colors: Colors.green),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new IconTheme(
//         data: new IconThemeData(color: _kArrowColor),
//         child: new Stack(
//           children: <Widget>[
//             new PageView.builder(
//               physics: new AlwaysScrollableScrollPhysics(),
//               controller: _controller,
//               itemBuilder: (BuildContext context, int index) {
//                 return _pages[index % _pages.length];
//               },
//             ),
//             new Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: new Container(
//                 color: Colors.grey[800].withOpacity(0.5),
//                 padding: const EdgeInsets.all(20.0),
//                 child: new Center(
//                   child: new DotsIndicator(
//                     controller: _controller,
//                     itemCount: _pages.length,
//                     onPageSelected: (int page) {
//                       _controller.animateToPage(
//                         page,
//                         duration: _kDuration,
//                         curve: _kCurve,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:introduction_screen/introduction_screen.dart';
//
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:introduction_screen/introduction_screen.dart';
//
//
// class PageViewDemo extends StatefulWidget {
//   @override
//   _PageViewDemoState createState() => _PageViewDemoState();
// }
//
// class _PageViewDemoState extends State<PageViewDemo> {
//   PageController _controller = PageController(
//     initialPage: 0, viewportFraction: 0.8
//   );
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       controller: _controller,
//       children: [
//         Image.asset("assets/img/ic.png"),
//         Image.asset("assets/img/pp1.PNG"),
//         Image.asset("assets/img/pp1.PNG"),
//       ],
//     );
//   }
// }