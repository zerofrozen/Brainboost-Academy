import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentPage extends StatefulWidget {
  final User? user;

  CommentPage({required this.user});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();
  final _replyController = TextEditingController();
  String username = '';
  String imageUrl = '';

  Future<void> getUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .get();
    setState(() {
      imageUrl = userDoc.get('imageUrl');
      username = userDoc.get('username') ?? '';
    });
  }

  void _postComment() async {
    if (_commentController.text.trim().isNotEmpty) {
      await getUserData();
      FirebaseFirestore.instance.collection('comments').add({
        'username': username,
        'comment': _commentController.text,
        'imageUrl': imageUrl,
        'timestamp': Timestamp.now(),
        'replies': [],
      });
      _commentController.clear();
    }
  }

  void _postReply(String commentId) async {
    if (_replyController.text.trim().isNotEmpty) {
      await getUserData();
      FirebaseFirestore.instance.collection('comments').doc(commentId).update({
        'replies': FieldValue.arrayUnion([
          {
            'username': username,
            'comment': _replyController.text,
            'imageUrl': imageUrl,
            'timestamp': Timestamp.now(),
          },
        ]),
      });
      _replyController.clear();
    }
  }

  String formatTimeAgo(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    return timeago.format(dateTime, locale: 'en_short');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Tuliskan Pertanyaan disini ya...',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _postComment,
              child: Text('Submit Pertanyaan'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot commentDoc = snapshot.data!.docs[index];
                      final data = commentDoc.data() as Map<String, dynamic>?;
                      final username = data?.containsKey('username') == true
                          ? data!['username'] ?? ''
                          : '';
                      final comment = data?.containsKey('comment') == true
                          ? data!['comment'] ?? ''
                          : '';
                      final replies =
                          (data?['replies'] as List<dynamic>?) ?? [];

                      return Card(
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: ExpansionTile(
                          title: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data?['imageUrl'] ?? ''),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(username,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  formatTimeAgo(
                                          data?['timestamp'] as Timestamp) +
                                      ' yang lalu',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(comment),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.comment),
                              SizedBox(width: 4.0),
                              Text('${replies.length.toString()}'),
                              SizedBox(width: 4.0),
                              Text(
                                'Lihat Jawaban',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: replies.length,
                              itemBuilder: (context, replyIndex) {
                                final reply = replies[replyIndex];
                                final replyUsername = reply['username'] ?? '';
                                final replyComment = reply['comment'] ?? '';
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(reply['imageUrl'] ?? ''),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(replyUsername),
                                      Text(
                                        formatTimeAgo(
                                            reply['timestamp'] as Timestamp),
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(replyComment),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _replyController,
                                decoration: InputDecoration(
                                  labelText: 'Tulis Komentar...',
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _postReply(commentDoc.id),
                              child: Text('Submit Komentar'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('An error occurred'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
