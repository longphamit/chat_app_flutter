import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/page/chat_group_page.dart';
import 'package:chat_app_flutter/page/chat_page.dart';
import 'package:chat_app_flutter/view_model/group_view_model.dart';
import 'package:chat_app_flutter/view_model/socket_view_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<GroupViewModel>(context, listen: false).getAll();
    Provider.of<UserViewModel>(context, listen: false).getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context);
    final groups = Provider.of<GroupViewModel>(context).listGroup;
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
                  Text("Hello: ${user.user.name}"),
                ],
              ),
            ),
            Container(
              child: Text("Danh sách user",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 10),
                    itemCount: user.listUser.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatPage(
                                          receiverIndex: i,
                                        )));
                          },
                          child: Container(
                            color: Colors.blueGrey,
                            child: Column(children: [
                              Text(
                                user.listUser[i].name,
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                          ),
                        ),
                      );
                    })),
            Container(
              child: Text("Danh sách nhóm",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChatGroupPage(
                                      groupId: groups[i].id,
                                      groupName: groups[i].name,
                                    )));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 200,
                              margin: EdgeInsets.all(20),
                              color: Colors.pink.shade100,
                              child: Center(
                                child: Text(
                                  groups[i].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
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
