import 'package:flutter/material.dart';
import 'package:urjaa/UI/themes/urjaa_theme.dart';
import '../pages/registration_page_view.dart';
import '../pages/login_page_view.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  TabController? _authTabController;

  PageController _authTabPageController = new PageController(
    initialPage: 0,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _authTabController = new TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var totalSize = Size(double.infinity, AppBar().preferredSize.height * 2.5);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: UrjaaTheme.background,
      appBar: PreferredSize(
        preferredSize: totalSize,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            width: double.infinity,
            height: totalSize.height,
            child: AppBar(
              backgroundColor: Color(0x00000000),
              elevation: 0,
              bottom: TabBar(
                labelColor: UrjaaTheme.tertiaryColor,
                unselectedLabelColor: UrjaaTheme.grayLight,
                indicatorColor: UrjaaTheme.tertiaryColor,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
                onTap: (value) async {
                  await _authTabPageController.animateToPage(
                    value,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.decelerate,
                  );
                },
                controller: _authTabController,
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: PageView(
          onPageChanged: (value) async {
            _authTabController?.animateTo(
              value,
              duration: Duration(milliseconds: 400),
              curve: Curves.decelerate,
            );
          },
          controller: _authTabPageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            LoginPageView(),
            RegistrationPageView(),
          ],
        ),
      ),
    );
  }
}
