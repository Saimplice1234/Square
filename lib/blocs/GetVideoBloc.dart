import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:square_app_film/Repositories/Repository.dart';
import 'package:square_app_film/blocs/bloc.dart';

class GetVideoBloc extends Bloc{
  // ignore: non_constant_identifier_names, missing_return

  final _streamController=BehaviorSubject<String>();
  Sink<String> get sink =>_streamController.sink;
  Stream<String> get stream =>_streamController.stream;

  Future GetVideo(String idMovie) async{
    try {
      var response = await Dio().get('https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=${Repository.apiKey}&language=en-US');
      sink.add(response.data["results"][0]['key']);
      await Dio().close(force:true);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

}
