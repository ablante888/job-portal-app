import 'package:flutter/material.dart';

class OverlayScreen extends StatefulWidget {
  final Function(String, bool) callback;
  final List items;
  final IconData? icon;
  const OverlayScreen(
      {super.key,
      required this.callback,
      required this.items,
      required this.icon});
  @override
  State<OverlayScreen> createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  var selectedValue;
  bool itemSelected = false;
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
                            selectedValue = widget.items[index];
                            itemSelected = true;
                            widget.callback(selectedValue, itemSelected);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors
                                .blueAccent, // Change the color to your preference
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget
                                    .icon, // Add an icon or any other visual element
                                size: 40,
                                color: Colors.white, // Customize the icon color
                              ),
                              SizedBox(height: 8),
                              Text(
                                widget.items[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold, // Adjust the font weight
                                  color: Colors.white, // Change the text color
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
