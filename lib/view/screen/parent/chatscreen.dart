import 'dart:convert';
import 'package:e_commerce/linkapi.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  final String chatId, currentUserId, currentUserName, currentUserRole;
  final String receiverId, receiverName;
  final String? receiverImageUrl;
  final String receiverRole;

  const ChatScreen({
    Key? key,
    required this.chatId,
    required this.currentUserId,
    required this.currentUserName,
    required this.currentUserRole,
    required this.receiverId,
    required this.receiverName,
    this.receiverImageUrl, required this.receiverRole,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;
  final ScrollController _scrollController = ScrollController();
  bool isReceiverTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
     timeago.setLocaleMessages('ar', CustomArMessages());
    _listenTyping();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _listenTyping() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .snapshots()
        .listen((snap) {
      final data = snap.data();
      if (data != null) {
       final typing = data['${widget.receiverId}_${widget.receiverRole}_typing'] == true;
        if (typing != isReceiverTyping) {
          setState(() {
            isReceiverTyping = typing;
          });
        }
      }
    });
  }

  Future<void> _setTyping(bool typing) async {
    try {
      await FirebaseFirestore.instance
    .collection('chats')
    .doc(widget.chatId)
    .update({'${widget.currentUserId}_${widget.currentUserRole}_typing': typing});
    } catch (e) {
      // handle errors if needed
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    await _setTyping(false);

    final msgRef = FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.chatId)
        .collection("messages");

    final newMsg = msgRef.doc();
    await newMsg.set({
      "text": text,
      "senderId": widget.currentUserId,
      "senderName": widget.currentUserName,
      "senderRole": widget.currentUserRole,
      "createdAt": FieldValue.serverTimestamp(),
      "messageId": newMsg.id,
    });

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.chatId)
        .update({
      "lastMessage": text,
      "updatedAt": FieldValue.serverTimestamp(),
    });

    // Scroll to bottom smoothly after a short delay to ensure message is loaded
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    String url = widget.currentUserRole == "parent"
        ? "${AppLink.server}/send-fcm-to-teacher"
        : "${AppLink.server}/send-fcm-to-parent";

    await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "message": text,
        widget.currentUserRole == "parent" ? "teacher_id" : "parent_id":
            widget.receiverId
      }),
    );
  }

  Widget _buildMessageBubble({
    required String text,
    required bool isCurrentUser,
    required String timeString,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: isCurrentUser
                ? LinearGradient(
                    colors: [AppColor.color9, AppColor.color9.withOpacity(0.9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)
                : LinearGradient(
                    colors: [Colors.grey[300]!, Colors.grey[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isCurrentUser ? 16 : 4),
              topRight: Radius.circular(isCurrentUser ? 4 : 16),
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment:
                  isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(text,
                    style: TextStyle(
                      fontSize: 15,
                      color: isCurrentUser ? Colors.white : Colors.black87,
                    )),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(timeString,
                        style: TextStyle(
                          fontSize: 11,
                          color: isCurrentUser ? Colors.white70 : Colors.grey[600],
                        )),
                    if (isCurrentUser) const SizedBox(width: 4),
                    if (isCurrentUser)
                      const Icon(Icons.check, size: 14, color: Colors.white70),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messagesRef = FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.chatId)
        .collection("messages")
        .orderBy("createdAt", descending: true);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColor.color9,
        titleSpacing: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 20,
                backgroundImage: widget.receiverImageUrl != null
                    ? NetworkImage(widget.receiverImageUrl!)
                    : null,
                child: widget.receiverImageUrl == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.receiverName,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                if (isReceiverTyping)
                  const Text('يكتب...', style: TextStyle(fontSize: 13, color: Colors.white70)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesRef.snapshots(),
              builder: (ctx, snap) {
                if (!snap.hasData) {
                  // Show empty container instead of loader to avoid flicker on refresh
                  return const SizedBox.shrink();
                }
                if (snap.data!.docs.isEmpty) {
                  return const Center(child: Text("لا توجد رسائل بعد"));
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (c, i) {
                    final msg = snap.data!.docs[i];
                    final text = msg['text'] ?? '';
                    final senderId = msg['senderId'] ?? '';
                    final timestamp = (msg['createdAt'] as Timestamp?)?.toDate();
                    final timeString = timestamp != null
                        ? timeago.format(timestamp, locale: 'ar')
                        : '';
                    final senderRole = msg['senderRole'] ?? '';
final isMe = senderId == widget.currentUserId &&
             senderRole == widget.currentUserRole;


                    return GestureDetector(
                      onLongPress: () {
                        if (isMe) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("حذف الرسالة"),
                              content: const Text("هل أنت متأكد من حذف هذه الرسالة؟"),
                              actions: [
                                TextButton(
                                  child: const Text("إلغاء"),
                                  onPressed: () => Navigator.of(ctx).pop(),
                                ),
                                TextButton(
                                  child: const Text("حذف",
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("chats")
                                        .doc(widget.chatId)
                                        .collection("messages")
                                        .doc(msg.id)
                                        .delete();
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: _buildMessageBubble(
                        text: text,
                        isCurrentUser: isMe,
                        timeString: timeString,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "اكتب رسالة...",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      minLines: 1,
                      maxLines: 5,
                      onChanged: (val) => _setTyping(val.isNotEmpty),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.color9,
                          AppColor.color9.withOpacity(0.85)
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color:
                                const Color.fromARGB(0, 167, 165, 165).withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 0)),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class CustomArMessages extends timeago.ArMessages {
  @override
  String lessThanOneMinute(int seconds) {
    return 'قبل دقيقة';  // هنا بدّل الثواني بعبارة ثابتة
  }
}