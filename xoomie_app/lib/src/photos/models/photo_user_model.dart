import 'package:xoomie/src/base/models/model_base.dart';
import 'package:xoomie/src/photos/models/photo_user_links_model.dart';
import 'package:xoomie/src/photos/models/photo_user_profile_image_model.dart';

class PhotoUserModel extends ModelBase {
  final String id;
  final String username;
  final String? name;
  final String? portfolioUrl;
  final String? bio;
  final String? location;
  final int totalLikes;
  final int totalPhotos;
  final int totalCollections;
  final PhotoUserProfileImageModel profileImage;
  final PhotoUserLinksModel links;

  PhotoUserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.totalLikes,
    required this.totalPhotos,
    required this.totalCollections,
    required this.profileImage,
    required this.links,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        portfolioUrl,
        bio,
        location,
        totalLikes,
        totalPhotos,
        totalCollections,
        profileImage,
        links,
      ];

  PhotoUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        name = json['name'],
        portfolioUrl = json['portfolio_url'],
        bio = json['bio'],
        location = json['location'],
        totalLikes = json['total_likes'],
        totalPhotos = json['total_photos'],
        totalCollections = json['total_collections'],
        profileImage = PhotoUserProfileImageModel.fromJson(json['profile_image']),
        links = PhotoUserLinksModel.fromJson(json['links']);
}
