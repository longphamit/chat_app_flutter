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

  List<PeerDetail> convertToPeerDetail(
      String id, List<Peer> peerList, List<User> userList) {
    List<PeerDetail> list = [];
    peerList.forEach((element) {
      List<String> userIdList = element.users!;
      bool isHaveChannel = false;
      String receiverName = "";
      User peerWithUser = User();
      int index = -1;
      userIdList.forEach((userId) {
        index++;
        if (userId == id) {
          isHaveChannel = true;
          receiverName = element.names![index];
        } else {
          User userTemp = userList.firstWhere((user) => user.id == userId);
          peerWithUser = userTemp;
        }
      });
      if (isHaveChannel) {
        PeerDetail detail = PeerDetail(
            peerId: element.id,
            receiverName: receiverName,
            peerWithUser: peerWithUser);
        list.add(detail);
      } else {
        peerWithUser = User();
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false);
    final groups = Provider.of<GroupViewModel>(context, listen: false);
    final peers = Provider.of<PeerViewModel>(context, listen: false);
    return Scaffold(
      body: Spinner.spinnerWithFuture(initData(), (data) {
        final List<PeerDetail> peerDetails =
            convertToPeerDetail(user.user.id, peers.listPeer, user.listUser);
        return Container(
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
                        itemCount: peerDetails.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatPage(
                                        peerId: peerDetails[i].peerId,
                                        nameReceiver:
                                            peerDetails[i].receiverName,
                                      ),
                                    ));
                              },
                              child: Container(
                                color: Colors.blueGrey,
                                child: Column(children: [
                                  Text(
                                    peerDetails[i].peerWithUser.name,
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
            ));
      }, customWidget: _customWidget()),
    );
  }

  Widget _customWidget() {
    return Container(
        alignment: Alignment.center, child: CircularProgressIndicator());
  }
}

class PeerDetail {
  String peerId;
  String receiverName;
  User peerWithUser;
  PeerDetail(
      {required this.peerId,
      required this.receiverName,
      required this.peerWithUser});
}
