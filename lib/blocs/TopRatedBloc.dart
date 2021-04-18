import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:square_app_film/Repositories/Repository.dart';
import 'package:square_app_film/blocs/bloc.dart';

class TopRatedBloc extends Bloc{

  TopRatedBloc(){
    FetchTopRated();
  }
  // ignore: non_constant_identifier_names, missing_return
  Future  FetchTopRated() async{
    String apiKey="5a22ca1afa8beb22c1df45a5b1dd9f04";
    try {
      var response = await Dio().get('https://api.themoviedb.org/3/movie/top_rated?api_key=${Repository.apiKey}&language=en-US&pag');
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
