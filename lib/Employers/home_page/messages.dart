import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ComposeMessageScreen extends StatefulWidget {
  String jobApplierId;

  ComposeMessageScreen({
    Key? key,
    required this.jobApplierId,
  }) : super(key: key);
  @override
  _ComposeMessageScreenState createState() => _ComposeMessageScreenState();
}

class _ComposeMessageScreenState extends State<ComposeMessageScreen> {
  List<Message> _sentMessages = [];

  String _statusMessage = '';
  var companyData;
  // String messageId = '';
  TextEditingController _messageController = TextEditingController();
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  bool sendMessageToJobSeeker(String message) {
    return message.isNotEmpty; // Simulating success if the message is not empty
  }

  Future getSenderDataFromFirestore() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('employer')
        .doc(getCurrentUserUid())
        .collection('company profile')
        .doc('profile')
        .get();

    if (snapshot.exists) {
      setState(() {
        companyData = snapshot.data();
      });
    }
  }

  String createMessageId() {
    var uuid = Uuid();

    String messageId = uuid.v4();
    return messageId;
  }

  Future saveMessage(String id, Message message) async {
    final jsonData = message.toJson();
    final messageDocumentReference = FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(id)
        .collection('messages')
        .doc(createMessageId());
    await messageDocumentReference.set(jsonData);
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Message'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(widget.jobApplierId)
            .collection('messages')
            .where('senderId', isEqualTo: getCurrentUserUid())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //  final length = snapshot.data!.docs.where((element) {});
          List<DocumentSnapshot> sentMessages = [];
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            sentMessages = querySnapshot.docs.toList();
            // sentMessages = querySnapshot.docs.where((doc) {
            //   String id = doc.id;
            //   return id == getCurrentUserUid();
            // }).toList();
          }
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return Text('OOPS there is no posted jobs');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return new Text('Loading...');
          } else {
            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      String messageId = createMessageId();
                      String message = _messageController.text;
                      getSenderDataFromFirestore();
                      final messageObject = Message(
                          id: messageId,
                          senderId: getCurrentUserUid(),
                          recipientId: widget.jobApplierId,
                          content: message,
                          timestamp: DateTime.now(),
                          isRead: false,
                          company: companyData);
                      saveMessage(widget.jobApplierId, messageObject);

                      _messageController.clear();
                      // _sentMessages.add(messageObject);
                    },
                    child: Text('Send'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sentMessages.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot message = sentMessages[index];
                        String date = formatTimestamp(message['timestamp']);
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          tileColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          title: Text(
                            message['content'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '${date}',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          }
          ;
        },
      ),
    );
  }
}
