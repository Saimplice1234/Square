import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:square_app_film/blocs/TrendingBloc.dart';
import 'package:get/get.dart';
import 'More.dart';

class TopTrends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrendingBloc bloc=TrendingBloc();
    return Container(
      height:180,width:MediaQuery.of(context).size.width,
      child:StreamBuilder(
        stream:bloc.stream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data);
          if(snapshot.hasData){
            return ListView.builder(
              itemCount:10,
              physics:BouncingScrollPhysics(),
              scrollDirection:Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
                return FadeIn(
                  child:GestureDetector(
                    onTap:(){
                      Get.to(()=>MorePageTrends(
                        tagsHero:'trends-$i',
                        posterPath:snapshot.data[i]["poster_path"],
                        title:snapshot.data[i]["title"],
                        backdropPath:snapshot.data[i]["backdrop_path"],
                        overview:snapshot.data[i]["overview"],
                        lang:snapshot.data[i]["original_language"],
                        releaseDate:snapshot.data[i]["release_date"],
                      ));

                    },
                    child: Container(
                      margin:EdgeInsets.only(left:12),
                      width:80,
                      decoration:BoxDecoration(
                          color:Colors.transparent,
                      ),
                      child:Column(
                        children: [
                          Stack(
                            children: [
                              Hero(
                                tag:'trends-$i',
                                child:Container(
                                  width:80,
                                  child:ClipRRect(
                                    borderRadius:BorderRadius.all(Radius.circular(3)),
                                    child: CachedNetworkImage(
                                      memCacheWidth:1000,
                                      useOldImageOnUrlChange:true,
                                      imageUrl:snapshot.data[i]["poster_path"] !=null ?"https://image.tmdb.org/t/p/original${snapshot.data[i]["poster_path"]}":"https://th.bing.com/th/id/OIP.632guYl-TaK9GJ0f0MF-uwHaHa?pid=ImgDet&rs=1",
                                      placeholder:(context,other){
                                        return Container(
                                            width:80,height:120,
                                            child:Center(child: SpinKitFadingCircle(color:Colors.red,size:16)));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top:0,
                                  child: Container(
                                    width:80,height:120,
                                    color:Colors.black.withOpacity(0.5),)),
                            ],
                          ),
                          SizedBox(height:6,),
                          Row(
                            children: [
                              Container(
                                width:70,
                                  child:AutoSizeText(
                                    snapshot.data[i]["title"],style:GoogleFonts.poppins(color:Colors.white),
                                    maxLines:1,
                                    overflow:TextOverflow.ellipsis,
                                    minFontSize:9,
                                    maxFontSize:9,
                                  ),

                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  child:Icon(Icons.star,color:Colors.red,size:12,)
                              ),
                              Text(snapshot.data[i]["vote_average"].toString(),style:GoogleFonts.poppins(color:Colors.white,fontSize:10))
                            ],
                          )
                        ],
                      )
                    ),
                  ),
                );
              },);
          }
          return Container(
              height:180,
            child:Center(
              child:SpinKitFadingCircle(color:Colors.red,size:16),
            ),
          );
        }
      ),
    );
  }
}
/*
Stack(
                    children: [
                      ClipRRect(
                        borderRadius:BorderRadius.all(Radius.circular(3)),
                        child: CachedNetworkImage(
                          imageUrl:snapshot.data[i]["poster_path"] !=null ?"https://image.tmdb.org/t/p/original${snapshot.data[i]["poster_path"]}":"https://th.bing.com/th/id/OIP.632guYl-TaK9GJ0f0MF-uwHaHa?pid=ImgDet&rs=1",
                        ),
                      ),
                      Container(color:Colors.black.withOpacity(0.6))
                    ],
                  )
 */