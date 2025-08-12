import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/view/screen/parent/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatTeacherPage extends StatelessWidget {
  final String teacherId;
  final String teacherName;

  const ChatTeacherPage({
    Key? key,
    required this.teacherId,
    this.teacherName = "طارق مراد",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ar', timeago.ArMessages());

    return Scaffold(
      appBar: AppBar(
        title: const Text("محادثات أولياء الأمور"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .where("participantIds", arrayContains: teacherId)
            .orderBy("updatedAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "لا توجد محادثات حالياً",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final chats = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chatDoc = chats[index];
              final data = chatDoc.data() as Map<String, dynamic>;

              final participants = data['participants'] is List
                  ? List<Map<String, dynamic>>.from(data['participants'])
                  : [];

              final parent = participants.firstWhere(
                (p) => p['role'] == 'parent',
                orElse: () => {'name': 'ولي الأمر', 'id': 'unknown'},
              );

              final lastMessage = data['lastMessage']?.toString() ?? 'لا توجد رسائل';
              final timestamp = (data['updatedAt'] as Timestamp?)?.toDate();
              final timeAgo = timestamp != null
                  ? timeago.format(timestamp, locale: 'ar')
                  : '';

              return InkWell(
                onTap: () {
                  Get.to(() => ChatScreen(
                        chatId: chatDoc.id,
                        currentUserId: teacherId,
                        currentUserName: teacherName,
                        currentUserRole: "teacher",
                        receiverId: parent['id'],
                        receiverName: parent['name'],
                        receiverRole: 'parent',
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey.shade300,
                        child: const Icon(Icons.person, color: Colors.white),
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parent['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              lastMessage,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        timeAgo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color(0xFFF2F2F2),
    );
  }
}
