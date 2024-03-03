import 'package:xoomie/src/base/models/model_base.dart';

class PhotoUserLinksModel extends ModelBase {
  final String self;
  final String html;
  final String photos;
  final String likes;
  final String portfolio;
  final String following;
  final String followers;

  PhotoUserLinksModel({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
    required this.following,
    required this.followers,
  });

  @override
  List<Object?> get props => [
        self,
        html,
        photos,
        likes,
        portfolio,
        following,
        followers,
      ];

  PhotoUserLinksModel.fromJson(Map<String, dynamic> json)
      : self = json['self'],
        html = json['html'],
        photos = json['photos'],
        likes = json['likes'],
        portfolio = json['portfolio'],
        following = json['following'],
        followers = json['followers'];
}
