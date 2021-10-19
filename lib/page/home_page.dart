import 'package:chat_app_flutter/model/peer_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/page/chat_group_page.dart';
import 'package:chat_app_flutter/page/chat_page.dart';
import 'package:chat_app_flutter/utils/spinner.dart';
import 'package:chat_app_flutter/view_model/group_view_model.dart';
import 'package:chat_app_flutter/view_model/peer_view_model.dart';
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
    initData();
    // TODO: implement initState
    super.initState();
  }

  Future<void> initData() async {
    await Provider.of<GroupViewModel>(context, listen: false).getAll();
    await Provider.of<PeerViewModel>(context, listen: false).getAll();
    await Provider.of<UserViewModel>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false);
    final groups = Provider.of<GroupViewModel>(context, listen: false);
    final peers = Provider.of<PeerViewModel>(context, listen: false);
    return Scaffold(
      body: Spinner.spinnerWithFuture(
          initData(),
          (data) => Container(
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
                          padding:
                              EdgeInsets.only(left: 50, right: 50, top: 10),
                          itemCount: user.listUser.length,
                          itemBuilder: (context, i) {
                            String currentId = user.listUser[i].id;
                            String peerId = peers.listPeer.firstWhere((peer) {
                              bool joinChannel = false;
                              peer.users?.forEach((id) {
                                if (id == currentId) {
                                  joinChannel = true;
                                }
                              });
                              return joinChannel;
                            }).id;
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ChatPage(peerId: peerId),
                                      ));
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
                        itemCount: groups.listGroup.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ChatGroupPage(
                                            groupId: groups.listGroup[i].id,
                                            groupName: groups.listGroup[i].name,
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
                                        groups.listGroup[i].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
              )),
          customWidget: _customWidget()),
    );
  }

  Widget _customWidget() {
    return Container(
        alignment: Alignment.center, child: CircularProgressIndicator());
  }
}
