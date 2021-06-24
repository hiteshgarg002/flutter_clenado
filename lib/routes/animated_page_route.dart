import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class AnimatedPageRoute {
  static Route<T> fadeThroughPageRoute<T>(Function page) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child);
      },
    );
  }

  static Route<T> fadeScalePageRoute<T>(Function page) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<T> sharedAxisPageRoute<T>(Function page,
      [SharedAxisTransitionType type = SharedAxisTransitionType.scaled]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
        );
      },
    );
  }
}
