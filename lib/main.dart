import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_demo_1/models/Use.dart';
import 'package:flutter_demo_1/views/basic-information.dart';
import 'package:flutter_demo_1/views/health_management.dart';
import 'package:flutter_demo_1/views/tabs-routing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '患者アプリ',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'Login'),
      initialRoute: '/login',
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => MyHomePage(),
        // '/health-management': (BuildContext context) => HealthManagementPage(),
        // '/basic-information': (BuildContext context) => BasicInformationPage(),
        '/tabs': (BuildContext context) => TabsRoutingPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  signIn(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': password
    };

    User loginRequest = new User();
    loginRequest.email = email;
    loginRequest.password = password;
    loginRequest.role = "USER";

    var jsonResponse = null;

    var response = await http.post("http://192.168.5.170:8091/api/v1/auth/signin", headers: {'content-type': 'application/json'}, body: json.encode(<String, dynamic> {
      'email': email,
      'password': password,
      'role': 'User'
    }));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonResponse}');
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HealthManagementPage()));
        Navigator.pushNamed(context, '/tabs');
      }
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
        child: Text(
          'Self Report',
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.w500, fontSize: 30),
        ));

    final emailFieldController = new TextEditingController();
    final passwordFieldController = new TextEditingController();

    final emailField = TextFormField(
      obscureText: false,
      style: style,
      controller: emailFieldController,
      cursorColor: Colors.green,
      validator: (value) {
        if (value.isEmpty) {
          return 'メールアドレスを入力してください。';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        alignLabelWithHint: true,
        hintText: "メールアドレス",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      controller: passwordFieldController,
      cursorColor: Colors.green,
      validator: (value) => value.isEmpty ? 'パスワードを入力してください。' : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        hintText: "パスワード",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Center(
            child: Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          title,
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            child: emailField,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            child: passwordField,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green,
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      15.0, 10.0, 15.0, 10.0),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      final snackBar = SnackBar(
                                        content: Text('処理中'),
                                        backgroundColor: Colors.green,
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {
                                            Scaffold.of(context).removeCurrentSnackBar();
                                          }
                                        ),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                      signIn(emailFieldController.text, passwordFieldController.text);
                                    }
                                  },
                                  child: Text("ログイン",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                              child: FlatButton(
                                textColor: Colors.blue,
                                padding: EdgeInsets.zero,
                                child: Text("パスワードを忘れた場合はこちら",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                    fontSize: 16.0
                                  ),
                                ),
                                onPressed: () {

                                },
                              ),

                          ),
                        ],
                      )),
                )));
      }),
    );
  }
}
