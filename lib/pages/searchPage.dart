import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> _allMeals = const [
    {
      'title': 'Spicy Arrabiata Penne',
      'cuisine': 'Italian',
      'image': 'assets/images/george-zheng-0Kbjfwunink-unsplash1(1).png',
    },
    {
      'title': 'Spicy Penne',
      'cuisine': 'Italian',
      'image': 'assets/images/SpicyPenne.png',
    },
  ];

  final List<String> _recentSearches = const ['Greek', 'Italian', 'Chicken'];
  final List<String> _popularSearches = const ['Greek', 'Chicken', 'Beef'];

  // Track whether the user has confirmed a search (tapped a
  // suggestion) so we know whether to show suggestions or results.
  String? _confirmedQuery;

  List<Map<String, String>> get _filteredMeals {
    final query = (_confirmedQuery ?? _controller.text).toLowerCase();
    if (query.isEmpty) return [];
    return _allMeals
        .where((meal) => meal['title']!.toLowerCase().contains(query))
        .toList();
  }

  void _selectSuggestion(String value) {
    setState(() {
      _controller.text = value;
      _confirmedQuery = value;
    });
  }

  Widget _buildSearchChip(String label) {
    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      onPressed: () => _selectSuggestion(label),
    );
  }

  Widget _buildPopularChip(String label) {
    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.trending_up, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      onPressed: () => _selectSuggestion(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTyping = _controller.text.isNotEmpty && _confirmedQuery == null;
    final showResults = _confirmedQuery != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for Meal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Find meals by name, country, ingredient or category.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => setState(() {
                          _controller.clear();
                          _confirmedQuery = null;
                        }),
                      )
                    : null,
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => setState(() {
                          _controller.clear();
                          _confirmedQuery = null;
                        }),
                      )
                    : const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() => _confirmedQuery = null),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: showResults
                  ? _buildResults()
                  : isTyping
                  ? _buildSuggestions()
                  : _buildRecentAndPopular(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAndPopular() {
    return ListView(
      children: [
        const Text(
          'Recent Searches',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _recentSearches.map(_buildSearchChip).toList(),
        ),
        const SizedBox(height: 20),
        const Text(
          'Popular Searches',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _popularSearches.map(_buildPopularChip).toList(),
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    final query = _controller.text.toLowerCase();
    final suggestions = _allMeals
        .map((m) => m['title']!)
        .where((title) => title.toLowerCase().contains(query))
        .toList();

    return ListView(
      children: suggestions
          .map(
            (suggestion) => ListTile(
              leading: const Icon(Icons.search),
              title: Text(suggestion),
              onTap: () => _selectSuggestion(suggestion),
            ),
          )
          .toList(),
    );
  }

  Widget _buildResults() {
    final results = _filteredMeals;
    if (results.isEmpty) {
      return const Center(child: Text('No meals found.'));
    }
    return ListView(
      children: [
        const Text(
          'Search Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...results.map(
          (meal) => Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  meal['image']!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        meal['cuisine']!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Suggested Meals',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 18,
            childAspectRatio: 0.72,
          ),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final meal = results[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      meal['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.restaurant),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  meal['title']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  meal['cuisine']!,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
