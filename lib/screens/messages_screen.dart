import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_message/models/user_model.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/providers/chat_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class MessagesScreen extends StatefulWidget {

  MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  String _searchText = "";

  List<UserModel> _usersFiltered = [];

  void _filterMessages() {
    List<UserModel> _usersToFilter = [];
    setState(() {
      if (_searchText == "") {
          _usersFiltered = List.from(users);
      } else {
        for (var user in users) {
          String _username = user.userName ?? "";
          if (_username.toLowerCase().contains(_searchText.toLowerCase())) {
            _usersToFilter.add(user);
          }
        }
        _usersFiltered = List.from(_usersToFilter);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _usersFiltered = List.from(users);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider().reloadFirebase(context: context);
    return Scaffold(
      body: Padding(
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
                    onPressed: () => AuthenticationProvider().signOut(context),
                    icon: IconWidget(
                      icon: Icons.power_settings_new_outlined,
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
            Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFieldWidget(
                textFieldParameters: SearchTextFieldParameters(),
                valueChanged: (value) {
                  _searchText = value;
                  _filterMessages();
                },
              ),
            ),
            Expanded(
              flex: 14,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: MessageTileWidget(
                          key: UniqueKey(),
                          usersFiltered: _usersFiltered,
                          index: index,
                      ),
                    );
                  },
                  itemCount: _usersFiltered.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(PAGE_SEARCH),
        child: Icon(
          Icons.create,
        )
      ),
    );
  }
}

class MessageTileWidget extends StatelessWidget {
  const MessageTileWidget({
    Key? key,
    required usersFiltered,
    required this.index,
  }) : _usersFiltered = usersFiltered, super(key: key);

  final _usersFiltered;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(PAGE_CHAT),
      leading: Image.asset(
          _usersFiltered[index]?.imagePath ?? "assets/images/user_images/unknown-image.jpeg"
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _usersFiltered[index]?.userName ?? "pseudo",
            style: MyTextStyles.bodyLink,
          ),
          Text(
              "Ceci est un message",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 16
            ),
          ),
        ],
      ),
      trailing: Text(
        Strings.exampleDate,
        style: MyTextStyles.dateMessagesScreen,
      ),
    );
  }
}
