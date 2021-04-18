import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:square_app_film/Repositories/Repository.dart';
import 'package:square_app_film/blocs/bloc.dart';

class NowPlayingBloc extends Bloc{

  NowPlayingBloc(){
   FetchNowPlaying();
  }
  // ignore: non_constant_identifier_names, missing_return
  Future  FetchNowPlaying() async{
    try {
      var response = await Dio().get('https://api.themoviedb.org/3/movie/now_playing?api_key=${Repository.apiKey}&language=en-US&page=1');
      sink.add(response.data["results"]);
      await Dio().close(force:true);
    } catch (e) {
      print(e);
    }
  }
  final _streamController=BehaviorSubject<List<dynamic>>();
  Sink<List<dynamic>> get sink =>_streamController.sink;
  Stream<List<dynamic>> get stream =>_streamController.stream;
  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

}
