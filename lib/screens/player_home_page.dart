import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playerline/bloc/player/player_bloc.dart';

import '../model/player_data_response.dart';
import '../widgets/list_item_widget.dart';

class PlayerListHomePage extends StatefulWidget {
  const PlayerListHomePage({Key? key}) : super(key: key);

  @override
  State<PlayerListHomePage> createState() => _PlayerListHomePageState();
}

class _PlayerListHomePageState extends State<PlayerListHomePage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late TabController _tabController;
  final List<Tab> tabList = const <Tab>[
    Tab(text: 'ALL NEWS'),
    Tab(text: 'FOLLOWING'),
    Tab(text: 'RESOURCE CENTER'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onReachedBottom);
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(onReachedBottom)
      ..dispose();
    super.dispose();
  }

  void onReachedBottom() {
    if (_bottomReached) context.read<PlayerBloc>().add(FetchEvent());
  }

  Widget getEmptyWidget() {
    return const Center(
        child: Text(
      "There are no data available.",
      style:
          TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'poppins'),
      textAlign: TextAlign.center,
    ));
  }

  bool get _bottomReached {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1A1A1A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
                child: DropdownButton(
                    iconDisabledColor: const Color(0xFF71b346),
                    iconEnabledColor: const Color(0xFF71b346),
                    hint: const Text("NFL",
                        style:
                            TextStyle(color: Color(0xFF71b346), fontSize: 24)),
                    value: "NFL",
                    items: [],
                    onChanged: null)),
            const Text(
              "News",
              style: TextStyle(fontSize: 28),
            ),
          ],
        ),
        bottom: TabBar(
          indicatorColor: const Color(0xFF71b346),
          controller: _tabController,
          tabs: tabList,
          isScrollable: true,
        ),
        actions: const [
          Icon(
            Icons.blur_linear_sharp,
            size: 30,
            color: Color(0xFF71b346),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              size: 30,
              color: Color(0xFF71b346),
            ),
          ),
        ],
      ),
      drawer: Drawer(backgroundColor: Colors.white, child: Container()),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocBuilder<PlayerBloc, PlayerListState>(
            builder: (context, state) {
              switch (state.fetchingStatus) {
                case FetchingStatus.failure:
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Text(
                          "Error in fetching data. Check your internet connection",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white //darkGreen
                                )),
                        onPressed: () =>
                            context.read<PlayerBloc>().add(FetchEvent()),
                        child: const Text(
                          "Retry",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    ],
                  ));
                case FetchingStatus.success:
                case FetchingStatus.loading:
                  if (state.playerList.isEmpty) {
                    return getEmptyWidget();
                  }
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.playerList.length
                          ? state.reachedMaxLimit
                              ? Container()
                              : const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: Color(0xFF71b346)),
                                    ),
                                  ),
                                )
                          : ListItemWidget(player: state.playerList[index]);
                    },
                    itemCount: state.reachedMaxLimit
                        ? state.playerList.length
                        : state.playerList.length + 1,
                    controller: _scrollController,
                  );
                case FetchingStatus.initial:
                  return const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF71b346)));
              }
            },
          ),
          getEmptyWidget(),
          getEmptyWidget()
        ] /*tabList.map((tab) {
          return Text("");
        }).toList()*/
        ,
      ),
    );
  }
}
