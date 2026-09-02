import 'package:flutter/material.dart';

class CustomScroll3 extends StatelessWidget {
  const CustomScroll3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(title: Text("Sticky Section")),

          _buildStickyHeader('Ahmad'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text("item-1 $index")),
              childCount: 10,
            ),
          ),

          _buildStickyHeader('Bilal'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text("item-2 $index")),
              childCount: 15,
            ),
          ),

          _buildStickyHeader('Hassan'),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Card(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Stop%26Shop.jpg/250px-Stop%26Shop.jpg",
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        "Grid $index",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              childCount: 19,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyHeader(String title) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderDelegate(title: title),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  _StickyHeaderDelegate({required this.title});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  @override
  double get maxExtent => 50;
  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return title != oldDelegate.title;
  }
}
