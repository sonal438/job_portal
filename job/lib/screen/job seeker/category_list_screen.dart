import 'package:flutter/material.dart';
import 'job_list_page.dart';

class CategoryListScreen extends StatelessWidget {
  CategoryListScreen({super.key});

  final List<Map<String, dynamic>> categories = [
    {'title': 'Education', 'icon': Icons.menu_book},
    {'title': 'Health', 'icon': Icons.favorite},
    {'title': 'IT & Computer', 'icon': Icons.computer},
    {'title': 'Business', 'icon': Icons.business},
    {'title': 'Technical', 'icon': Icons.settings},
    {'title': 'Transport', 'icon': Icons.local_shipping},
    {'title': 'Hospitality', 'icon': Icons.apartment},
    {'title': 'Domestic', 'icon': Icons.home},
    {'title': 'Agriculture', 'icon': Icons.agriculture},
    {'title': 'Engineering', 'icon': Icons.engineering},
    {'title': 'Sales & Marketing', 'icon': Icons.campaign},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            childAspectRatio: 4,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        JobListPage(category: categories[index]['title']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      categories[index]['icon'],
                      size: 24,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      categories[index]['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
