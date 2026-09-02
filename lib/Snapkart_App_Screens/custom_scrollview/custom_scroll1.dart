import 'package:flutter/material.dart';

class CustomScroll1 extends StatelessWidget {
  const CustomScroll1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Custom Scroll View",
                style: TextStyle(color: Colors.blue[900]),
              ),
              background: Image.network(
                "https://media.istockphoto.com/id/1825147025/photo/financial-district-of-london.jpg?s=612x612&w=0&k=20&c=-AVvvRlce-ussXwMBfWP2Ls_ZAA7voCpd_4MvkVgyQE=",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text("Item $index"),
                leading: Icon(Icons.star, color: Colors.orange),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
