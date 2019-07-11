import 'package:flutter/material.dart';

import 'package:no_doubts_app/api/user_api.dart';
import 'package:no_doubts_app/pages/login_page.dart';
import 'package:no_doubts_app/utils/token_storage.dart';

class HomePage extends StatefulWidget {
  final TokenStorage storage;

  HomePage({ Key key, @required this.storage }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  bool isLoading;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, initialIndex: 1, length: 2);
    isLoading = false;
  }

  void exitToLogin() {
    setState(() {
        isLoading = true;
      });
    logout()
      .then((_) {
        widget.storage.writeTokenToFile('', ACCESS_TOKEN_FILE);
        widget.storage.writeTokenToFile('', REFRESH_TOKEN_FILE);
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => LoginPage(storage: new TokenStorage())),
        );
      })
      .catchError((_) {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/icon.png',
            fit: BoxFit.contain,
            width: 50.0,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: "DÚVIDAS"),
            Tab(text: "ASSUNTOS"),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              child: isLoading
              ? Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white)
              )
              : Icon(Icons.exit_to_app),
              onTap: () => this.exitToLogin(),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Text("Doubts"),
          Text("Topics"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
        onPressed: () => print("Create doubt"),
      ),
    );
  }
}