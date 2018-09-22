import 'package:flutter/material.dart';

///Start point of app is main function.
void main() => runApp(ChangeFlyApp());

///StatelessWidget
class ChangeFlyApp extends StatelessWidget {
  final String mainTitle = "changefly";
  @override
  Widget build(BuildContext context) {
    ///MaterialApp for creating a app with Material design components.
    return MaterialApp(
      ///Dismiss debug banner.
      debugShowCheckedModeBanner: false,
      ///Main title of application.
      title: mainTitle,
      home: SplashPage(),
    );
  }
}
///StatefulWidget that contains animation.
class SplashPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
///TickerProviderStateMixin is a class which sends a signal at almost regular interval.
class _HomePageState extends State<SplashPage> with TickerProviderStateMixin {
  ///Define animations and controller.
  AnimationController _controller;
  Animation<double> _fadeCube;
  Animation<double> _skewLeft;
  Animation<double> _skewRight;
  Animation<Offset> _translateTop;
  Animation<Offset> _translateLeft;
  Animation<Offset> _translateRight;
  Animation<double> _fadeName;

  ///Apply changes in screen needs this method.
  @override
  void initState() {
    super.initState();
    startAnim();
  }


///A method for initializing animations and controller.
  void startAnim() {
    ///Release the controller.
    _controller?.dispose();
    ///Initialize controller with specific duration.
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);


    ///Initialize animations.

    _fadeCube = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );

    _skewLeft = Tween<double>(begin: 0.3, end: 0.0)
        .animate(CurvedAnimation(parent: _fadeCube, curve: Curves.easeOut));

    _skewRight = Tween<double>(begin: 0.3, end: 0.0)
        .animate(CurvedAnimation(parent: _fadeCube, curve: Curves.easeOut));

    _translateTop = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
        .animate(_fadeCube);

    _translateLeft = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
        .animate(_fadeCube);

    _translateRight = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
        .animate(_fadeCube);

    _fadeName = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.6, 0.9)));

    _controller.forward(from: 0.0);
  }

  ///Release the controller.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      ///Give some padding.
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 150.0),
        ///Make alignment for top center.
        child: Align(
          alignment: Alignment.topCenter,
          ///Put cube images and name in a column.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ///Animates the opacity of a widget.
              FadeTransition(
                opacity: _fadeCube,
                ///Put the all of images in stack for animating them.
                child: Stack(
                  children: <Widget>[
                    ///A general-purpose widget for building animations.
                  AnimatedBuilder(
                  animation: _skewLeft,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      origin: Offset.zero,
                      alignment: Alignment.center,
                      transform: Matrix4.skew(_skewLeft.value, -_skewLeft.value),
                      child: child,
                    );
                  },
                    ///Animates the position of a widget relative to its normal position.
                  child:SlideTransition(
                      position: _translateTop,
                      ///Get image from assets.
                      child: Image.asset('assets/changefly-cube-top.png',
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                    //A general-purpose widget for building animations
                    AnimatedBuilder(
                      animation: _skewLeft,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          origin: Offset.zero,
                          alignment: Alignment.center,
                          transform: Matrix4.skew(_skewLeft.value, -_skewLeft.value),
                          child: child,
                        );
                      },
                      ///Animates the position of a widget relative to its normal position.
                      child: SlideTransition(
                        position: _translateLeft,
                        ///Get image from assets.
                        child: Image.asset('assets/changefly-cube-left.png',
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                    ),
                    ///A general-purpose widget for building animations.
                    AnimatedBuilder(
                      animation: _skewRight,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          origin: Offset.zero,
                          alignment: Alignment.center,
                          transform: Matrix4.skew(_skewRight.value, _skewRight.value),
                          child: child,
                        );
                      },
                      ///Animates the position of a widget relative to its normal position.
                      child: SlideTransition(
                        position: _translateRight,
                        ///Get image from assets.
                        child: Image.asset('assets/changefly-cube-right.png',
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
              FadeTransition(
                opacity: _fadeName,
                ///Get image from assets.
                child: Image.asset('assets/changefly-name.png',
                  width: 260.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

