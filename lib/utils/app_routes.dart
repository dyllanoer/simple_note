import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/pages/add_note_screen.dart';
import 'package:simple_note/pages/home_screen.dart';

class AppRoutes {
  static const home = "home";
  static const addNote = "add-note";

  static Page homeScreenBuilder(
    BuildContext context, 
    GoRouterState state,
    ) {
    return const MaterialPage(
      child: HomeScreen(),
    );
  }

  static Page addNoteScreenBuilder(
    BuildContext context, 
    GoRouterState state,
    ) {
    return const MaterialPage(
      child: AddNoteScreen(),
    );
  }  

  final GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: home,
        path: "/",
        pageBuilder: homeScreenBuilder,
        routes: [
          GoRoute(
            name: addNote,
            path: "add-note",
            pageBuilder: addNoteScreenBuilder,
          ),
        ]
      ),
    ],
  );
}