import 'package:flutter/material.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class OnboardingHomeView extends StatefulWidget {
  final AnimationController animationController;

  const OnboardingHomeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _OnboardingHomeViewState createState() => _OnboardingHomeViewState();
}

class _OnboardingHomeViewState extends State<OnboardingHomeView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Solicitar Ponto de Coleta",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.nearlyPurple),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/introduction_animation/doacao_loop_verde.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32),
              child: Text(
                "Aqui ajudamos você para ajudar o próximo. Bora espalhar sorrisos por ai?\n\nAvance para ver mais detalhes de como solicitar um ponto de coleta.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(38.0)),
                splashColor: AppTheme.grey.withOpacity(0.2),
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: AppTheme.nearlyPurple,
                  ),
                  child: Text(
                    "Avançar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
