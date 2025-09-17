import 'package:flutter/material.dart';
import 'provider/provider_movies_tab.dart';
import 'riverpod/riverpod_movies_tab.dart';
import 'bloc/bloc_movies_tab.dart';
import 'getx/getx_movies_tab.dart';

class MainTabScaffold extends StatelessWidget {
  const MainTabScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TMDB State Managers'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Provider'),
              Tab(text: 'Riverpod'),
              Tab(text: 'BLoC'),
              Tab(text: 'GetX'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProviderMoviesTab(),
            RiverpodMoviesTab(),
            MovieBlocTab(),
            GetXMoviesTab(),
          ],
        ),
      ),
    );
  }
}
