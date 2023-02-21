import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const userIsLoggedIn = false;
    final router = GoRouter(
      routes: [
        GoRoute(
          name: "login",
          path: "/",
          builder: (context, state) {
            return const LoginScreen();
          },
          redirect: (context, state) {
            if (userIsLoggedIn == false) {
              return "/";
            }
            return '/home';
          },
        ),
        GoRoute(
            path: "/home",
            name: "home",
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                name: "settings",
                path: "settings/:name",
                builder: (context, state) {
                  return SettingsPage(name: state.params["name"]!);
                },
              ),
            ],
            redirect: (context, state) {
              if (userIsLoggedIn == false) {
                return "/";
              }
              return null;
            }),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );

    return MaterialApp.router(
      routerConfig: router,
      title: "Go router",
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strona Główna"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.goNamed("settings", params: {
              "name": "codemagic"
            }, queryParams: {
              "email": "example@gmail.com",
              "age": "25",
              "place": "India"
            });
          },
          child: const Text('Przejdź do ustawień'),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Ustawienia: $name"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.goNamed("home");
          },
          child: const Text('Wróć do strony głównej'),
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/"),
          child: const Text("Strona Główna"),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Witaj, zaloguj się"),
      ),
      body: const Center(
        child: Text("Nie jesteś zalogowany"),
      ),
    );
  }
}
