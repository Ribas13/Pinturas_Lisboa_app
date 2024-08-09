import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'main.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      body: Padding(
              padding: const EdgeInsets.all(10),
              child: Container( //will set the max height 
              //as 2 or 3 smaller job cards representing the query,
              //if the result takes less space, use less space for the container
              //
                width: double.infinity,
                //height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Search jobs...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    Container(
                      height: 300,
                      color: Colors.white,
                      child: ListView(
                        children: [
                          Container(
                            height: 100,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: Text('Job 1'),
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: Text('Job 2'),
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: Text('Job 3'),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  AppBar buildAppBar() {
      return AppBar(
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 12, 96, 165),
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 30),
                  child: Image.asset('assets/pinturas_lisboa.png', width: 100),
                )
              ],
            );
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              print("\n\n-------\nsettings pressed\n\n-------\n");
            },
          )
        ],
      );
    }
}