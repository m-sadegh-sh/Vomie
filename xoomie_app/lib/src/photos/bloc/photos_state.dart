import 'package:xoomie/src/base/bloc/state_base.dart';
import 'package:xoomie/src/base/widgets/localized_text.dart';
import 'package:xoomie/src/photos/models/photo_group_model.dart';

abstract class PhotosStateBase extends StateBase {
  const PhotosStateBase();
}

class PhotosInitialState extends PhotosStateBase {
  const PhotosInitialState();
}

class PhotosLoadingState extends PhotosStateBase {
  const PhotosLoadingState();
}

class PhotosLoadedState extends PhotosStateBase {
  late final List<PhotoGroupModel> groups;

  PhotosLoadedState(Iterable<PhotoGroupModel> groups) {
    this.groups = List.unmodifiable(groups);
  }

  @override
  List<Object?> get props => [groups];
}

class PhotosLoadFailedState extends PhotosStateBase {
  final GenerateLocalizedString? message;

  const PhotosLoadFailedState(this.message);

  @override
  List<Object?> get props => [message];
}
