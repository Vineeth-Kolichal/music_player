import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(CupertinoIcons.back)),
                    SizedBox(
                        width: size.width * 0.85,
                        child: CupertinoSearchTextField()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
