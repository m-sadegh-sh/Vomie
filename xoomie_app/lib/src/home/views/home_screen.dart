import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xoomie/src/base/screens/screen_base.dart';
import 'package:xoomie/src/base/widgets/default_transition_switcher.dart';
import 'package:xoomie/src/base/widgets/localized_text.dart';
import 'package:xoomie/src/base/widgets/message_box.dart';
import 'package:xoomie/src/base/widgets/region.dart';
import 'package:xoomie/src/base/widgets/shimmer.dart';
import 'package:xoomie/src/home/widgets/home_bottom_navigation_bar.dart';
import 'package:xoomie/src/photos/bloc/photos_bloc.dart';
import 'package:xoomie/src/photos/bloc/photos_state.dart';
import 'package:xoomie/src/photos/models/photo_group_model.dart';
import 'package:xoomie/src/photos/models/photo_model.dart';
import 'package:xoomie/src/router/bloc/router_bloc.dart';
import 'package:xoomie/src/router/bloc/router_state.dart';
import 'package:xoomie/src/router/models/home_contents.dart';
import 'package:xoomie/src/styling/variables.dart';

class HomeScreen extends ScreenBase {
  const HomeScreen({
    super.key,
  });

  @override
  Widget? appBarTitle(BuildContext context) {
    return BlocBuilder<RouterBloc, RouterStateBase>(
      builder: (_, state) => DefaultTransitionSwitcher(
        transitionType: SharedAxisTransitionType.horizontal,
        duration: animationDurationShort,
        child: _buildTitle(state),
      ),
    );
  }

  Widget _buildTitle(RouterStateBase state) {
    if (state is! RouterHomeState) {
      return Container();
    }

    switch (state.selectedContent) {
      case HomeContents.random:
        return LocalizedText(
          (x) => x.homeScreenRandomTitle,
          key: const ValueKey('random'),
        );
      case HomeContents.search:
        return LocalizedText(
          (x) => x.homeScreenSearchTitle,
          key: const ValueKey('search'),
        );
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocBuilder<RouterBloc, RouterStateBase>(
      builder: (_, state) => DefaultTransitionSwitcher(
        transitionType: SharedAxisTransitionType.horizontal,
        child: _buildContent(state),
      ),
    );
  }

  Widget _buildContent(RouterStateBase state) {
    if (state is! RouterHomeState) {
      return Container();
    }

    switch (state.selectedContent) {
      case HomeContents.random:
        return _HomeRandom();
      case HomeContents.search:
        return _HomeSearch();
    }
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) =>
      const HomeBottomNavigationBar();
}

class _HomeRandom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(paddingXLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LocalizedText(
                (x) => x.homeRandomPhotosTitle,
                style: textTheme.titleLarge,
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Icon(
                  Icons.sort,
                  size: iconSizeMedium,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: paddingSmall,
          ),
          LocalizedText(
            (x) => x.homeRandomPhotosDescription,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(
            height: paddingSmall,
          ),
          const Expanded(
            child: _PhotosContent(
              key: ValueKey("randomPhotos"),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotosContent extends StatelessWidget {
  const _PhotosContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosStateBase>(
      builder: (context, state) {
        if (state is PhotosLoadFailedState) {
          return MessageBox.error(
            message: state.message,
          );
        }

        if (state is PhotosLoadedState) {
          return _PhotoGroupList(
            groups: state.groups,
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class _PhotoGroupList extends StatelessWidget {
  final List<PhotoGroupModel> groups;

  const _PhotoGroupList({
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];

        return _PhotoGroup(
          key: ValueKey(group.date),
          group: group,
        );
      },
    );
  }
}

class _PhotoGroup extends StatelessWidget {
  final PhotoGroupModel group;

  const _PhotoGroup({
    required this.group,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Region.text(
          text: DateFormat.MMMEd().format(group.date),
          style: textTheme.bodySmall,
        ),
        _PhotoList(
          key: ValueKey(group.date),
          photos: group.photos,
        ),
      ],
    );
  }
}

class _PhotoList extends StatelessWidget {
  final List<PhotoModel> photos;

  const _PhotoList({
    required this.photos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];

        return _PhotoItem(
          key: ValueKey(photo.id),
          photo: photo,
        );
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(
          top: paddingMedium,
        ),
      ),
    );
  }
}

class _PhotoItem extends StatelessWidget {
  final PhotoModel photo;

  const _PhotoItem({
    required this.photo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusMedium),
      child: Stack(
        children: [
          Image.network(
            photo.urls.small,
            fit: BoxFit.cover,
            //frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => ,
            loadingBuilder: (_, widget, loadingProgress) {
              // if (loadingProgress == null) {
              //   return widget;
              // }

              return _PhotoItemShimmer();
            },
            errorBuilder: (_, __, ___) => const Text("a"),
            width: double.infinity,
            height: 220,
          ),
          Text(photo.id),
        ],
      ),
    );
  }
}

class _PhotoItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      builder: (context, child, decoration) => Container(
        decoration: decoration,
      ),
    );
  }
}

class _HomeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text("Search"),
      ],
    );
  }
}
