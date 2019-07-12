import 'package:flutter/material.dart';

import 'package:no_doubts_app/api/user_api.dart';
import 'package:no_doubts_app/api/doubt_api.dart';
import 'package:no_doubts_app/models/doubt_model.dart';
import 'package:no_doubts_app/pages/login_page.dart';
import 'package:no_doubts_app/utils/internal_storage.dart';
import 'package:no_doubts_app/utils/utils.dart';

class HomePage extends StatefulWidget {
  final InternalStorage storage;
  final String userEmail;
  final List<String> tokens;

  HomePage({ Key key, @required this.storage, @required this.userEmail, @required this.tokens }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  bool isExiting;
  bool isLoading;
  bool retryRequest;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
    isLoading = false;
    isExiting = false;
    retryRequest = false;
    fetchDoubts();
  }

  void fetchDoubts() {
    setState(() {
      isLoading = true;
      retryRequest = false;
    });
    getDoubts(widget.userEmail, widget.tokens).then((value) {
      switch (value) {
        case RETRY:
          widget.storage.readFile(ACCESS_TOKEN_FILE).then((String newToken) {
            widget.tokens.insert(0, newToken);
            setState(() {
              isLoading = false;
              retryRequest = true;
            });
          });
          break;
        case '':
          exitToLogin();
          break;
        default:
          setState(() {
            isLoading = false;
          });
          
          final doubts = doubtsFromJson(value);
          print(doubts);
      }
    });
  }

  void exitToLogin() {
    setState(() {
        isExiting = true;
      });
    logout(widget.tokens)
      .then((_) {
        widget.storage.writeTokens('', '');
        widget.storage.writeStringToFile('', EMAIL_FILE);
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => LoginPage(storage: new InternalStorage())),
        );
      })
      .catchError((_) {
        isExiting = false;
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
            child: isExiting
            ? Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white)
              )
            : InkWell(
              child: Icon(Icons.exit_to_app),
              onTap: () => this.exitToLogin(),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          retryRequest
          ? InkWell(
            child: Icon(Icons.restore),
            onTap: () => this.fetchDoubts(),
          )
          : isLoading
          ? Center(
              child: CircularProgressIndicator()
            )
          : Text("Doubts"),
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