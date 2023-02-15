import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

@immutable
class Movie {
  final String id;
  final String title;
  final String description;
  final bool isFavourite;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavourite,
  });

  Movie copy({
    required bool isFavourite,
  }) =>
      Movie(
        id: id,
        title: title,
        description: description,
        isFavourite: isFavourite,
      );
  @override
  String toString() =>
      "Movie(id: $id, title: $title, description: $description, isFavourtie: $isFavourite)";

  @override
  bool operator ==(covariant Movie other) =>
      id == other.id && isFavourite == other.isFavourite;

  @override
  int get hashCode => Object.hashAll(
        [id, isFavourite],
      );
}

const movies = [
  Movie(
    id: "1",
    title: "Movie 1",
    description: "Desc 1",
    isFavourite: false,
  ),
  Movie(
    id: "2",
    title: "Movie 2",
    description: "Desc 2",
    isFavourite: false,
  ),
  Movie(
    id: "3",
    title: "Movie 3",
    description: "Desc 3",
    isFavourite: false,
  ),
  Movie(
    id: "4",
    title: "Movie 4",
    description: "Desc 4",
    isFavourite: false,
  ),
];

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier() : super(movies);

  void update(Movie movie, bool isFavourite) {
    state = state
        .map(
          (thisMovie) => thisMovie.id == movie.id
              ? thisMovie.copy(isFavourite: isFavourite)
              : thisMovie,
        )
        .toList();
  }
}

enum FavouriteStatus {
  all,
  favourite,
  notFavourite,
}

final favouriteStatusProvider = StateProvider<FavouriteStatus>(
  (_) => FavouriteStatus.all,
);

final movieProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(),
);

final favouriteMovieProvider = Provider<Iterable<Movie>>(
  (ref) => ref.watch(movieProvider).where((element) => element.isFavourite),
);

final notFavouriteMovieProvider = Provider<Iterable<Movie>>(
  (ref) => ref.watch(movieProvider).where((element) => !element.isFavourite),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favouriteStatusProvider);
              switch (filter) {
                case FavouriteStatus.all:
                  return MovieWidget(provider: movieProvider);
                case FavouriteStatus.favourite:
                  return MovieWidget(provider: favouriteMovieProvider);
                case FavouriteStatus.notFavourite:
                  return MovieWidget(provider: notFavouriteMovieProvider);
              }
            },
          )
        ],
      ),
    );
  }
}

class MovieWidget extends ConsumerWidget {
  const MovieWidget({
    required this.provider,
    super.key,
  });
  final AlwaysAliveProviderBase<Iterable<Movie>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies.elementAt(index);
          final favIcon = movie.isFavourite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.description),
            trailing: IconButton(
              icon: favIcon,
              onPressed: () {
                final isFavourite = !movie.isFavourite;
                ref.read(movieProvider.notifier).update(
                      movie,
                      isFavourite,
                    );
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favouriteStatusProvider),
          items: FavouriteStatus.values
              .map(
                (fs) => DropdownMenuItem(
                  value: fs,
                  child: Text(fs.toString().split(".").last),
                ),
              )
              .toList(),
          onChanged: (FavouriteStatus? fs) {
            ref
                .read(
                  favouriteStatusProvider.notifier,
                )
                .state = fs!;
          },
        );
      },
    );
  }
}
