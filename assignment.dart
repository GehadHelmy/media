import 'package:flutter/material.dart';
import 'package:media_module/assignments_details/details.dart';

class AssignmentWidget extends StatefulWidget {
  @override
  _AssignmentWidgetState createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  List Assignment = [
    {'title': 'Rational Numbers',
      'dueDate': DateTime(2024, 09, 18),
      'submitted': true,
    },
    {
      'title': 'Numbers',
      'dueDate': DateTime(2024, 09, 18),
      'submitted': false,
      'description':
          'Whole Numbers, Fraction, Decimals, Percentage, Ratio, Time. Measurement. Geometry, Deita Analysis, Algebra, Speed',
    },
    {
      'title': 'Crep Production & Mgt.',
      'dueDate': DateTime(2024, 09, 20),
      'submitted': false,
      'teacher': 'Dege Lafi',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount:Assignment.length,
        itemBuilder: (context, index) {
          final assignment = Assignment[index];
          return AssignmentCard(Assignment: assignment);
        },
      ),
    );
  }
}

class AssignmentCard extends StatelessWidget {
  final Assignment;

  const AssignmentCard({required this.Assignment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Assignment['title'],
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (Assignment['dueDate'] != null)
              Text(
                'Due: ${Assignment['dueDate']}',
                style: const TextStyle(color: Colors.grey),
              ),
            if (Assignment['description'] != null)
              Text(Assignment['description']!,maxLines: 2,),
            if (Assignment['teacher'] != null)
              Text('Teacher: ${Assignment['teacher']}'),
            MaterialButton(
              child:const Text('Read more..'),
              onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AssignmentDetails(data:Assignment,)));
            }),  
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (Assignment['submitted'])
                  const Chip(
                    label: Text('Submitted'),
                    backgroundColor: Colors.green,
                  ),
                if (!Assignment['submitted'])
                  Text('Days Left: ${calculateDaysLeft(Assignment['dueDate'])}'),
              ],
            ),
          ],
        ),
      ),
    );
  }


  int calculateDaysLeft(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now);
    return difference.inDays;
  }
}
