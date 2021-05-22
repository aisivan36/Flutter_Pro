import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  ///Stores the user's input values in here.
  // double? _numberFrom;

  /// List Items
  var fruits = ['Orange', 'Apple', 'Strawberry', 'Banana'];

  /// The initState is called once for each State object when the State is bult.
  // void initState() {
  //   _numberFrom = 0;
  //   super.initState();
  // }

  /// This is for inputStyle widget
  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );

  /// This is for labelStyle widget
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  ///This is a for nothing
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  /// This is for selected dropdown values
  ///
  String? _startMeasures;

  /// Fruits Selected Items
  // String? _convertedMeasure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:

            /// When a keyboard on a smartphone is appeared then it will causes an issue with the screen. Thus, it will be good idea to always use a [SingleChildScrollView] before the [Column] widget, in order to solve this problem.
            SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Spacer(),
              Text(
                'Value',
                style: labelStyle,
              ),
              // Spacer(),

              // TextField(
              //   style: inputStyle,
              //   decoration: InputDecoration(

              //       /// Hint text to show a hint when text field is empty
              //       hintText: "Please insert a value"),
              //   onChanged: (text) {
              //     var rv = double.tryParse(text);
              //     if (rv != null) {
              //       setState(() {
              //         _numberFrom = rv;
              //       });
              //     }
              //   },
              // ),
              // Spacer(),

              // /// Text in the bottom
              // Text(
              //   'From',
              //   style: labelStyle,
              // ),

              // ///
              // ///
              // ///
              DropdownButton(
                items: _measures.map((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
                onChanged: (buttonSelect) {
                  setState(() {
                    _startMeasures = buttonSelect as String;
                    print(_startMeasures);
                  });
                },

                /// _startMeasures is to set when the item is selected
                value: _startMeasures,
              ),

              // /// Shows that user output of user's input field.
              // Text((_numberFrom == null) ? '' : _numberFrom.toString()),

              // ///
              // ///
              // ///
              // Spacer(),
              // Text(
              //   'To',
              //   style: labelStyle,
              // ),
              // Spacer(),
              // DropdownButton<String>(
              //   /// Fruits is to set when the item is selected
              //   value: _convertedMeasure,
              //   items: fruits.map((String newValue) {
              //     return DropdownMenuItem(
              //       child: Text(newValue),
              //       value: newValue,
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _convertedMeasure = newValue;
              //       print(_convertedMeasure);
              //     });
              //   },
              // ),
              // Spacer(
              //   flex: 2,
              // ),

              ///The Raised Button is Deprecated, use ElevatedButton instead.
              // ElevatedButton(
              //     child: Text(
              //       'Convert',
              //       style: inputStyle,
              //     ),
              //     onPressed: () => true),
              // Spacer(
              //   flex: 2,
              // ),
              // Text(
              //   (_numberFrom == null) ? '' : _numberFrom.toString(),
              // ),
              // Spacer(
              //   flex: 19,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
