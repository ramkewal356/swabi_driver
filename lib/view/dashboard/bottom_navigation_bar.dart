import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Widget child;

  const CustomBottomNavigationBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    final Map<String, int> navIndexMap = {
      '/': 0,
      '/rentalManagement': 1,
      '/packageManagement': 2,
      '/user': 3,
    };

    int currentIndex = navIndexMap[location] ?? 0;

    final List<String> routes = [
      '/',
      '/rentalManagement',
      '/packageManagement',
      '/user',
    ];

    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async {
        final currentRoute = GoRouterState.of(context).uri.toString();

        if (currentRoute != '/') {
          context.go('/');
          return;
        }

        final exitApp = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Confirm Exit"),
            content: const Text("Are you sure you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text("Yes"),
              ),
            ],
          ),
        );
        if (exitApp == true) {
          exit(0);
        }
      },
      child: Scaffold(
        body: child,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff8A0B23),
                Color(0xff81001E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: currentIndex == 0 ? Colors.white : Colors.white70),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_rental,
                    color: currentIndex == 1 ? Colors.white : Colors.white70),
                label: 'Rental',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_travel,
                    color: currentIndex == 2 ? Colors.white : Colors.white70),
                label: 'Package',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: currentIndex == 3 ? Colors.white : Colors.white70),
                label: 'Account',
              ),
            ],
            onTap: (index) {
              if (routes[index] != location) {
                context.go(routes[index]);
              }
            },
          ),
        ),
      ),
    );
  }
}
