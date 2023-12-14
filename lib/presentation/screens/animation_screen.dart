import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:lottie/lottie.dart';

class AnimatScreen extends StatefulWidget {
  @override
  _AnimatScreenState createState() => _AnimatScreenState();
}

class _AnimatScreenState extends State<AnimatScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  Timer? _animationTimer;
  double _opacity = 1.0;

  Color _backgroundColor1 = PrimaryColors.Colorone;
  Color _backgroundColor2 = PrimaryColors.Colortwo;
  final Duration _animationDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _animationTimer = Timer.periodic(_animationDuration, (timer) {
      setState(() {
        if (_backgroundColor1 == PrimaryColors.Colorone) {
          _backgroundColor1 = PrimaryColors.Colortwo;
          _backgroundColor2 = PrimaryColors.Colorone;
        } else {
          _backgroundColor1 = PrimaryColors.Colorone;
          _backgroundColor2 = PrimaryColors.Colortwo;
        }

        _opacity = _opacity == 1.0 ? 0.0 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scaleController.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }

  void _nextAnimation() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: _animationDuration,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_backgroundColor1, _backgroundColor2],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    Lottie.asset('assets/animation/A1.json'),
                    Lottie.asset('assets/animation/A2.json'),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  onTapDown: (_) => _scaleController.forward(),
                  onTapUp: (_) => _scaleController.reverse(),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: PrimaryColors.Colorthree,
                        backgroundColor: PrimaryColors.Colortwo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      onPressed: _nextAnimation,
                      child: Text('Next Animation'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
