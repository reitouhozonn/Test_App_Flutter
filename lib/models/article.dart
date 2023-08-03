import 'package:test_app/models/user.dart';

class Article {
  Article({
    required this.title,
    required this.user,
    this.likesCount = 0,
    this.tags = const [],
    required this.createdAt,
    required this.url,
  });

  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  final DateTime createdAt;
  final String url;

  factory Article.formJson(dynamic json) {
    return Article(
      title: json['title'] as String,
      user: User.formJson(json['user']),
      url: json['url'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likesCount: json['likesCount'] as int,
      tags: List<String>.from(json['tags'].map((tag) => tag['name'])),
    );
  }
}
