import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'search_result.dart';

class SearchScreen extends StatefulWidget {
  static const String route = "/search_screen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const int historyLength = 5;
  List<String> _searchHistory = [
    // 'oil',
    // 'meat',
    // 'fish',
    // 'sphagite',
    // 'tomato',
  ];
  List<String> filteredSearchHistory;
  String selectedTerm;
  List<String> filterSearchTerm({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
//   if term exist add it as first item in searchTerm list
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filterSearchTerm(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerm(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  final controller = FloatingSearchBarController();
  @override
  void initState() {
    super.initState();

    filteredSearchHistory = filterSearchTerm(filter: null);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? AppLocale.of(context).getString('searchTitle'),
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: AppLocale.of(context).getString('searchTitle'),
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerm(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          Provider.of<ProductProvider>(context, listen: false)
              .search(selectedTerm, 1, 100);
          controller.close();
        },
        body: FloatingSearchBarScrollNotifier(
          child: Container(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: SearchResultListView(
              searchTerm: selectedTerm,
            ),
          ),
        ),
        builder: (BuildContext context, Animation<double> transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(builder: (context) {
                if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                  return Container(
                    width: double.infinity,
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocale.of(context).getString('startSearch'),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(controller.query),
                    leading: Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTerm(controller.query);
                        selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(Icons.history),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTermFirst(term);
                                selectedTerm = term;
                              });
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .search(selectedTerm, 1, 100);
                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              }),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
 
}
