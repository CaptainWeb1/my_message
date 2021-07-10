
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_message/models/message_model.dart';
import 'package:my_message/models/user_model.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/providers/chat_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/circular_progress_indicator_widget.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/message_container_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';
import 'package:my_message/utils/format_util.dart';

class RoomScreen extends StatefulWidget {

  final dynamic peerUserArgument;

  RoomScreen({Key? key, required this.peerUserArgument}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {

  String _message = "";
  UserModel? _peerUser;
  FocusNode? _focusNode = FocusNode();
  TextEditingController? _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider().reloadFirebase(context: context);
    _peerUser = widget.peerUserArgument;
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
            _peerUser?.userName ?? "pseudo",
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
            child: Image.asset("assets/images/user_images/Jean-Michel.png"),
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<dynamic>>(
            stream: ChatProvider.getRoomMessages(peerId: _peerUser?.userId ?? UniqueKey().toString()),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                    flex: 8,
                    child: CircularProgressIndicatorWidget()
                );
              } else {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot<dynamic>> _docs = snapshot.data!.docs;
                  List<MessageModel?> _messageModels = MessageModel.decodeMessages(_docs);
                    return Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
                        child: (_messageModels.length > 0)
                          ? ListView.builder(
                            itemCount: _messageModels.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  crossAxisAlignment: (_messageModels[index]?.userId == AuthenticationProvider().currentUser?.uid) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                  children: [
                                    if(_messageModels[index]?.textMessage != null)
                                    MessageContainerWidget(
                                      isCurrentUser: (_messageModels[index]?.userId == AuthenticationProvider().currentUser?.uid) ? true : false,
                                      text: _messageModels[index]?.textMessage ?? "",
                                    ),
                                    if(_messageModels[index]?.timeMessage != null)
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
                        ) : Center(
                          child: Text(
                            Strings.noMessages,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                } else {
                  return Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                          snapshot.error as String,
                          textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              }
            }
          ),
          Container(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Expanded(
                    child: Container(
                      height: 400,
                      alignment: Alignment.center,
                      child: TextFieldWidget(
                          textFieldParameters: TextFieldParameters(
                            hintText: Strings.tapMessage,
                            iconWidget: IconWidget(icon: Icons.camera_alt_rounded),
                            textStyle: MyTextStyles.formPlaceHolder.copyWith(
                                fontSize: 17
                            ),
                          ),
                        valueChanged: (value) {
                          _message = value;
                        },
                        textEditingController: _textEditingController,
                        focusNode: _focusNode,
                  ),
                    ),
                  flex: 18,
                ),
                Spacer(),
                Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _textEditingController?.clear();
                          });
                          ChatProvider.setMessage(
                              peerId: _peerUser?.userId ?? UniqueKey().toString(),
                              message: _message);
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


