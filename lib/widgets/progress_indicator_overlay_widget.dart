
import 'package:flutter/material.dart';
import 'package:my_message/widgets/circular_progress_indicator_widget.dart';

class ProgressIndicatorOverlayWidget extends StatelessWidget {
  const ProgressIndicatorOverlayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54.withOpacity(0.5),
        child: Center(
            child: CircularProgressIndicatorWidget()
        ),
      ),
    );
  }
}
