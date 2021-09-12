
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:my_message/models/room_model.dart';
import 'package:my_message/models/user_model.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/providers/chat_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/exception_utils.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/circular_progress_indicator_widget.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Future<QuerySnapshot<Map<String, dynamic>>>? _filteredUsers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FloatingSearchBar(
            hint: Strings.searchContact,
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            queryStyle: TextStyle(
              color: MyColors.hintColor
            ),
            hintStyle: MyTextStyles.formPlaceHolder.copyWith(
              fontSize: 18
            ),
            axisAlignment: 0.0,
            openAxisAlignment: 0.0,
            width: 600,
            debounceDelay: const Duration(milliseconds: 500),
            onQueryChanged: (query) {
             setState(() {
               _filteredUsers = ChatProvider.getUsersFromName(query: query);
             });
            },
            backgroundColor: MyColors.containerColor,
            accentColor: MyColors.hintColor,
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.perm_contact_cal_rounded),
                  onPressed: () {},
                ),
              ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: MyColors.containerColor,
                    child: FutureBuilder<QuerySnapshot<dynamic>>(
                      future: _filteredUsers,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicatorWidget();
                        } else {
                          if(snapshot.hasData) {
                            List<QueryDocumentSnapshot<dynamic>> _docs = snapshot.data!.docs;
                            List<UserModel?> _userModels = UserModel.decodeUsers(_docs);
                            _userModels.removeWhere((element) => element?.userId == AuthenticationProvider().currentUser?.uid);
                              if(_userModels.length > 0) {
                                return ListView.builder(
                                  itemCount: _userModels.length,
                                  itemBuilder: (contextListView, index) {
                                    return ListTile(
                                      onTap: () async {
                                        NavigationUtils.showLoadingDialog(contextListView);
                                        //Je veux aller chercher l'id de la room qui contient mes deux users
                                        await ChatProvider.getRoomFromSearch(
                                          peerId: _userModels[index]?.userId ?? ""
                                        ).then((value) {
                                          Navigator.of(contextListView).pop();
                                          String? _roomId;
                                          if(value.docs.isNotEmpty){
                                            Map<String, dynamic>? _documentData = value.docs.single.data();
                                            _roomId = _documentData[Strings.roomIdFirestore];
                                          }
                                          Navigator.of(contextListView).pushNamed(
                                            PAGE_ROOM,
                                            arguments: RoomModel(
                                              roomId: _roomId,
                                              peerUser: _userModels[index],
                                              userIds: ChatProvider.sortIds(_userModels[index]?.userId ?? "")
                                            )
                                          );
                                        }).catchError((error, stackTrace) {
                                          ExceptionUtils.printCatchError(
                                            error: error,
                                            stackTrace: stackTrace,
                                          );
                                          NavigationUtils.showMyDialog(
                                            context: contextListView,
                                            bodyText: Strings.getRoomError
                                          );
                                        });
                                      },
                                      leading: SizedBox(
                                        height: 45,
                                        width: 45,
                                        child: Image.asset(
                                            _userModels[index]?.imagePath ?? "assets/images/user_images/unknown-image.jpeg"
                                        ),
                                      ),
                                      title: Text(
                                        _userModels[index]?.userName ?? "utilisateur",
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            fontSize: 16
                                        ),
                                      ),
                                    );
                                  }
                                );
                              } else {
                                return Center(
                                  child: Text(Strings.noContactFound),
                                );
                              }

                          } else {
                            return Center(
                              child: Text(Strings.noContactFound),
                            );
                          }
                        }
                      }
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
