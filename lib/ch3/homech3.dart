import 'package:flutter/material.dart';

/// An import user or third packages
import 'package:img_pict/ch3/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

///
///The [Padding]
final double defaultPadding = 5.0;

class HomeCh3 extends StatelessWidget {
  ///A function
  void emptyMethod() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work TImer'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              ///Padding to add space between the appbar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff009688),
                        text: "Work",
                        onPressed: emptyMethod,
                        size: null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: emptyMethod,
                        size: null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: "Long Break",
                        onPressed: emptyMethod,
                        size: null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
              ),

              /// This is a [CircularPercentIndicator]
              Expanded(
                child: CircularPercentIndicator(
                  radius: availableWidth / 2,
                  lineWidth: 10.0,
                  percent: 1,
                  center: Text(
                    '30:00',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  progressColor: Color(0xff009688),
                ),
              ),
///////// ========The end of the [CircularPercentIndicator]=========

              Padding(
                /// Padding to add some space in the bottom.
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff212121),
                        text: 'Stop',
                        onPressed: emptyMethod,
                        size: null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Restart',
                        onPressed: emptyMethod,
                        size: null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
