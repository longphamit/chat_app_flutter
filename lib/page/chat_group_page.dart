import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/service/socket_service.dart';
import 'package:chat_app_flutter/view_model/group_view_model.dart';
import 'package:chat_app_flutter/view_model/message_view_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatGroupPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  const ChatGroupPage(
      {Key? key, required String this.groupId, required String this.groupName})
      : super(key: key);

  @override
  _ChatGroupState createState() => _ChatGroupState();
}

class _ChatGroupState extends State<ChatGroupPage> {
  final TextEditingController textEditingController = TextEditingController();
  SocketService socketService = new SocketService();
  late IO.Socket socket;
  @override
  void initState() {
    // TODO: implement initState
    //
    Provider.of<MessageViewModel>(context, listen: false)
        .getGroupMessage(widget.groupId);
    connectSocket();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socketService.disconnect();
  }

  void connectSocket() {
    socket = socketService.connectGroup(
        "https://server-chat-demo.herokuapp.com/", widget.groupId, context);
  }

  Widget buildChatArea(User user) {
    return Container(
      child: Row(
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
              var message = {
                "receiverId": widget.groupId,
                "senderName": user.name,
                "senderId": user.id,
                "content": textEditingController.text
              };
              socket.emit('GROUP_MESSAGE', message);
              Provider.of<MessageViewModel>(context, listen: false)
                  .addMessageToMessageOfGroup(
                      Message.jsonFromInternal(message));
              textEditingController.text = '';
            },
            elevation: 0,
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<MessageViewModel>(context).messagOfGroup;
    final user = Provider.of<UserViewModel>(context).user;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  widget.groupName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: messages[i].senderId == user.id
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                    messages[i].senderName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(messages[i].content),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [buildChatArea(user)],
            ),
          ],
        ),
      ),
    );
  }
}
