import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Ajuda',
        icon: Icon(Icons.support_agent),
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'Avalie',
        icon: Icon(Icons.feedback),
      ),
      // DrawerList(
      //   index: DrawerIndex.Invite,
      //   labelName: 'Convide Amigos',
      //   icon: Icon(Icons.group),
      // ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Compartilhe',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'Sobre',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    AppTheme.background.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('assets/images/drawer-header-background.png'),
              )),
              child: Container(
                width: double.infinity,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: widget.iconAnimationController!,
                            builder: (BuildContext context, Widget? child) {
                              return ScaleTransition(
                                scale: AlwaysStoppedAnimation<double>(1.0 -
                                    (widget.iconAnimationController!.value) *
                                        0.2),
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation<double>(
                                      Tween<double>(begin: 0.0, end: 180.0)
                                              .animate(CurvedAnimation(
                                                  parent: widget
                                                      .iconAnimationController!,
                                                  curve: Curves.elasticInOut))
                                              .value /
                                          360),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/solidariusapp-logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Text(
                              'Bem-vindo(a)!',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                color: AppTheme.grey,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          // const SizedBox(
          //   height: 4,
          // ),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          // Divider(
          //   height: 1,
          //   color: AppTheme.grey.withOpacity(0.6),
          // ),
          // Column(
          //   children: <Widget>[
          //     ListTile(
          //       title: Text(
          //         'Encerrar',
          //         style: TextStyle(
          //           fontFamily: AppTheme.fontName,
          //           fontWeight: FontWeight.w600,
          //           fontSize: 16,
          //           color: AppTheme.darkText,
          //         ),
          //         textAlign: TextAlign.left,
          //       ),
          //       trailing: Icon(
          //         Icons.power_settings_new,
          //         color: Colors.red,
          //       ),
          //       onTap: () {
          //         onTapped();
          //       },
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).padding.bottom,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  void onTapped() {
    print('Doing Something...'); // Print to console.
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppTheme.nearlyPurple,
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? AppTheme.white
                                  : AppTheme.nearlyPurple),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? AppTheme.white
                              : AppTheme.nearlyOcean),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? AppTheme.white
                          : AppTheme.nearlyPurple,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  Help,
  FeedBack,
  Share,
  About,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
