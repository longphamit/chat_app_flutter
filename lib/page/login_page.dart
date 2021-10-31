import 'package:chat_app_flutter/page/chat_page.dart';
import 'package:chat_app_flutter/page/home_page.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username;
  late String password;
  late String error;
  @override
  void initState() {
    username = "";
    password = "";
    error = "";
    super.initState();
  }

  void _onLogin(BuildContext context) {
    Provider.of<UserViewModel>(context, listen: false)
        .login(username, password)
        .then((value) {
      if (value == 0) {
        setState(() {
          error = "Not found user !!!";
        });
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Username: "),
            TextField(
              onChanged: (v) {
                setState(() {
                  username = v;
                  error = "";
                });
              },
            ),
            const Text("Password: "),
            TextField(
              onChanged: (v) {
                setState(() {
                  password = v;
                  error = "";
                });
              },
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  _onLogin(context);
                },
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
