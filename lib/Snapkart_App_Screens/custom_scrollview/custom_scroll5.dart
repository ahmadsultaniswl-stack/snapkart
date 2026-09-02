import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomScroll5 extends StatelessWidget {
  const CustomScroll5({super.key});

  @override
  Widget build(BuildContext context) {
    final RxList<String> _items = List.generate(
      320,
      (index) => 'item $index',
    ).obs;
    Future<void> _refreshData() async {
      await Future.delayed(Duration(seconds: 2));
      _items.add('new items ${_items.length}');
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("pull to refresh"),
              floating: true,
              pinned: false,
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    title: Text(_items[index]),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
