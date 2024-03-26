import 'package:coba/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';
import '../widgets/card_article.dart';

class PersonListPage extends StatelessWidget {
  const PersonListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == PersonState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == PersonState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.result.length,
            itemBuilder: (context, index) {
              var result1 = state.result.result[index];
              return CardArticle(result: result1);
            },
        );
        } else if (state.state == PersonState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == PersonState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu 2'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Menu 2'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
