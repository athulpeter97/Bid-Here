import 'package:flutter/material.dart';

class DateRangeWidget extends StatefulWidget {
  const DateRangeWidget({Key? key}) : super(key: key);

  @override
  State<DateRangeWidget> createState() => _DateRangeWidgetState();
}

class _DateRangeWidgetState extends State<DateRangeWidget> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(2022, 07, 01),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final difference =
        dateRange.duration; // to set number of days left to bid for a product
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              pickDateRange();
            },
            child:
                Text('Start On: ${start.day}/${start.month}/${start.year}'),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              pickDateRange();
            },
            child: Text('End On: ${end.day}/${end.month}/${end.year}'),
          ),
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) {
      return null; //pressed cancel
    } else {
      setState(() {
        dateRange = newDateRange; //pressed ok
      });
    }
  }
}
