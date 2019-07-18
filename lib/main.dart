import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest",
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      )));
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formKey= GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 3.0;
  var _currentItemSelected = "Rupees";
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please Enter Principal Amount';
                      }
                    },

                    keyboardType: TextInputType.number,
                    controller: principalControlled,
                    style: textStyle,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20.0
                      ),
                        labelText: "Principal",
                        labelStyle: textStyle,
                        hintText: 'Enter Principal e.g. 10000',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                ),
                
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please Enter Rate of Interest';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: roiControlled,
                    style: textStyle,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color:Colors.yellow,
                        fontSize: 20.0
                      ),
                        labelText: "Rate of Interest",
                        hintText: 'In Percent',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        validator: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Time in years';
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: termControlled,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20.0
                          ),
                            labelText: "Time",
                            labelStyle: textStyle,
                            hintText: 'In Years',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Expanded(

                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,

                            style: textStyle,

                          ),

                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    )
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(5),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          highlightElevation: 5.0,
                          onPressed: () {
                            if(_formKey.currentState.validate())
                            setState(() {
                              if(_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturn();
                              }
                            });
                          }),
                    ),
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          highlightElevation: 5.0,
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          }),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        this.displayResult,
                        style: textStyle,
                        softWrap: true,
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years , your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }
  void _reset(){
    principalControlled.text="";
    roiControlled.text="";
    termControlled.text="";
    displayResult="";
    _currentItemSelected=_currencies[0];
  }
}
