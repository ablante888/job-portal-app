import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  _buildSkillChips(List<String> skills, String category) {
    return [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              category,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          InputChip(
            label: Text('Add Skill'),
            onPressed: () => _showAddSkillDialog(skills),
          ),
          Wrap(
            children: [
              ...skills.map((skill) {
                return InputChip(
                  label: Text(skill),
                  onDeleted: () => setState(() => skills.remove(skill)),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    ];
  }

  List<String> programmingSkills = [];
  List<String> designSkills = [];
  List<String> languageSkills = [];

  _showAddSkillDialog(List<String> skills) {
    String newSkill = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Skill'),
          content: TextField(
            onChanged: (value) => newSkill = value,
            decoration: InputDecoration(hintText: 'Enter new skill'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() => skills.add(newSkill));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('try'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            spacing: 8.0, // space between each chip
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      ..._buildSkillChips(
                          programmingSkills, 'Programming Skills'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ..._buildSkillChips(designSkills, 'Design Skills'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ..._buildSkillChips(languageSkills, 'Language Skills'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
