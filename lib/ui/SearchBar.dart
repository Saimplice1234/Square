import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:square_app_film/blocs/SearchResultsBloc.dart';
import 'package:get/get.dart';
import 'SearchResults.dart';

class SearchBar extends StatelessWidget {
  SearchResultsBloc bloc=SearchResultsBloc();
  TextEditingController _TextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height:50,
      margin:const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:const Color(0xff696969).withOpacity(0.1),
        borderRadius:BorderRadius.all(Radius.circular(3)),
      ),
      child:Padding(
        padding: const EdgeInsets.only(top:2.0,left:10,right:15),
        child: TextField(
          cursorColor:Colors.white,
          onChanged:(str){
            if(str.isNotEmpty){
              bloc.sink.add([{"name":"SLG"}]);
            }
          },
          style:TextStyle(
            color:Colors.white,fontFamily:"BebasBold",
          ),
          decoration:InputDecoration(
            border: InputBorder.none,
            focusColor:Colors.white,
            hintText:"Search Tv movies,series and other",
            suffix:GestureDetector(
              onTap:(){
                Get.to(SearchResults());
              },
              child:Container(
                child: Icon(Icons.search,color:Colors.white,size:16),
              ),
            ),
            hintStyle:TextStyle(
                color:Colors.white,fontFamily:"BebasBold",fontSize:16
            ),
          ),
        ),
      ),
    );
  }
}

