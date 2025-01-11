import 'package:flutter/material.dart';

class RouteAnimation extends PageRouteBuilder {
  final Widget page;

  RouteAnimation({required this.page})
      : super(
            pageBuilder: (context, animation, animationTow) => page,
            transitionsBuilder: (context, animation, animationTow, child) {
              var begin = const Offset(1, 0); //x ,y
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end);

// var curvesAnimation =CurvedAnimation(parent: animation, curve: Curves.ease);

              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
// return SlideTransition(position: tween.animate(curvesAnimation),child: child,);
            });
}
