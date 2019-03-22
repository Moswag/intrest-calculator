import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Intrest Calculator",
      home: SIForm(),
      theme: ThemeData(
        brightness:Brightness.dark ,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm>{

  var _formKey=GlobalKey<FormState>();

  var _currencies=['Dollars','RTGS','Swipe','Ecocash'];
  final _minimumPadding=5.0;

  var _currentItemSelected='';

  //to instantiate dynamically
  @override
  void initState() {
    super.initState();
    _currentItemSelected=_currencies[0];
  }

  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();

  var displayResult='';

  @override
  Widget build(BuildContext context) {
    
    TextStyle textStyle=Theme.of(context).textTheme.title;
    
    // TODO: implement build
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Intrest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding*10),
 //       margin: EdgeInsets.all(_minimumPadding*10), //used for a container
        child: ListView(
          children: <Widget>[
            getImageAsset(),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child:TextFormField(
              keyboardType: TextInputType.number ,
              style: textStyle,
              controller: principalController,
              validator: (String value){
                if(value.isEmpty){
                  return 'Please enter principal amount';
                }
              },
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter Principal eg 12000',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 15
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            )
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                keyboardType: TextInputType.number ,
                style: textStyle,
                controller: roiController,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter the return on investment";
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In percent',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
              children: <Widget>[
                Expanded(child: TextFormField(
                  keyboardType: TextInputType.number ,
                  style: textStyle,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please fill in the Term";
                    }
                  },
                  controller: termController,
                  decoration: InputDecoration(
                    labelText: 'Term',
                    hintText: 'Time In Years',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                )),

                Container(width: _minimumPadding*5,),   //for space

                Expanded(child: DropdownButton<String>(
                  items: _currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                  value: _currentItemSelected,

                  onChanged: (String newValueSelected){
                    _onDropItemSelected(newValueSelected);

                  },
                )
                )
              ],
            )
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text("Calculate", textScaleFactor: 1.5,),  //textScaleFactor is for making the font X2
                      onPressed: (){
                      //login for onClick
                        setState(() {
                          if(_formKey.currentState.validate()){
                            this.displayResult= _calculateTotalReturn();
                          }

                        });

                      }),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text("Reset", textScaleFactor: 1.5),
                      onPressed: (){
                      _reset();
                      }),
                )
              ],
            )
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child: Text(this.displayResult, style: textStyle,),
            )

          ],
        ),
      ),
      ),
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage=AssetImage("images/mari.png");
    Image image=Image(image: assetImage, width: 125,height: 125,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding*10),);
  }

  void _onDropItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected=newValueSelected;
    });
  }

  String _calculateTotalReturn(){
    double principal=double.parse(principalController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);

    double totalAmountPayable=principal +(principal * roi * term) /100;
    String result='After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;


  }

  void _reset() {
    principalController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    _currentItemSelected=_currencies[0];
  }

}

