class Messages {
  final String message;
  final String id; // هذا هو البريد الإلكتروني للمستخدم

  Messages(this.id, {required this.message});

  factory Messages.fromJson(Map<String, dynamic> jsonData) {
    return Messages(
      jsonData['email'] ?? '', // تأكد من استخدام البريد الإلكتروني
      message: jsonData['messages'] ?? '',
    );
  }
}
