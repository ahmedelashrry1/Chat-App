// ignore_for_file: prefer_const_constructors

import 'package:chat_app/model/messages.dart';
import 'package:chat_app/widgets/MessageBuble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatDetails extends StatefulWidget {
  final String userName;
  final String userIcon;

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  ChatDetails({super.key, required this.userName, required this.userIcon});

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final List<Messages> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage(String message) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? email = currentUser?.email;

  if (message.isNotEmpty && email != null) {
    await widget.messages.add({
      'messages': message,
      'email': email, // تأكد من تخزين البريد الإلكتروني
      'timestamp': FieldValue.serverTimestamp(),
    });
    _messageController.clear();
  } else {
    print('Message or email is empty');
  }
}


  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.messages.orderBy('timestamp').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          _messages.clear();
          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            _messages.add(Messages.fromJson(data));
          }
          // هذا السطر هو الذي يقوم بالتحريك لأسفل عند تلقي الرسائل الجديدة
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff004170),
            elevation: 5,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.userIcon),
                ),
                SizedBox(width: 10),
                Text(
                  widget.userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.video_call, color: Colors.white),
                  onPressed: () {
                    // إضافة وظيفة مكالمة الفيديو
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call, color: Colors.white),
                  onPressed: () {
                    // إضافة وظيفة الاتصال
                  },
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
          Expanded(
  child: ListView.builder(
    controller: _scrollController,
    itemCount: _messages.length,
    itemBuilder: (context, index) {
      bool isCurrentUser = _messages[index].id == FirebaseAuth.instance.currentUser?.email;
      return MessageBubble(
        message: _messages[index].message,
        isCurrentUser: isCurrentUser, // تمرير الحالة
      );
    },
  ),
),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          print('Send button tapped'); // مراقبة النقر
                          sendMessage(_messageController.text); // استدعاء الدالة لإرسال الرسالة
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff004170),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.4),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}