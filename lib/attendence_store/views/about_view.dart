import 'package:flutter/material.dart';
import 'package:location_screen/themes/styles.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> members = [
      {
        'name': 'Umashankar',
        'detail': 'Mern Stack | AWS | Docker | OpenSource',
      },
      {
        'name': 'Bhavya',
        'detail': 'Mern Stack | Docker | Java',
      },
      {
        'name': 'Nandan',
        'detail': 'Mern Stack | Docker | C++',
      },
      {
        'name': 'Ganesh',
        'detail': 'Mern Stack | Automation | Java',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Styles.lightColorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name']!,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            member['detail']!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}