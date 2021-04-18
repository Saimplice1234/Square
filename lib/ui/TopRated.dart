import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/TopRatedBloc.dart';

// ignore: must_be_immutable
class TopRated extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TopRatedBloc bloc=TopRatedBloc();
    return StreamBuilder(
      stream:bloc.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return Container(
            height:127,width:MediaQuery.of(context).size.width,
            child:ListView.builder(
                itemCount:5,
                physics:BouncingScrollPhysics(),
                scrollDirection:Axis.horizontal,
                itemBuilder: (ctx,i){
                  return FadeIn(
                    child: Container(
                      decoration:BoxDecoration(
                        color:Colors.transparent,
                      ),
                      width:230,
                      margin:EdgeInsets.only(left:12),
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
                            top:80,left:190,
                            child:GestureDetector(
                              onTap:(){
                                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                                  //return YoutubeAppDemo();
                                }));
                              },
                              child: Container(
                                decoration:BoxDecoration(
                                    color:Colors.red,
                                    borderRadius:BorderRadius.all(Radius.circular(100))
                                ),
                                width:25,height:25,
                                child:Icon(Icons.play_arrow_rounded,color:Colors.white,size:12,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        }else{
          return Container(
              height:127,
            child:Center(
              child:SpinKitFadingCircle(color:Colors.red,size:16),
            ),
          );
        }
        return Container();
      },
    );
  }
}
