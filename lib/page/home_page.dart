import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/page/chat_page.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> friends = [];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context);
    //friends = Provider.of<UserViewModel>(context).friends;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40.0, bottom: 20),
              padding: const EdgeInsets.all(40),
              color: Colors.pink.shade100,
              child: Column(
                children: [
                  Text("UserId: ${user.user?.id}"),
                  Text("UserName: ${user.user?.name}"),
                ],
              ),
            ),
            Container(
              child: Text("Danh sách user",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ChatPage()));
                      },
                      child: Container(
                        child: Column(
                          children: [Text(friends[i].name)],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              child: Text("Danh sách nhóm",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Column(
                        children: [Text(friends[i].name)],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
