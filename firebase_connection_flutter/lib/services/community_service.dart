import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommunityService {
  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child(
    'community_messages',
  );

  Future<void> sendMessage(String message) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || message.trim().isEmpty) return;

    await _messagesRef.push().set({
      'text': message.trim(),
      'senderEmail': user.email ?? 'Anonymous',
      'senderUid': user.uid,
      'timestamp': ServerValue.timestamp,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Stream<List<Map<String, dynamic>>> getMessagesStream() {
    return _messagesRef
        .orderByChild('timestamp')
        .limitToLast(50) // Limit to last 50 messages
        .onValue // Creates a stream that triggers whenever data changes
        .map((DatabaseEvent event) {
          final messages = <Map<String, dynamic>>[];

          if (event.snapshot.value != null) {
            final data = event.snapshot.value as Map<dynamic, dynamic>;
            data.forEach((key, value) {
              final message = Map<String, dynamic>.from(value as Map);
              message['id'] = key;
              messages.add(message);
            });

            // Sort by timestamp (newest first)
            messages.sort((a, b) {
              final aTime = a['timestamp'] ?? a['createdAt'] ?? 0;
              final bTime = b['timestamp'] ?? b['createdAt'] ?? 0;
              return bTime.compareTo(aTime);
            });
          }

          return messages;
        });
  }

  Future<void> deleteMessage(String messageId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Get the message first to check if user owns it
    final messageSnapshot = await _messagesRef.child(messageId).get();
    if (messageSnapshot.exists) {
      final messageData = messageSnapshot.value as Map<dynamic, dynamic>;
      if (messageData['senderUid'] == user.uid) {
        await _messagesRef.child(messageId).remove();
      }
    }
  }
}
