import 'dart:convert';

import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/service/socket_service.dart';
import 'package:chat_app_flutter/view_model/message_view_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String peerId;
  final String nameReceiver;
  const ChatPage(
      {Key? key,
      required String this.peerId,
      required String this.nameReceiver})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final SocketService _socketService = SocketService();
  late String peerId;
  late String nameReceiver;
  bool isLoad = false;
  @override
  void initState() {
    peerId = widget.peerId;
    nameReceiver = widget.nameReceiver;
    _initData();
    _connectSocket();
    //initData();
    super.initState();
    // TODO: implement initState
    //
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _socketService.disconnect();
    super.dispose();
  }

  void _connectSocket() {
    _socketService.connectPeer(peerId, this.context);
  }

  Future<void> _initData() async {
    setState(() {
      isLoad = true;
    });
    await Provider.of<MessageViewModel>(this.context, listen: false)
        .getPeerMessage(peerId);
    setState(() {
      isLoad = false;
    });
  }

  Widget buildChatList() {
    return Container(
        height: MediaQuery.of(this.context).size.height * 0.75,
        child: Container());
  }

  Widget buildChatArea(
      String senderId, String senderName, BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: textEditingController,
          ),
        ),
        SizedBox(width: 10.0),
        FloatingActionButton(
          onPressed: () {
            var content = textEditingController.text;
            if (content.isNotEmpty) {
              var message = {
                "receiverId": widget.peerId,
                "senderName": senderName,
                "senderId": senderId,
                "content": textEditingController.text
              };
              _socketService.socket.emit('PEER_MESSAGE', jsonEncode(message));
              Provider.of<MessageViewModel>(context, listen: false)
                  .addPeerMessage(Message.jsonFromInternal(message));
              textEditingController.text = '';
            }
          },
          elevation: 0,
          child: Icon(Icons.send),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context);
    final messages = Provider.of<MessageViewModel>(context);
    final id = user.user.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(nameReceiver),
      ),
      resizeToAvoidBottomInset: false,
      body: isLoad
          ? Center(child: CircularProgressIndicator())
          : Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 50),
                        child: ListView.builder(
                            padding:
                                EdgeInsets.only(left: 50, right: 50, top: 10),
                            itemCount: messages.peerList.length,
                            itemBuilder: (context, i) {
                              return record(
                                  isSender: messages.peerList[i].senderId != id
                                      ? false
                                      : true,
                                  name: messages.peerList[i].senderName,
                                  content: messages.peerList[i].content,
                                  time: messages.peerList[i].time);
                            })),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [buildChatArea(id, user.user.name, context)],
                  ),
                  Text("${user.user.name}"),
                ],
              )),
    );
  }

  Widget record(
      {bool isSender = false,
      String name = "",
      String content = "",
      required DateTime time}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black87,
                        decorationThickness: 1.5),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:
                          isSender ? Colors.lightBlueAccent : Colors.black12),
                  child: Text(
                    content,
                    style: TextStyle(
                        color: isSender ? Colors.black : Colors.black),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
