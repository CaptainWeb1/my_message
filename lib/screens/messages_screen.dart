import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_message/models/room_model.dart';
import 'package:my_message/models/user_model.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/providers/chat_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/circular_progress_indicator_widget.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';
import 'package:my_message/utils/format_utils.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  bool _isLoading = true;
  List<RoomModel> _roomModels = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigationUtils.showMyDialog(
            context: context,
            bodyText: Strings.alertConfirmSignOut,
            onClick: () => AuthenticationProvider().signOut(context: context)
        );
        return false;
      },
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ChatProvider.getRoomsLastMessage(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              _setLoading(isLoading: true);
            }
            if(snapshot.hasData) {
              _setLoading(isLoading: false);
              List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs = snapshot.data!.docs;
              _roomModels = RoomModel.decodeRooms(_docs);
              List<String> _roomIds = [];
              for(var room in _roomModels) {
                _roomIds.add(room.userIds.firstWhere((element) => element != ChatProvider.currentUser?.uid));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Spacer(flex: 2,),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.titleApp,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          IconButton(
                              onPressed: () => AuthenticationProvider().signOut(context: context),
                              icon: IconWidget(
                                  icon: Icons.power_settings_new_outlined,
                                  size: 25
                              )
                          )
                        ],
                      ),
                    ),
                    Spacer(flex: 1,),
                    Expanded(
                      flex: 15,
                      child: ListRoomsBodyWidget(
                        rooms: _roomModels,
                        roomIds: _roomIds,
                        setLoading: (isLoading) {
                          _setLoading(isLoading: isLoading);
                        },
                      )
                    )
                  ],
                ),
              );
            } else if(snapshot.hasError) {
              _setLoading(isLoading: false);
              return Center(
                child: Text(
                  Strings.errorGetRoomsMessages,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              if(_isLoading) {
                return Center(child: CircularProgressIndicatorWidget(),);
              } else {
                return Container();
              }
            }

          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(PAGE_SEARCH),
          child: Icon(
            Icons.create
          ),
        ),
      ),
    );
  }

  void _setLoading({required bool isLoading}) {
    if(!mounted) {
      setState(() {
        _isLoading = isLoading;
      });
    }
  }

}

class ListRoomsBodyWidget extends StatefulWidget {

  final List<RoomModel> rooms;
  final List<String> roomIds;
  final ValueChanged<bool> setLoading;

  const ListRoomsBodyWidget({
    Key? key,
    required this.rooms,
    required this.roomIds,
    required this.setLoading,
  }) : super(key: key);

  @override
  _ListRoomsBodyWidgetState createState() => _ListRoomsBodyWidgetState();
}

class _ListRoomsBodyWidgetState extends State<ListRoomsBodyWidget> {

  List<RoomModel> _rooms = [];
  List<String> _roomIds = [];

  void _createRoomLists() {
    _rooms = widget.rooms;
    _roomIds = widget.roomIds;
  }

  @override
  void initState() {
    super.initState();
    _createRoomLists();
  }

  @override
  void didUpdateWidget(covariant ListRoomsBodyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _createRoomLists();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFieldWidget(
            textFieldParameters: SearchTextFieldParameters(hintText: Strings.filter),
            valueChanged: (value) {
              setState(() {
                _rooms = widget.rooms;
                _rooms = _rooms.where((element) => (element.peerUser?.userName.startsWith(value)) ?? false).toList();
              });
            },
          ),
        ),
        Expanded(
          flex: 14,
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: ChatProvider.getUsersFromId(userIds: _roomIds),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                widget.setLoading(true);
              }
              if(snapshot.hasData) {
                widget.setLoading(false);
                List<QueryDocumentSnapshot<Map<String, dynamic>>> _userDocs = snapshot.data!.docs;
                List<UserModel?> _users = UserModel.decodeUsers(_userDocs);
                for(var user in _users) {
                  _rooms.forEach((element) {
                    if(element.userIds.contains(user?.userId)) {
                      element.peerUser = user;
                    }
                  });
                }
                if(_rooms.length > 0) {
                  return ListView.builder(
                    itemCount: _rooms.length,
                    itemBuilder: (context, index) {
                      UserModel? _peerUserModel = _rooms[index].peerUser;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: ListTile(
                          onTap: () async {
                            bool _isUserStillConnected = await AuthenticationProvider().reloadFirebase(context: context);
                            if(_isUserStillConnected) {
                              Navigator.of(context).pushNamed(
                                  PAGE_ROOM,
                                  arguments: _rooms[index]
                              );
                            }
                          } ,
                          leading: Image.asset(
                              _peerUserModel?.imagePath ?? "assets/images/user_images/unknown-image.jpeg"
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _peerUserModel?.userName ?? "utilisateur",
                                style: MyTextStyles.bodyLink,
                              ),
                              Text(
                                _rooms[index].lastMessage ?? "message",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 16
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          trailing: Text(
                            _rooms[index].lastDateMessage?.parseDateToString() ?? "",
                            style: MyTextStyles.dateMessagesScreen,
                          ),
                        ),
                      );
                    },
                  );

                } else {
                  return Center(
                    child: Text(
                      Strings.noRoomsYet,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                widget.setLoading(false);
                return Center(
                  child: Text(
                    Strings.errorGetRoomsMessages,
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Container();
              }
            }
          ),
        )
      ],
    );
  }
}

