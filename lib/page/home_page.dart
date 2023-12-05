import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Summary",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(
            //   width: 180,
            // ),
            RawMaterialButton(
              onPressed: () {
                print("click user");
              },
              elevation: 2.0,
              fillColor: Colors.green,
              child: Icon(
                Icons.face,
                size: 20.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 5,
              color: Colors.white,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
                color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
