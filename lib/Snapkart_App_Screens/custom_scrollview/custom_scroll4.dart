import 'package:flutter/material.dart';

class CustomScroll4 extends StatelessWidget {
  const CustomScroll4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: LayoutBuilder(
              builder: ((context, constraints) {
                return FlexibleSpaceBar(
                  title: Text("Parallax effect"),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        "https://picsum.photos/800/600",
                        fit: BoxFit.cover,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [Colors.orange, Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Content Item $index"),
                  ),
                ),
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
