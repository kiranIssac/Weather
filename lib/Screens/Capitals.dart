import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathers/Model/CapitalModel.dart';
import '../ViewModel/Capital_viewModel.dart';
import 'DetailWeather.dart';

class Capitals extends StatefulWidget {
  const Capitals({Key? key}) : super(key: key);

  @override
  State<Capitals> createState() => _CapitalsState();
}

class _CapitalsState extends State<Capitals> {
  bool searchStatus=true;
  List<CapitalModel> _searchResult = [];
  List<String> countryList=[];
  List<CapitalModel> capitalList=[];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() { // This listner is used to listen to what user is typed in the search box.
      _searchResult.clear();
      searchStatus=false;
      if (_searchController.text.isNotEmpty) {

        for(var capitalModel in capitalList) {
          if (capitalModel.capital[0].toLowerCase().contains(
              _searchController.text.toLowerCase())) {
            _searchResult.add(capitalModel);// Sort the _searchResult List accordingly with what user typed in search box
          }
        }
      } else {
        _searchResult.addAll(capitalList);
      }
      setState(() {});
    });
    _searchResult.addAll(capitalList);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery. of(context). size. width;
    return Scaffold(
      body: Container(
        child:Center(
          child: Consumer<CapitalViewModel>(
          builder: (context, provider, child)
    {
     capitalList = provider.capitalList;// List of CapitalModel is fetched from CapitalViewModel Change notifier class
     if(searchStatus){ // Status check is done to verify the widget is just build and then save the whole capitalList to _searchList
       _searchResult.addAll(capitalList);
     }

      return provider.loading == false
          ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 10, right: 10, bottom: 10),
              child: Container(
                height: 50,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11),
                      bottomLeft: Radius.circular(11),
                      bottomRight: Radius.circular(11)
                  ),

                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              hintText: "Search country capitals by region",
                              border: InputBorder.none),
                        ),
                      ),
                      Image.asset("Images/search.png"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(

              child: ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          Provider.of<CapitalViewModel>(context, listen: false)
                              .passCapitalName(_searchResult[i].capital[0].toString(),context);// Pass capital name to the change Notifier
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  DetailsWeather()),);
                          },
                        child: Container(
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),

                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,
                                    3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset("Images/Vector.png"),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(_searchResult[i].name.common,
                                            style: TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff5884D7),)
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "Images/image 4.png", height: 150),

                                      Text(
                                      _searchResult[i].capital[0].toString(),
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        '24 degrees',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ]
      ): CircularProgressIndicator();
  },),
      ),
        ),

    );
  }
}
