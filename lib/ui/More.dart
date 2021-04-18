import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MorePageTrends extends StatelessWidget {
  String title;
  String tagsHero;
  String posterPath;
  String backdropPath;
  String overview;
  String lang;
  String releaseDate;
  MorePageTrends({this.tagsHero,this.posterPath,this.title,this.backdropPath,this.overview,this.lang,this.releaseDate});
  @override
  Widget build(BuildContext context) {
    List <String> titleMenu=["Images","Similar Movies"];
    ValueNotifier<int> _pageNotifier = ValueNotifier(0);
    PageController _PageController=PageController();
    return Scaffold(
      extendBodyBehindAppBar:true,
      backgroundColor:Colors.black,
      body:SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height:0),
            Container(
              width:MediaQuery.of(context).size.width,
              height:200,
              child:Stack(
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width,
                    height:200,
                    child: CachedNetworkImage(
                      fit:BoxFit.cover,
                      memCacheWidth:1000,
                      useOldImageOnUrlChange:true,
                      imageUrl:backdropPath!=null ?"https://image.tmdb.org/t/p/original${backdropPath}":"https://th.bing.com/th/id/OIP.632guYl-TaK9GJ0f0MF-uwHaHa?pid=ImgDet&rs=1",
                      placeholder: (context, url){
                        return Center(
                          child:SpinKitCircle(color:Colors.red,size:19,),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top:-12,
                    child:Container(
                        width:MediaQuery.of(context).size.width,
                        height:300,
                        color:Colors.black.withOpacity(0.8)
                    ),
                  ),
                  Positioned(
                    top:125,
                    child:Container(
                        width:MediaQuery.of(context).size.width,
                        height:80,
                        decoration:BoxDecoration(
                          gradient:LinearGradient(
                            end:Alignment.topCenter,
                            begin:Alignment.bottomCenter,
                            colors:[
                              Colors.black,
                              Colors.transparent
                            ]
                          )
                        ),
                    ),
                  ),
                  Positioned(
                    top:75,left:23,
                    child: Hero(
                    tag:this.tagsHero,
                    child:Container(
                    width:70,
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(4)),
                      child: CachedNetworkImage(
                      memCacheWidth:1000,
                      useOldImageOnUrlChange:true,
                      imageUrl:this.posterPath!=null ?"https://image.tmdb.org/t/p/original${this.posterPath}":"https://th.bing.com/th/id/OIP.632guYl-TaK9GJ0f0MF-uwHaHa?pid=ImgDet&rs=1",
                      placeholder:(context,other){
                        return Container(
                            width:80,height:120,
                            child:Center(child: SpinKitFadingCircle(color:Colors.red,size:16)));
                      },
                       ),
                    ),
                    ),
                   ),
                  ),
                  Positioned(
                    top:140,left:260,
                    child:GestureDetector(
                      child: Container(
                        decoration:const BoxDecoration(
                            color:Colors.red,
                            borderRadius:BorderRadius.all(Radius.circular(100))
                        ),
                        width:45,height:45,
                        child:const Icon(Icons.play_arrow_rounded,color:Colors.white,size:17,),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height:10),
            Row(
              children: [
                SizedBox(width:23),
                Text(title,style:GoogleFonts.poppins(color:Colors.white,fontSize:13,fontWeight:FontWeight.bold)),
              ],
            ),
            SizedBox(height:6),
            Row(
              children: [
                SizedBox(width:23,),
                Container(
                  width:50,height:23,
                  decoration:BoxDecoration(
                      color:Colors.transparent,
                      borderRadius:BorderRadius.all(Radius.circular(4)),
                      border:Border.all(
                      color:Colors.red
                    )
                  ),
                  child:Center(child: Text("EN",style:GoogleFonts.alata(color:Colors.red))),
                ),
                Container(
                  width:50,height:23,
                  child:Center(child: Text("${releaseDate[0].toString()}${releaseDate[1].toString()}${releaseDate[2].toString()}${releaseDate[3].toString()}",style:GoogleFonts.alata(color:Colors.white))),
                ),
              ],
            ),
            SizedBox(height:10),
            Row(
              children: [
                SizedBox(width:23),
                Text("Overview",style:GoogleFonts.alata(color:Colors.white,fontSize:13,fontWeight:FontWeight.bold)),
              ],
            ),
            SizedBox(height:10),
            Row(
              children: [
                SizedBox(width:23),
                Container(
                  width:MediaQuery.of(context).size.width-40,
                    child: Text(overview,style:GoogleFonts.alata(color:Colors.white,fontSize:13))),
              ],
            ),
            SizedBox(height:10),
            Row(
              children: [
                SizedBox(width:23),
                Text("Casting",style:GoogleFonts.alata(color:Colors.white,fontSize:13,fontWeight:FontWeight.bold)),
              ],
            ),
            Container(
              height:60,
              child:ListView.builder(
                physics:BouncingScrollPhysics(),
                scrollDirection:Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin:EdgeInsets.only(left:20),
                    child: CircleAvatar(
                      backgroundColor:Colors.white.withOpacity(0.1),
                    ));
              },),
            ),
            Container(
              height:60,
              child:ListView.builder(
                itemCount:2,
                physics:BouncingScrollPhysics(),
                scrollDirection:Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      _pageNotifier.value=index;
                      _PageController.animateToPage(_pageNotifier.value, duration:Duration(milliseconds:400), curve:Curves.linear);
                    },
                    child: Container(
                      width:90,
                        child: Center(child:ValueListenableBuilder(
                          valueListenable:_pageNotifier,
                          builder: (BuildContext context, value, Widget child) {
                          return Text(titleMenu[index],style:GoogleFonts.alata(color:value == index ?Colors.red:Colors.white,fontWeight:FontWeight.bold));
                        },
                        ))),
                  );
                },),
            ),
            Container(
              height:420,
              child:PageView(
                onPageChanged:(i){
                  _pageNotifier.value=i;
                },
                controller:_PageController,
                children: [
                  Container(color:Colors.white.withOpacity(0.1)),
                  Container(color:Colors.white.withOpacity(0.1)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
