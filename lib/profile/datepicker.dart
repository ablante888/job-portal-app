import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  DateFormField(
      {required this.label,
      required this.initialDate,
      required this.onDateSelected});

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select date',
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null) {
                return 'Please select a date';
              }
              return null;
            },
            onTap: () async {
              final DateTime date = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ) as DateTime;

              if (date != null) {
                setState(() {
                  _selectedDate = date;
                });
                //widget.onDateSelected(_selectedDate);
              }
            },
            controller: TextEditingController(
                text: _selectedDate == null
                    ? ''
                    : DateFormat.yMMMMd().format(_selectedDate)),
          ),
          SizedBox(height: 10),
          Text(
            _formKey.currentState?.validate() == true
                ? ''
                : 'Please select a date',
            style: TextStyle(
              color: Theme.of(context).errorColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
