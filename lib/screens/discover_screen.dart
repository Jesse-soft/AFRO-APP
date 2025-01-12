import 'package:afro_caribbean/widgets/image_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'article_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});
  static const routeName = '/discover';
  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'History',
      'Current Affairs',
      'Sports',
      'Entertainment',
      'Food',
      'Culture',
      'Politics',
      'Art',
      'Science',
      'Health'
    ];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Transform.scale(
            scale: 1.5,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.black,
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(index: 1),
        body: ListView(
          padding: const EdgeInsets.all(
            20.0,
          ),
          children: [
            const _DiscoverNews(),
            _CatergoryNews(
              tabs: tabs,
            ),
          ],
        ),
      ),
    );
  }
}

class _CatergoryNews extends StatelessWidget {
  const _CatergoryNews({
    required this.tabs,
    Key? key,
  }) : super(key: key);
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;
    return SingleChildScrollView(
      child: Column(
        children: [
          TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              tabs: tabs
                  .map(
                    (tab) => Tab(
                      icon: Text(
                        tab,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                  .toList()),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: tabs
                  .map(
                    (tab) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: ((
                        dynamic,
                        index,
                      ) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ArticleScreen.routeName,
                              arguments: articles[index],
                            );
                          },
                          child: Row(
                            children: [
                              ImageContainer(
                                width: 100,
                                height: 80,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                borderRadius: 0.1,
                                imageUrl: articles[index].imageUrl,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      articles[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.schedule,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                            '${DateTime.now().difference(articles[index].createdAt).inHours} hr',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 20),
                                        const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        ),
                                        Text(
                                          '${articles[index].views}views',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscoverNews extends StatelessWidget {
  const _DiscoverNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'News from all over the world',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.tune, color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
            ),
          )
        ],
      ),
    );
  }
}
