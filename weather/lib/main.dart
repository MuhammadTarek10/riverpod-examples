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
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

extension OptionalAddOperator<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    return (shadow != null) ? shadow + (other ?? 0) as T : null;
  }
}

enum City { stockholm, paris, tokyo, pressForError }

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockholm: "🌬️",
      City.paris: "🌧️",
      City.tokyo: "🧊",
    }[city]!,
  );
}

// * UI Reads/Wirtes this
final currentCityProvier = StateProvider<City?>(
  (ref) => null,
);

// * UI Reads this
final weatherProvder = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvier);
  if (city != null) {
    return getWeather(city);
  } else {
    return "No Emoji";
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvder);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Text(
              data,
              style: const TextStyle(
                fontSize: 60,
              ),
            ),
            error: (error, stackTrace) => const Text("Error"),
            loading: () => const Padding(
              padding: EdgeInsets.all(15),
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSlected = city == ref.watch(currentCityProvier);
                return ListTile(
                  title: Text(city.name),
                  trailing: isSlected ? const Icon(Icons.check) : null,
                  onTap: () => ref
                      .read(
                        currentCityProvier.notifier,
                      )
                      .state = city,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
