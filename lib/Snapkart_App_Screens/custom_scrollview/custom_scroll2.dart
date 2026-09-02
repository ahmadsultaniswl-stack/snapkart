import 'package:flutter/material.dart';

class CustomScroll2 extends StatelessWidget {
  const CustomScroll2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text("Product"),
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Featured Banner",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Card(
                color: Colors.red,
                elevation: 10,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEpw-OoUoPk2SGlk4KQra-5bm2CqE0s8twJw&s",
                  fit: BoxFit.cover,
                ),
              ),
              childCount: 10,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text("item ${index + 9}")),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
