import 'package:flutter/material.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class OnboardingRequisitosView extends StatelessWidget {
  final AnimationController animationController;

  const OnboardingRequisitosView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _textAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _imageAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _relaxAnimation =
        Tween<Offset>(begin: Offset(0, -2), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _relaxAnimation,
                child: Text(
                  "Requisitos",
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.nearlyPurple),
                ),
              ),
              SlideTransition(
                position: _textAnimation,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 0),
                  child: Text(
                    "Para se tornar um ponto de coleta no Solidariu's, é necessário ser uma instituição física com CNPJ ativo, como escolas, hospitais, lojas, mercados, até mesmo grandes e pequenas empresas, seja elas privadas ou públicas.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SlideTransition(
                position: _imageAnimation,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500, maxHeight: 500),
                  child: Image.asset(
                    'assets/introduction_animation/negocio_loop_verde.gif',
                    fit: BoxFit.contain,
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
