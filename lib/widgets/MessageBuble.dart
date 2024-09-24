import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final bool isRead; // حالة قراءة الرسالة

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    this.isRead = false, // القيمة الافتراضية أن الرسالة لم تقرأ بعد
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isCurrentUser ? Color(0xff004170) : Color(0xff78B7D0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCurrentUser ? Colors.blue : Colors.grey, // إضافة حدود للرسالة
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // إضافة أيقونة الرسالة غير المقروءة
            isRead
                ? const Icon(
                    Icons.done_all,
                    color: Colors.greenAccent,
                    size: 18,
                  )
                : const Icon(
                    Icons.done,
                    color: Colors.white54,
                    size: 18,
                  ),
          ],
        ),
      ),
    );
  }
}
