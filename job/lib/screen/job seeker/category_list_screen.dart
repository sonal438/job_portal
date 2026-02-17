import 'package:flutter/material.dart';
import 'job_list_page.dart';
import 'jobseeker_dashboard_page.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const JobseekerDashboard()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final TextEditingController searchController =
                  TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Search Jobs'),
                    content: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Type keyword...',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final q = searchController.text.trim();
                          Navigator.pop(context);
                          if (q.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobListPage(
                                  category: 'All',
                                  searchQuery: q,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  );
                },
              );
            },
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
