import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/view_model/group_view_model.dart';
import 'package:chat_app_flutter/view_model/message_view_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    //
    Provider.of<MessageViewModel>(context, listen: false)
        .getGroupMessage(widget.groupId);
  }

  Widget buildChatArea() {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text(messages[i].content)],
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [buildChatArea()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
