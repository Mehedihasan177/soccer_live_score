// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/setting_controller.dart';
import '/consts/consts.dart';
import '/controllers/auth_controller.dart';
import '/services/database_service.dart';

class ChatScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ChatScreen(this.arguments);
  final arguments;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats'.tr,
          style: AppStyles.heading
              .copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
          //style: AppStyles.heading2.copyWith(color: theme.text.value),
        ),
        centerTitle: true,
      ),
      body: Chat(widget.arguments),
    );
  }
}

class Chat extends StatefulWidget {
  const Chat(this.arguments, {Key? key}) : super(key: key);
  final arguments;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  SettingController settingController = Get.find();
  AuthController authController = Get.find();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  Stream<QuerySnapshot>? _chats;
  TextEditingController messageEditingController = TextEditingController();

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      // setState(() {
      //   _limit += _limitIncrement;
      // });
    }
  }

  _sendMessage() {
    var user = authController.user.value;
    if (messageEditingController.text.isNotEmpty) {
      listScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      Map<String, dynamic> data = {
        "message": messageEditingController.text,
        "sender": jsonEncode(user),
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.arguments['id'].toString(), data);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {}
  }

  @override
  void initState() {
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    super.initState();

    initChat();
  }

  @override
  void dispose() {
    super.dispose();

    disposeChat();
  }

  initChat() async {
    var data = {
      'matchId': widget.arguments['id'],
      'users': 1,
    };
    DatabaseService().getRoomInfo(widget.arguments['id']).then((value) {
      try {
        data['users'] = value.docs[0]['users'] + 1;
      } catch (e) {
        //----//
      }

      DatabaseService().createRoom(data);
    }).onError((error, stackTrace) {
      DatabaseService().createRoom(data);
    });

    settingController.watchNow.value = data['users'];
  }

  disposeChat() async {
    var data = {
      'matchId': widget.arguments['id'],
      'users': 0,
    };
    DatabaseService().getRoomInfo(widget.arguments['id']).then((value) {
      try {
        data['users'] = value.docs[0]['users'] - 1;
      } catch (e) {
        //----//
      }

      DatabaseService().createRoom(data);
    }).onError((error, stackTrace) {
      DatabaseService().createRoom(data);
    });

    settingController.watchNow.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 80),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('rooms')
                  .doc(widget.arguments['id'].toString())
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return snapshot.hasData
                    ? (snapshot.data?.docs.length ?? 0) > 0
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: listScrollController,
                            itemCount: snapshot.data?.docs.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              if (snapshot.hasData) {
                                DocumentSnapshot? document =
                                    snapshot.data?.docs[index];
                                var sender =
                                    jsonDecode(document?.get('sender'));
                                return MessageTile(
                                  message: document?.get('message'),
                                  sender: sender,
                                  sentByMe: false,
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor),
                                  ),
                                );
                              }
                            })
                        : Center(
                            child: Text(
                                'No Chats available for this chatroom, Send Message Now!'
                                    .tr),
                          )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor),
                        ),
                      );
              },
            ),
          ),
          SizedBox(
            height: 200,
          ),
          // Container(),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 12,
                    color: Colors.black26,
                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                color: AppColors.blue1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          onSubmitted: (v) {
                            _sendMessage();
                          },
                          readOnly: !authController.isLogined.value,
                          controller: messageEditingController,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: AppSizes.size14,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                            hintText: "Send a message ...".tr,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: AppSizes.size14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: AppSizes.newSize(4),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class MessageTile extends StatelessWidget {
  final String message;
  final sender;
  final bool sentByMe;
  List<Color> colors = [
    Colors.red.shade700,
    Colors.yellow.shade600,
    Colors.purple.shade600,
    Colors.blue.shade600,
    Colors.pink.shade600
  ];

  MessageTile(
      {Key? key, required this.message, required this.sender, required this.sentByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: (colors.toList()..shuffle()).first.withOpacity(0.5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: [
            WidgetSpan(
              child: sender['image'] != null
                  ? Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                            sender['image'],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(
                            sender['color'] ?? AppColors.primaryColor.value),
                      ),
                      child: Text(
                        sender['name'].toUpperCase()[0],
                        style: TextStyle(
                          fontSize: AppSizes.size13,
                          color: AppColors.text2,
                        ),
                      ),
                    ),
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Text(
                sender['name'].toUpperCase() + ' : ',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  //letterSpacing: -0.5,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: 5)),
            WidgetSpan(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  //letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
