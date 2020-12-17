import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:more_complicated_tours_list/main.dart';

import 'package:more_complicated_tours_list/model/tour.dart';

final isTruncatedProvider = StateProvider<bool>((ref) => true);

class TourList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Tour> _tours = watch(tourProvider.state);
    final bool isTruncated = watch(isTruncatedProvider).state;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _tours.length,
        itemBuilder: (BuildContext context, int index) {
          final tour = _tours[index];
          return Card(
              child: Column(children: [
            Image.network(tour.image),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(tour.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    tour.price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.lightBlue[200],
                        color: Colors.lightBlue[600]),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isTruncated
                        ? '${tour.info.substring(0, 200)}...'
                        : tour.info,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
                FlatButton.icon(
                    icon: Icon(isTruncated
                        ? Icons.arrow_downward
                        : Icons.arrow_upward),
                    label: Text(isTruncated ? 'Show More' : 'Show Less'),
                    onPressed: () {
                      context.read(isTruncatedProvider).state =
                          !context.read(isTruncatedProvider).state;
                    }),
              ],
            ),
            FlatButton.icon(
              icon: Icon(Icons.delete),
              label: Text('Not Interested'),
              onPressed: () {
                context.read(tourProvider).removeTour(tour);
                print(_tours);
              },
            )
          ]));
        });
  }
}
