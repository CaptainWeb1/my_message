
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';

class MessageContainerWidget extends StatelessWidget {
  
  final bool isCurrentUser;
  
  const MessageContainerWidget({
    Key? key, 
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: isCurrentUser ? MyShapes.radiusCircularZero : MyShapes.radiusCircular,
          topRight: isCurrentUser ? MyShapes.radiusCircular : MyShapes.radiusCircularZero,
          bottomLeft: MyShapes.radiusCircular,
          bottomRight: MyShapes.radiusCircular,
        ),
        color: isCurrentUser ? Theme.of(context).primaryColor : MyColors.containerColor,
      ),
      child: Text(
        "Ceci est un message de test",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 4,
              )]
        ),
      ),
    );
  }
}