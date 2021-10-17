import 'package:chat_app_flutter/page/chat_page.dart';
import 'package:chat_app_flutter/page/home_page.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username;
  late String password;
  @override
  void initState() {
    username = "";
    password = "";
    // TODO: implement initState
    super.initState();
  }

  void _onLogin(BuildContext context) {
    Provider.of<UserViewModel>(context, listen: false)
        .login(username, password)
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Username: "),
            TextField(
              onChanged: (v) {
                setState(() {
                  username = v;
                });
              },
            ),
            Text("Password: "),
            TextField(
              onChanged: (v) {
                setState(() {
                  password = v;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _onLogin(context);
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
