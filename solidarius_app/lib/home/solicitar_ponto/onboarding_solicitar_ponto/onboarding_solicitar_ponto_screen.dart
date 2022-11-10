import 'package:flutter/material.dart';
import 'package:solidarius_app/home/solicitar_ponto/form_solicitar_ponto/form_solicitar_ponto_screen.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/onboarding_mapa_view.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/center_next_button.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/onboarding_seguranca_view.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/onboarding_requisitos_view.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/onboarding_home_view.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/top_back_skip_view.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/components/onboarding_welcome_view.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class OnboardingSolicitarPontoScreen extends StatefulWidget {
  OnboardingSolicitarPontoScreen({Key? key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

GlobalKey<FormState> _formSolicitaPonto = GlobalKey<FormState>();

class _IntroductionAnimationScreenState
    extends State<OnboardingSolicitarPontoScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: ClipRect(
        child: Stack(
          children: [
            OnboardingHomeView(
              animationController: _animationController!,
            ),
            OnboardingRequisitosView(
              animationController: _animationController!,
            ),
            OnboardingMapaView(
              animationController: _animationController!,
            ),
            OnboardingSegurancaView(
              animationController: _animationController!,
            ),
            OnboardingWelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FormSolicitarPontoScreen(),
      ),
    );
  }
}
