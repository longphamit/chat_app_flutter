import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/view_model/group_view_model.dart';
import 'package:chat_app_flutter/view_model/message_view_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatGroupPage extends StatefulWidget {
  final int receiverIndex;
  const ChatGroupPage({Key? key, required int this.receiverIndex})
      : super(key: key);

  @override
  _ChatGroupState createState() => _ChatGroupState();
}

class _ChatGroupState extends State<ChatGroupPage> {
  final TextEditingController textEditingController = TextEditingController();
  late int receiverIndex;
  @override
  void initState() {
    receiverIndex = widget.receiverIndex;
    // TODO: implement initState
    //
  }

  Widget buildChatList() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75, child: Container());
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
    final groups =
        Provider.of<GroupViewModel>(context, listen: false).listGroup;
    final message = Provider.of<MessageViewModel>(context, listen: false);
    //friends = Provider.of<UserViewModel>(context).friends;
    return Container();
  }
}
