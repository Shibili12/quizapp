import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Myloadingindicator extends StatelessWidget {
  Color bg_Color;
  Myloadingindicator({
    this.bg_Color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotateMultiple,

            /// Required, The loading type of the widget
            colors: const [
              Colors.purple,
            ],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            backgroundColor: bg_Color,

            /// Optional, Background of the widget
            pathBackgroundColor: Colors.white

            /// Optional, the stroke backgroundColor
            ),
      ),
    );
  }
}
