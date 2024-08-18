import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itunes_media/modules/itunes_search/view/result_view/search_result_screen.dart';
import 'package:itunes_media/modules/itunes_search/view_model/itunes_search_view_model.dart';

class SearchMediaScreen extends ConsumerWidget {
  SearchMediaScreen({super.key});

  final searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isButtonEnabled = ref.watch(searchInputProvider).isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Icon(
                Icons.apple,
                size: 50.sp,
              ),
              Text(
                'iTunes',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0.01.sh),
              Text(
                'Search for a variety of content from the iTunes store including iBooks, movies, podcasts, music, music videos, and audiobooks.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 0.02.sh),
              TextField(
                controller: searchTextEditingController,
                onChanged: (text) {
                  ref.read(searchInputProvider.notifier).state = text;
                },
                decoration: InputDecoration(
                  hintText: 'Enter search term',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Specify the parameter for the content to be searched',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 0.02.sh),
              const Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text('album'),
                    backgroundColor: Colors.grey,
                  ),
                  Chip(
                    label: Text('movie'),
                    backgroundColor: Colors.grey,
                  ),
                  Chip(
                    label: Text('musicVideo'),
                    backgroundColor: Colors.grey,
                  ),
                  Chip(
                    label: Text('song'),
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: .04.sh),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        ref.read(iTunesSearchViewProvider.notifier).fetchItems(
                            searchTextEditingController.text.trim());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SearchResultScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.grey[800],
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
