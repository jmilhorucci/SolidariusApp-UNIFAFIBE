import 'package:flutter/material.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class OnboardingWelcomeView extends StatelessWidget {
  final AnimationController animationController;

  String? selectedItem;

  OnboardingWelcomeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _welcomeFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _welcomeImageAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _welcomeImageAnimation,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 350, maxHeight: 350),
                  child: Image.asset(
                    'assets/introduction_animation/unidos_loop_verde.gif',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SlideTransition(
                position: _welcomeFirstHalfAnimation,
                child: Text(
                  "Vamos começar?",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.nearlyPurple),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                child: Text(
                  "Toque no botão abaixo para ir ao formulário de solicitação.\n\nApós preencher todos os campos obrigatórios (*), revise as informações antes de enviar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
