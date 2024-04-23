import 'package:api_uses/product/services_post.dart';
import 'package:api_uses/product/services_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final double _notchedValue = 10;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _MyTabView.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _MyTabView.values.length,
        child: Scaffold(
          extendBody: true,
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_NumberValue().fabRadius))),
              child: const Icon(Icons.home),
              onPressed: () {
                _tabController.animateTo(_MyTabView.Home.index);
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: _notchedValue,
            child: _myTab(),
          ),
          body: _tabbarView(),
        ));
  }

  TabBarView _tabbarView() {
    return TabBarView(physics: const NeverScrollableScrollPhysics(), controller: _tabController, children: const [
      ServicesView(),
      ServicesPost(),
    ]);
  }

  TabBar _myTab() {
    return TabBar(
        padding: EdgeInsets.zero,
        controller: _tabController,
        tabs: _MyTabView.values.map((e) => Tab(text: e.name)).toList());
  }
}

enum _MyTabView { Home, Register }

class _NumberValue {
  final double fabRadius = 28;
}
