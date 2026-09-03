import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  static const List<Map<String, dynamic>> _upcomingMeals = [
    {
      'date': 'Feb 18 Wednesday',
      'meals': [
        {
          'label': 'Starter',
          'title': 'Spicy Arrabiata Penne',
          'ingredients': '12 Ingredients',
        },
      ],
    },
    {
      'date': 'Feb 19 Thursday',
      'meals': [
        {
          'label': 'Starter',
          'title': 'Spicy Arrabiata Penne',
          'ingredients': '12 Ingredients',
        },
        {
          'label': 'Starter',
          'title': 'Spicy Arrabiata Penne',
          'ingredients': '12 Ingredients',
        },
      ],
    },
    {
      'date': 'Feb 20 Friday',
      'meals': [
        {
          'label': 'Starter',
          'title': 'Spicy Arrabiata Penne',
          'ingredients': '12 Ingredients',
        },
      ],
    },
    {
      'date': 'Feb 21 Saturday',
      'meals': [
        {
          'label': 'Starter',
          'title': 'Spicy Arrabiata Penne',
          'ingredients': '12 Ingredients',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Upcoming Meals',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          for (final day in _upcomingMeals) ...[
            Text(
              day['date'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const Divider(),
            for (final meal in (day['meals'] as List))
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/SpicyFood.png",
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey[300],
                      child: const Icon(Icons.restaurant),
                    ),
                  ),
                ),
                title: Text('${meal['label']}\n${meal['title'] as String}'),
                subtitle: Text(meal['ingredients']),
                isThreeLine: true,
              ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
