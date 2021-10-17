import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/view_model/message_view_model.dart';
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final int receiverIndex;
  const ChatPage({Key? key, required int this.receiverIndex}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
    final user = Provider.of<UserViewModel>(context, listen: false);
    final message = Provider.of<MessageViewModel>(context, listen: false);
    final id = user.user.id;
    //friends = Provider.of<UserViewModel>(context).friends;
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                height: 600,
                child: FutureBuilder(
                  future: Provider.of<MessageViewModel>(context, listen: false)
                      .getPeerMessage(id, user.listUser[receiverIndex].id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text("Have error");
                      }
                      List<Message> list = message.sortByTime();

                      return ListView.builder(
                          padding:
                              EdgeInsets.only(left: 50, right: 50, top: 10),
                          itemCount: list.length,
                          itemBuilder: (context, i) {
                            if (list[i].senderId != id) {
                              return record(
                                  isSender: false,
                                  name: user.listUser
                                      .firstWhere((element) =>
                                          element.id == list[i].senderId)
                                      .name,
                                  content: list[i].content,
                                  time: list[i].time);
                            }
                            return record(
                                isSender: true,
                                name: user.user.name,
                                content: list[i].content,
                                time: list[i].time);
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [buildChatArea()],
                ),
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
                children: [Text(name)],
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: isSender ? Colors.blue : Colors.black12),
                  child: Text(
                    content,
                    style: TextStyle(
                        color: isSender ? Colors.white : Colors.black),
                  )),
              Row(
                children: [Text(time.toLocal().toString())],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
