import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PageAllSongs extends StatelessWidget {
  const PageAllSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(itemBuilder: (ctx, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 3,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                   
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            title: Text('Song name'),
            subtitle: Text('artist'),
          ),
        );
      }),
    );
  }
}
