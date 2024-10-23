import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key, required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            onPressed: widget.onBackPressed,
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text('Books Screen'),
      ),
      body: const Center(
        child: Text('Books Screen'),
      ),
    );
  }
}