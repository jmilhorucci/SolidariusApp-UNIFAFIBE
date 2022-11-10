import 'package:flutter/material.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class TopBackSkipView extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onBackClick;
  final VoidCallback onSkipClick;

  const TopBackSkipView({
    Key? key,
    required this.onBackClick,
    required this.onSkipClick,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _animation =
        Tween<Offset>(begin: Offset(0, -1), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    // final _backAnimation =
    //     Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0))
    //         .animate(CurvedAnimation(
    //   parent: animationController,
    //   curve: Interval(
    //     0.6,
    //     0.8,
    //     curve: Curves.fastOutSlowIn,
    //   ),
    // ));
    final _skipAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _animation,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: SizedBox(
                    width: 58,
                    height: 58,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(38.0)),
                      splashColor: AppTheme.grey.withOpacity(0.2),
                      onTap: () {
                        onBackClick();
                      },
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: SlideTransition(
                    position: _skipAnimation,
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      // child: IconButton(
                      //   onPressed: onSkipClick,
                      //   icon: Text('Pular'),
                      // ),
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(38.0)),
                        splashColor: AppTheme.grey.withOpacity(0.2),
                        onTap: () {
                          onSkipClick();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pular',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
