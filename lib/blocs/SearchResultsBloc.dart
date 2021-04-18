import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:square_app_film/Repositories/Repository.dart';
import 'package:square_app_film/blocs/bloc.dart';

class SearchResultsBloc extends Bloc{
  // ignore: non_constant_identifier_names, missing_return
  // ignore: non_constant_identifier_names
  String text;
  SearchResultsBloc(){
    GetResults(text);
  }
  Future GetResults(String q) async{
    try {
      var response = await Dio().get('https://api.themoviedb.org/3/search/movie?query=$q&api_key=${Repository.apiKey}');
      sink.add(response.data["results"]);
      Dio().close(force:true);
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
