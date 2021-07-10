import 'package:flutter/material.dart';
import 'package:my_message/models/user_model.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Spacer(flex: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.titleApp,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFieldWidget(
                textFieldParameters: SearchTextFieldParameters(),
              ),
            ),
            Expanded(
              flex: 14,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(context, PAGE_CHAT),
                        leading: Image.asset(
                          users[index]?.imagePath ?? "assets/images/user_images/unknown-image.jpeg"
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                users[index]?.userName ?? "pseudo",
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
                      ),
                    );
                  },
                  itemCount: users.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
