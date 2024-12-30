import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(
      {super.key, required this.chatRoomName, required this.chatRoomId});

  final String chatRoomName;
  final String chatRoomId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();
  var db = FirebaseFirestore.instance;

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) return;
    Map<String, dynamic> messageToSend = {
      "text": messageController.text,
      "sender_name": Provider.of<UserProvider>(context, listen: false).name,
      "sender_id": Provider.of<UserProvider>(context, listen: false).userId,
      "chatroom_id": widget.chatRoomId,
      "timestamp": FieldValue.serverTimestamp()
    };
    messageController.text = "";
    try {
      await db.collection("messages").add(messageToSend);
    } catch (e) {
      print(e);
    }
  }

  Widget singleChatItem(
      {required String senderName,
      required String text,
      required String senderId}) {
    return Column(
      crossAxisAlignment:
          senderId == Provider.of<UserProvider>(context, listen: false).userId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            senderName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: senderId ==
                    Provider.of<UserProvider>(context, listen: false).userId
                ? Colors.grey[300]
                : Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: senderId ==
                      Provider.of<UserProvider>(context, listen: false).userId
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatRoomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db
                  .collection("messages")
                  .where("chatroom_id", isEqualTo: widget.chatRoomId)
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("Some error");
                }

                var allMessages = snapshot.data?.docs ?? [];
                if(allMessages.isEmpty){
                  return const Center(
                    child: Text("No messages here"),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: allMessages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: singleChatItem(
                        senderName: allMessages[index]["sender_name"],
                        text: allMessages[index]["text"],
                        senderId: allMessages[index]["sender_id"],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "write message here",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
