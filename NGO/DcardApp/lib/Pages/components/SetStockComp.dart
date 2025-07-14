import 'dart:math';


import 'package:dcard/Query/ParticipatedQuery.dart';
import 'package:dcard/Utilconfig/HideShowState.dart';

import 'package:dcard/models/Topups.dart';
import 'package:get/get.dart';

import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';





class SetStockComp extends StatefulWidget {
  const SetStockComp({Key? key}) : super(key: key);

  @override
  State<SetStockComp> createState() => _SetStockCompState();
}

class _SetStockCompState extends State<SetStockComp> {

  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  var bottomResult=[];

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;






  bool showOveray=false;



  @override
  Widget build(BuildContext context) {



    //return listdata();

    /*WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickBonus();
    });*/
    return Stack(
      children: [
        listdata(),
        if(showOveray)
          Positioned.fill(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white70,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
    //return Center(child: Text("hello"));




  }
  Widget listdata(){
    return  Column(
      children: [
        //ProfilePic().profile(),

        Text("Stocks",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),



        Container(
          height: 55,
          //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TextField(

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              labelText: 'Search',
            ),
            onChanged: (text) async{

              try {

                var resultData=(await ParticipatedQuery().getSearchAllStockOnline(Topups(startlimit:limit,endlimit:_page),BonusModel(uidUser:'',productName:text))).data;
                if(resultData["status"])
                {
                  setState(() {
                    //print(Resul);
                    isLoading=false;
                    hasMoreData=false;
                    _data.clear();

                    _data.addAll(resultData["result"]);
                  });
                }
                else{
                  _data.clear();
                  Quickdata();
                }


              } catch (e) {
                print('Error: $e');
              }

              //print(this._data[index]["total_var"]);
              // print("Text changed to: $text");
            },
          ),
        ),

        Expanded(
          child: ListView.builder(

            controller: _scrollController,
            itemCount: _data.length+1,
            itemBuilder: (context, index) {

              if(index<_data.length)
              {
                FocusNode test=FocusNode() ;

                this._data[index]['focusNode']=test;
                return Card(
                  elevation:0,
                  //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                  //color:Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    side: BorderSide(color:_data[index]["color_var"]??true?Colors.white:Colors.green, width: 2),
                  ),

                  child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(_getRandomIcon()),
                        backgroundColor:getRandomColor(),
                      ),
                      title:Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "${_data[index]['productCode']}(${(_data[index]['pcs']=='none')?'0':_data[index]['pcs']} Pcs):",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " 1X${_data[index]["price"]}",
                                          style: TextStyle(color: Colors.blue),


                                        ),

                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          )






                        ],
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            Icon(Icons.segment,color:Colors.orange,size:13,),
                            Text("tags:${_data[index]['tags']}"),

                          ],
                        ),
                      ),
                      trailing:Container(child:
                      GestureDetector(
                          onTap: () async{
                            // This function will be called when the icon is tapped.
setState(() {
  showOveray=true;
});
                            try {


                              var resultData=(await ParticipatedQuery().getPreviousPriceOnline(Topups(endlimit:int.parse(_data[index]['count'])),BonusModel(uidUser:'',productName:_data[index]["productCode"]))).data;
                            if(resultData["status"])
                            {
                            setState(() {
                            //print(Resul);
                            isLoading=false;

                            bottomResult.clear();

                            bottomResult.addAll(resultData["result"]);
                            showOveray=false;
                            });
                           // print(bottomResult);
                            var pcs="${(_data[index]['pcs']=='none')?'0':_data[index]['pcs']}";
                            Get.put(HideShowState()).setDefaultInterest(5);
                            viewThisProduct(_data[index]['productCode'],pcs);


                            }
                            else{
                              //showOveray=false;
                            bottomResult.clear();

                            }


                            } catch (e) {
                            Text("${e}");
                            }

                          },
                          child:Icon(Icons.grid_view,color:Colors.orange)
                      )


                      )

                    //trailing: Text()
                  ),
                );

              }
              else{
                return  Padding(
                  padding:EdgeInsets.symmetric(vertical: 32),
                  child:Center(
                      child:hasMoreData?
                      CircularProgressIndicator()
                          :Text("no more Data")

                  ),
                );
              }

            },
          ),
        ),
      ],
    );
  }
  void initState()
  {
    super.initState();
    //getapi();

      Quickdata();
      _scrollController.addListener(_scrollListener);

  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page=_page+10;

      Quickdata();
    }
  }


  void dispose() {


    _scrollController.dispose();
    super.dispose();
  }



  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  IconData _getRandomIcon() {
    Random random = Random();
    List<IconData> icons = [Icons.favorite,Icons.star,Icons.thumb_up,Icons.access_time,Icons.access_time,Icons.fastfood,Icons.directions_bike,      Icons.directions_walk,      Icons.directions_car,      Icons.directions_boat,      Icons.airplanemode_active,      Icons.airport_shuttle,      Icons.beach_access,      Icons.camera,      Icons.movie,      Icons.music_note,      Icons.spa,      Icons.palette,      Icons.account_balance,      Icons.attach_money,    ];
    return icons[random.nextInt(icons.length)];
  }


  //

  Quickdata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    var resultData=(await ParticipatedQuery().getSearchAllStockOnline(Topups(startlimit:limit,endlimit:_page),BonusModel(uidUser:'',productName:'none'))).data;

    setState(() {
      isLoading=false;
      if(resultData["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }
      //_data.clear();

      _data.addAll(resultData["result"]);
    });


  }
  void viewThisProduct(productName,pcs) {

    Get.bottomSheet(
      Container(
        padding:EdgeInsets.all(5.0),
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ListView(

          children: [

            Center(child: Text("${productName}")),
          Container(
            width: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(()=>
                    SizedBox(

                      child: IntrinsicWidth(
                        child: TextField(
                          //controller: TextEditingController(text:"${_data[index]["textchange_var"]??_data[index]["qty"]}"),

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: ' interest is ${Get.put(HideShowState()).defaultInterest.value} Change interest',

                            hintStyle: TextStyle(color: Colors.blue),
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,



                          ),
                          style: TextStyle(
                            color: Colors.blue, // Set the text color to red

                          ),
                          onChanged: (text) {

                            try {
                              //numVal = num.parse(str);
                              var myValue = int.tryParse(text);

                              if (myValue != null && !myValue.isNaN && myValue>=0) {

                                Get.put(HideShowState()).setDefaultInterest(myValue);

                              } else {

                              }
                            } catch (e) {

                              print('Error: $e');
                            }

                            //print(this._data[index]["total_var"]);
                            // print("Text changed to: $text");
                          },
                          focusNode: FocusNode(),


                        ),
                        stepWidth: 0.5, // set minimum width to 100
                      ),
                    ),


                ),
              ],
            ),
          ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bottomResult.length,
              itemBuilder: (context, index) {




                return Container(
                  decoration: BoxDecoration(

                      border: Border(bottom
                          : BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                          width: 5

                      ))),
                  child: Card(
                    elevation:0,

                    //color:Colors.grey,


                    child: ListTile(

                      title: Container(
                        child: Obx(()=>
                            Column(

                              children: [
                                Center(child: Text('Price:${bottomResult[index]["price"]} ')),
                                SizedBox(height:5,),
                               Visibility(
                                 visible: false,
                                   child: Text("${Get.put(HideShowState()).defaultInterest.value}")),


                               if(num.parse(pcs)>0)
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Text('- Price(1pc)=${(num.parse(bottomResult[index]["price"])+Get.put(HideShowState()).defaultInterest.value)/num.parse(pcs)}'),
                                   SizedBox(height:5,),

                                   Text('- Price(12pcs)=${((num.parse(bottomResult[index]["price"])+Get.put(HideShowState()).defaultInterest.value)/num.parse(pcs))*12}',),
                                   SizedBox(height:5,),

                                   Text('- Price Bds (${pcs}pcs)=${((num.parse(bottomResult[index]["price"])+Get.put(HideShowState()).defaultInterest.value))}',),

                                 ],
                               )

                              ],
                            )
                        ),
                      )
                    ),
                  ),
                );
              },
            ),
            // Other widgets...
          ],
        ),
      ),
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });

  }




//
}


