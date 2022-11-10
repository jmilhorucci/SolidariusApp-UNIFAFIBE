import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/custom_drawer/home_drawer.dart';
import 'package:flutter/material.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    Key? key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  final Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  final DrawerIndex? screenIndex;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  double scrolloffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController
      ?..animateTo(1.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!
      ..addListener(() {
        if (scrollController!.offset <= 0) {
          if (scrolloffset != 1.0) {
            setState(() {
              scrolloffset = 1.0;
              try {
                widget.drawerIsOpen!(true);
              } catch (_) {}
            });
          }
          iconAnimationController?.animateTo(0.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else if (scrollController!.offset > 0 &&
            scrollController!.offset < widget.drawerWidth.floor()) {
          iconAnimationController?.animateTo(
              (scrollController!.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else {
          if (scrolloffset != 0.0) {
            setState(() {
              scrolloffset = 0.0;
              try {
                widget.drawerIsOpen!(false);
              } catch (_) {}
            });
          }
          iconAnimationController?.animateTo(1.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  void dispose() {
    iconAnimationController?.dispose();
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          // usamos com largura da tela e adicionamos gavetaWidth (de navigation_home_screen)
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                // dividimos a largura da primeira gaveta com o HomeDrawer e a largura da segunda tela cheia com toda a tela inicial, chamamos de tela View
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      // transforma que usamos para a gaveta estável, não precisamos mover com a visualização de rolagem
                      transform: Matrix4.translationValues(
                          scrollController!.offset, 0.0, 0.0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex == null
                            ? DrawerIndex.HOME
                            : widget.screenIndex,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick();
                          try {
                            widget.onDrawerCall!(indexType);
                          } catch (e) {}
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //full-screen Width with widget.screenView
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      // este IgnorePointer que usamos como touch(user Interface) widget.screen View, por exemplo scrolloffset == 1 significa que a gaveta está fechada, apenas permitimos tocar em todos os widgets.screen View
                      IgnorePointer(
                        ignoring: scrolloffset == 1 || false,
                        child: widget.screenView,
                      ),
                      // alternative touch (interface do usuário) para widget.screen, por exemplo, gaveta está fechada, precisamos tocar em algumas áreas da tela inicial e fechar a gaveta
                      if (scrolloffset == 1.0)
                        InkWell(
                          onTap: () {
                            onDrawerClick();
                          },
                        ),
                      // esta apenas animação de ícone de menu e seta
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              child: Center(
                                // se você usar sua própria interface do usuário de visualização de menu, adicionará inicialização de formulário
                                child: widget.menuView != null
                                    ? widget.menuView
                                    : AnimatedIcon(
                                        icon: widget.animatedIconData ??
                                            AnimatedIcons.arrow_menu,
                                        progress: iconAnimationController!),
                              ),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                onDrawerClick();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 então definimos para fechar a gaveta (com animação para compensar a posição zero) se não for 1 então abra a gaveta
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
