
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_message/models/message_model.dart';
import 'package:my_message/models/room_model.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/providers/chat_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/circular_progress_indicator_widget.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/message_container_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';
import 'package:my_message/utils/format_utils.dart';

class RoomScreen extends StatefulWidget {

  final dynamic roomArguments;

  const RoomScreen({Key? key, required this.roomArguments}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {

  String _message = "";
  RoomModel? _roomModel;
  TextEditingController? _textEditingController = TextEditingController();
  String _roomId = "";

  @override
  void initState() {
    super.initState();
    _roomModel = widget.roomArguments;
    _roomId = _roomModel?.roomId ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _roomModel?.peerUser?.userName ?? "pseudo",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Image.asset(
                _roomModel?.peerUser?.imagePath ?? "assets/images/user_images/unknown-image.jpeg"
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: StreamBuilder<QuerySnapshot<dynamic>>(
              stream: ChatProvider.getRoomMessages(roomId: _roomId),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicatorWidget();
                } else {
                  if(snapshot.hasData) {
                    List<QueryDocumentSnapshot<dynamic>> _docs = snapshot.data!.docs;
                    List<MessageModel?> _messageModels = MessageModel.decodeMessages(_docs);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
                      child: (_messageModels.length > 0)
                        ? ListView.builder(
                          itemCount: _messageModels.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Column(
                                crossAxisAlignment: (_messageModels[index]?.userId == AuthenticationProvider().currentUser?.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  MessageContainerWidget(
                                    isCurrentUser: (_messageModels[index]?.userId == AuthenticationProvider().currentUser?.uid)
                                        ? true
                                        : false,
                                    text: _messageModels[index]?.textMessage ?? ""
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      _messageModels[index]?.timeMessage.parseDateToString() ?? "",
                                      style: MyTextStyles.dateChatScreen,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        )
                      : Center(
                        child: Text(
                          Strings.noMessage,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if(snapshot.hasError) {
                    return Center(
                      child: Text(
                        Strings.getMessagesError,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                          Strings.noMessage,
                          textAlign: TextAlign.center,
                      ),
                    );
                  }
                }
              }
            ),
          ),
          Container(
            height: 80,
            child: Row(
              children: [
                Spacer(),
                Expanded(
                  child: TextFieldWidget(
                      textFieldParameters: TextFieldParameters(
                        hintText: Strings.tapMessage,
                        iconWidget: IconWidget(icon: Icons.camera_alt_rounded),
                        textStyle: MyTextStyles.formPlaceHolder.copyWith(
                            fontSize: 17
                        ),
                      ),
                    textEditingController: _textEditingController,
                    valueChanged: (value) {
                      _message = value;
                    },
                  ),
                  flex: 18,
                ),
                Spacer(),
                Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _roomId = await ChatProvider.setMessage(
                            context,
                            peerId: _roomModel?.peerUser?.userId ?? UniqueKey().toString(),
                            message: _message,
                            roomId: _roomModel?.roomId
                          ) ?? "";
                          setState(() {
                            _textEditingController?.clear();
                            _roomModel?.roomId = _roomId;
                          });
                        },
                        child: Icon(
                            Icons.send_sharp,
                            size: 28,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                        ),
                      ),
                    ),
                    flex: 3,
                ),
                Spacer()
              ],
            ),
          ),
          SizedBox(height: 15,)
        ],
      ),
    );
  }
}


