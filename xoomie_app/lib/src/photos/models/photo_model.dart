import 'package:xoomie/src/base/models/model_base.dart';
import 'package:xoomie/src/photos/models/photo_links_model.dart';
import 'package:xoomie/src/photos/models/photo_urls_model.dart';
import 'package:xoomie/src/photos/models/photo_user_model.dart';

class PhotoModel extends ModelBase {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int width;
  final int height;
  final String? color;
  final String blurHash;
  final int likes;
  final bool likedByUser;
  final String? description;
  final PhotoUserModel user;
  final PhotoUrlsModel urls;
  final PhotoLinksModel links;

  PhotoModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.likes,
    required this.likedByUser,
    required this.description,
    required this.user,
    required this.urls,
    required this.links,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        width,
        height,
        color,
        blurHash,
        likes,
        likedByUser,
        description,
        user,
        urls,
        links,
      ];

  PhotoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        width = json['width'],
        height = json['height'],
        color = json['color'],
        blurHash = json['blur_hash'],
        likes = json['likes'],
        likedByUser = json['liked_by_user'],
        description = json['description'],
        user = PhotoUserModel.fromJson(json['user']),
        urls = PhotoUrlsModel.fromJson(json['urls']),
        links = PhotoLinksModel.fromJson(json['links']);
}
