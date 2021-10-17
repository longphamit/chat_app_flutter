import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  List<User> friends = [];
  @override
  void initState() {
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
    final user = Provider.of<UserViewModel>(context);
    //friends = Provider.of<UserViewModel>(context).friends;
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [buildChatArea()],
                ),
              ),
              const Text("Login Successfully"),
              Text("UserId: ${user.user?.id}"),
              Text("UserName: ${user.user?.name}"),
            ],
          )),
    );
  }
}
