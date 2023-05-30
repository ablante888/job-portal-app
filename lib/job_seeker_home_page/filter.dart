import 'package:flutter/material.dart';

class OverlayScreen extends StatefulWidget {
  final Function(String) callback;
  final List items;

  const OverlayScreen({super.key, required this.callback, required this.items});
  @override
  State<OverlayScreen> createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return
        //  backgroundColor: Colors.black54,
        // appBar: AppBar(title: Text('Filter')),

        AlertDialog(
      title: Text('Advanced Filter'),
      content: Text('This is the advanced filter screen.'),
      actions: [
        Container(
          height: 400,
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300, // Adjust the height as needed
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // seleceByCategory = true;
                            selectedValue = widget.items[index];
                            widget.callback(selectedValue);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.items[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.items.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
