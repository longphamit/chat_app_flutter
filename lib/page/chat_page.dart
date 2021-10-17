// import 'package:chat_app_flutter/model/message_model.dart';
// import 'package:chat_app_flutter/model/user_model.dart';
// import 'package:chat_app_flutter/view_model/ChatViewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';

// class ChatPage extends StatefulWidget {
//   final User friend;
//   ChatPage(this.friend);
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController textEditingController = TextEditingController();
//   Widget buildSingleMessage(Message message) {
//     return Container(
//       alignment: message.sender == widget.friend.id
//           ? Alignment.centerLeft
//           : Alignment.centerRight,
//       padding: EdgeInsets.all(10.0),
//       margin: EdgeInsets.all(10.0),
//       child: Text(message.content),
//     );
//   }

//   Widget buildChatList() {
//     return ScopedModelDescendant<ChatModel>(
//       builder: (context, child, model) {
//         List<Message> messages = model.getMessagesForChatID(widget.friend.id);
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.75,
//           child: ListView.builder(
//             itemCount: messages.length,
//             itemBuilder: (BuildContext context, int index) {
//               return buildSingleMessage(messages[index]);
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget buildChatArea() {
//     return ScopedModelDescendant<ChatModel>(
//       builder: (context, child, model) {
//         return Container(
//           child: Row(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: TextField(
//                   controller: textEditingController,
//                 ),
//               ),
//               SizedBox(width: 10.0),
//               FloatingActionButton(
//                 onPressed: () {
//                   model.sendMessage(
//                       textEditingController.text, widget.friend.id);
//                   textEditingController.text = '';
//                 },
//                 elevation: 0,
//                 child: Icon(Icons.send),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.friend.name),
//       ),
//       body: ListView(
//         children: <Widget>[
//           buildChatList(),
//           buildChatArea(),
//         ],
//       ),
//     );
//   }
// }
import 'package:chat_app_flutter/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login Successfully"),
            Text("UserId: ${user.user?.id}"),
            Text("UserName: ${user.user?.name}"),
            Text("UserImg: ${user.user?.img}")
          ],
        ),
      ),
    );
  }
}
