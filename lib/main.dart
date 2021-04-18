import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:square_app_film/ui/NowPlaying.dart';
import 'package:square_app_film/ui/SearchResults.dart';
import 'package:square_app_film/ui/SplahScreen.dart';
import './ui/TopRated.dart';
import 'package:square_app_film/ui/SearchBar.dart';
import 'package:square_app_film/ui/TopTrends.dart';

void main() async{
  WidgetsFlutterBinding();
  Directory directory=await getApplicationDocumentsDirectory();
  await Hive.init(directory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition:Transition.fadeIn,
      debugShowCheckedModeBanner:false,
      home:SplashScreenCustom(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      resizeToAvoidBottomInset:false,
      backgroundColor:Colors.black,
      body:PageView(
        //physics:NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child:GestureDetector(
              onTap:(){
                FocusScopeNode currentFocus=FocusScope.of(context);
                if(!currentFocus.hasPrimaryFocus){
                  currentFocus.unfocus();
                }
              },
              child:Column(
                children: [
                  SizedBox(height:80,),
                  //SearchBar(),
                  SizedBox(height:10,),
                  Container(
                    margin:EdgeInsets.only(left:12,right:12),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recommended For You",style:GoogleFonts.poppins(color:Colors.red,fontSize:19,fontWeight:FontWeight.bold),),
                        Text("...",style:GoogleFonts.poppins(color:Colors.red,fontSize:17),),
                      ],
                    ),
                  ),
                  SizedBox(height:2,),
                  Container(
                    margin:EdgeInsets.only(left:12,right:12),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Get all now playing movies",style:GoogleFonts.poppins(color:Colors.white.withOpacity(0.7),fontSize:11),),
                      ],
                    ),
                  ),
                  SizedBox(height:10,),
                  NowPlayingWidget(),
                  SizedBox(height:10,),
                  SizedBox(height:10,),
                  SizedBox(height:10,),
                  Container(
                    margin:EdgeInsets.only(left:12,right:12),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Top Trends",style:GoogleFonts.poppins(color:Colors.red,fontSize:19,fontWeight:FontWeight.bold),),
                        Text("...",style:GoogleFonts.poppins(color:Colors.red,fontSize:17),),
                      ],
                    ),
                  ),
                  SizedBox(height:2,),
                  Container(
                    margin:const EdgeInsets.only(left:12,right:12),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("All trending movies",style:GoogleFonts.poppins(color:Colors.white.withOpacity(0.7),fontSize:11),),
                      ],
                    ),
                  ),
                  SizedBox(height:10,),
                  TopTrends(),
                  SizedBox(height:8,),
                  TopRated(),
                  SizedBox(height:10,),
                ],
              ),
            )
          ),
          SingleChildScrollView(
            child:Column(
              children: [
                SizedBox(height:100,),
                SearchBar(),
                SearchResults()
              ],
            ),
          ),
        ],
      ),
      appBar:PreferredSize(
        preferredSize:const Size.fromHeight(80),
        child:Container(
          decoration:const BoxDecoration(
            gradient:const LinearGradient(
              begin:Alignment.topCenter,
              end:Alignment.bottomCenter,
              colors:[
                Colors.black,
                Colors.transparent
              ]
            )),
          child:Row(
            children: [
              SizedBox(width:12,),
              ElasticInDown(
                child:const SpinKitFadingCube(color:Colors.red,size:20,),
              ),
              SizedBox(width:MediaQuery.of(context).size.width/2/2/2,),
              Row(
                children: [
                  Text("Tv show",style:TextStyle(color:Colors.redAccent,fontFamily:"BebasBold"),),
                  SizedBox(width:48,),
                  Text("Movies",style:TextStyle(color:Colors.white,fontFamily:"BebasBold"),),
                  SizedBox(width:48,),
                  Text("Profil",style:TextStyle(color:Colors.white,fontFamily:"BebasBold"),),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }

}
