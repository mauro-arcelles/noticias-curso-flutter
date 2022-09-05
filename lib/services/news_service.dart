import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/category_model.dart';

import 'package:newsapp/models/news_models.dart';

class NewsService extends ChangeNotifier {
  final _baseUrl = "newsapi.org";
  final _apiKey = "100a1c5cb6684818bc230a5b6804944c";
  String _selectedCategory = "business";
  bool _isLoading = false;

  List<Article> headlines = [];
  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    _isLoading = true;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => categoryArticles[_selectedCategory] ?? [];

  getTopHeadlines() async {
    final url = Uri.https(_baseUrl, '/v2/top-headlines', {
      'country': 'us',
      'apiKey': _apiKey,
    });

    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      return categoryArticles[category];
    }

    final url = Uri.https(_baseUrl, '/v2/top-headlines', {
      'country': 'us',
      'apiKey': _apiKey,
      'category': category,
    });

    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    _isLoading = false;
    notifyListeners();
  }
}
