import 'package:flutter/material.dart';

class HomeCh2 extends StatefulWidget {
  @override
  _HomeCh2State createState() => _HomeCh2State();
}

class _HomeCh2State extends State<HomeCh2> {
  ///Stores the user's input values in here.
  double? _numberFrom;

  /// List Items
  var fruits = ['Orange', 'Apple', 'Strawberry', 'Banana'];

  /// The initState is called once for each State object when the State is bult.
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

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

  ///Map List of data's sheets
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  /// a combination of conversion formulas.
  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasures are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  ///Multipliers data's Conversion.
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1]
  };

  /// For the result message.
  String? _resultMessage;

  /// This is for selected dropdown values
  ///
  String? _startMeasures;

  /// Fruits Selected Items
  String? _convertedMeasure;

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
          padding: EdgeInsets.only(top: 23),
          child:

              /// Use [IntrinsicHeight] if use [Spacer()] inside the widget of [SingleChildScrollView]
              IntrinsicHeight(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                /// a text value
                ///
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Value',
                      style: labelStyle,
                    ),
                  ),
                ),

                // Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: inputStyle,
                    decoration: InputDecoration(

                        /// Hint text to show a hint when text field is empty
                        hintText: "Please insert a value"),
                    onChanged: (text) {
                      var rv = double.tryParse(text);
                      if (rv != null) {
                        setState(() {
                          _numberFrom = rv;
                        });
                      }
                    },
                  ),
                ),

                // Spacer(),

                /// Text in the bottom
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'From',
                    style: labelStyle,
                  ),
                ),

                ///
                ///
                ///
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
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
                ),

                /// Shows that user output of user's input field.
                Text((_numberFrom == null) ? '' : _numberFrom.toString()),

                ///
                ///

                // Spacer(),

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    'To',
                    style: labelStyle,
                  ),
                ),

                // Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: DropdownButton<String>(
                    /// Fruits is to set when the item is selected
                    value: _convertedMeasure,

                    /// Because we call a map we have to use [entries] and [MapEntry] keep that in mind.
                    items: _measuresMap.entries.map((MapEntry newValue) {
                      return DropdownMenuItem<String>(
                        /// We need to use a [key]
                        child: Text(newValue.key.toString()),
                        value: newValue.key,
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _convertedMeasure = newValue;
                        print(_convertedMeasure);
                      });
                    },
                  ),
                ),

                // Spacer(
                //   flex: 2,
                // ),

                ///The Raised Button is Deprecated, use ElevatedButton instead.
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      'Convert',
                      style: inputStyle,
                    ),
                    onPressed: () {
                      if (_startMeasures!.isEmpty ||
                          _convertedMeasure!.isEmpty ||
                          _numberFrom == 0) {
                        return;
                      } else {
                        convert(
                          _numberFrom!,
                          _startMeasures!,
                          _convertedMeasure!,
                        );
                      }
                    },
                  ),
                ),

                // Spacer(
                // flex: 2,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (_resultMessage == null) ? '' : _resultMessage.toString(),
                    style: labelStyle,
                  ),
                ),

                // Spacer(
                //   flex: 19,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
