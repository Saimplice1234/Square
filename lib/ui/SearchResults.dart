import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:square_app_film/blocs/SearchResultsBloc.dart';

class SearchResults extends StatelessWidget {
  SearchResultsBloc bloc =SearchResultsBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:bloc.stream, builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      print(snapshot.data);
      return Container();
    },
    );
  }
}



