import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:more_complicated_tours_list/model/tour.dart';
import 'package:more_complicated_tours_list/screen/tours.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class TourProvider extends StateNotifier<List<Tour>> {
  TourProvider() : super([]);

  void init() async {
    final response =
        await http.get('https://course-api.com/react-tours-project');
    Iterable _list = await json.decode(response?.body);
    state = _list.map((tour) => Tour.fromJson(tour)).toList();
  }

  void removeTour(Tour target) {
    state = state.where((e) => e.id != target.id).toList();
  }
}

final tourProvider = StateNotifierProvider((ref) => TourProvider()..init());

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    List<Tour> _tours = watch(tourProvider.state);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Tour List'),
          ),
          body: Center(
              child: _tours.isEmpty
                  ? Column(
                      children: <Widget>[
                        Text('No tours left', style: TextStyle(fontSize: 24)),
                        FlatButton.icon(
                          icon: Icon(Icons.add),
                          label: Text('Refresh'),
                          onPressed: () {
                            context.read(tourProvider).init();
                          },
                        )
                      ],
                    )
                  : TourList())),
    );
  }
}
