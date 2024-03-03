import 'package:xoomie/src/base/bloc/event_base.dart';
import 'package:xoomie/src/photos/models/order_by.dart';

abstract class PhotosEventBase extends EventBase {
  const PhotosEventBase();
}

class PhotosLoadEvent extends PhotosEventBase {
  final int page;
  final int perPage;
  final OrderBy orderBy;

  const PhotosLoadEvent({
    this.page = 1,
    this.perPage = 10,
    this.orderBy = OrderBy.latest,
  });

  @override
  List<Object?> get props => [page, perPage, orderBy];
}
