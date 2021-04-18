import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:square_app_film/Repositories/Repository.dart';
import 'package:square_app_film/blocs/GetVideoBloc.dart';
import 'package:square_app_film/blocs/NowPlayingBloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Video.dart';

// ignore: must_be_immutable
class NowPlayingWidget extends StatelessWidget{
  void _launchURL(_url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  NowPlayingBloc bloc=NowPlayingBloc();
  static PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {
    NowPlayingBloc bloc=NowPlayingBloc();
    GetVideoBloc getVideoBloc=GetVideoBloc();
    return StreamBuilder(
      stream:bloc.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return FadeIn(
            child: Container(
              height:127,width:MediaQuery.of(context).size.width,
              child:ListView.builder(
                  controller:pageController,
                  itemCount:8,
                  physics:const BouncingScrollPhysics(),
                  scrollDirection:Axis.horizontal,
                  itemBuilder: (ctx,i){
                return  Container(
                  decoration:const BoxDecoration(
                    color:Colors.transparent,
                  ),
                  width:230,
                  margin:const EdgeInsets.only(left:12),
                  child:Stack(
                    children: [
                      ClipRRect(
                        borderRadius:BorderRadius.all(Radius.circular(7)),
                        child: CachedNetworkImage(
                          memCacheWidth:1000,
                          useOldImageOnUrlChange:true,
                          width:230,
                          imageUrl:snapshot.data[i]["backdrop_path"] !=null ?"https://image.tmdb.org/t/p/original${snapshot.data[i]["backdrop_path"]}":"https://th.bing.com/th/id/OIP.632guYl-TaK9GJ0f0MF-uwHaHa?pid=ImgDet&rs=1",
                          placeholder: (context, url){
                            return Center(
                              child:SpinKitCircle(color:Colors.red,size:19,),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        child:Container(
                            width:MediaQuery.of(context).size.width,
                            height:128,
                            color:Colors.black.withOpacity(0.7)
                        ),
                      ),
                      Positioned(
                        left:17,top:73,
                        child:Text("Tv series",style:GoogleFonts.poppins(
                          color:Colors.red,fontSize:13,
                        ),),
                      ),
                      Positioned(
                        left:17,top:93,
                        child:Text(snapshot.data[i]["title"],style:TextStyle(
                            color:Colors.white,fontSize:15,fontFamily:"BebasBold"
                        ),),
                      ),
                      Positioned(
                          left:17,top:108,
                          child:Row(
                            children: [
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount:snapshot.data[i]["vote_average"].toInt(),
                                  rating:snapshot.data[i]["vote_average"].toDouble(),
                                  size:10.0,
                                  isReadOnly:true,
                                  color: Colors.red,
                                  spacing:0.0
                              ),
                              SizedBox(width:3),
                              Text(snapshot.data[i]["vote_average"].toString(),style:TextStyle(fontSize:12,color:Colors.white,fontFamily:"BebasBold"))
                            ],
                          )
                      ),
                      Positioned(
                        top:80,left:190,
                        child:GestureDetector(
                          onTap:() async {
                            String idMovie=snapshot.data[i]['id'].toString();
                            var box = await Hive.openBox('idYoutubeBox');
                            var response = await Dio().get('https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=${Repository.apiKey}&language=en-US');
                            box.put('idYoutube',response.data["results"][0]['key']);
                            print(response.data["results"][0]['key']);
                            if(response.data["results"][0]['key'] !=null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (
                                      BuildContext context) {
                                    return VideoPage();
                                  }));
                            }
                            await Dio().close(force:true);

                          },
                          child: Container(
                            decoration:const BoxDecoration(
                                color:Colors.red,
                                borderRadius:BorderRadius.all(Radius.circular(100))
                            ),
                            width:25,height:25,
                            child:const Icon(Icons.play_arrow_rounded,color:Colors.white,size:12,),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
       }else{
          return ElasticInDown(
            delay:const Duration(seconds:1),
            child:Container(
              height:127,
              child:Center(
                child:const SpinKitFadingCircle(color:Colors.red,size:16),
              ),
            ),
          );
        }
    },
    );
  }

}
