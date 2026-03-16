import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Set<int> _expanded = {};
  final int _subjectCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _placeholder(
                      height: 52,
                      header: 'UPCOMING',
                      label: 'Room 204 · 1h 23m',
                      align: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _placeholder(
                    width: 64,
                    height: 52,
                    header: 'BAL.',
                    label: '-\$485',
                  ),
                  const SizedBox(width: 8),
                  _placeholder(
                    width: 64,
                    height: 52,
                    header: 'GPA',
                    label: '3.74',
                  ),
                  const SizedBox(width: 8),
                  _placeholder(
                    width: 64,
                    height: 52,
                    header: 'AVG',
                    label: '84/B+',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(
                  40,
                  (_) => Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(_subjectCount, (i) => _subjectRow(i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subjectRow(int index) {
    final isExpanded = _expanded.contains(index);
    return GestureDetector(
      onTap: () => setState(() {
        if (isExpanded) {
          _expanded.remove(index);
        } else {
          _expanded.add(index);
        }
      }),
      child: Column(
        children: [
          _placeholder(
            height: 44,
            label: 'Subject $index · 84/100  ${isExpanded ? '▲' : '▼'}',
            align: TextAlign.left,
          ),
          if (isExpanded) ...[
            const SizedBox(height: 2),
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Column(
                children: [
                  _componentRow(
                    name: 'Homework',
                    scores: ['3/5', '2/5', '0/5'],
                    sum: '5/15',
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _componentRow(name: 'Midterm', scores: [], sum: '28/40'),
                  const Divider(height: 1, color: Colors.grey),
                  _componentRow(name: 'Final', scores: [], sum: '24/20'),
                ],
              ),
            ),
          ],
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _componentRow({
    required String name,
    required List<String> scores,
    required String sum,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: scores.length > 1
                  ? scores
                        .map(
                          (s) => Text(
                            s,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        )
                        .toList()
                  : [],
            ),
          ),
          Container(width: 1, height: 14, color: Colors.grey),
          const SizedBox(width: 8),
          SizedBox(
            width: 48,
            child: Text(
              sum,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder({
    required double height,
    required String label,
    double? width,
    String? header,
    TextAlign align = TextAlign.center,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Column(
        crossAxisAlignment: align == TextAlign.left
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (header != null)
            Text(
              header,
              style: TextStyle(color: Colors.grey[500], fontSize: 10),
            ),
          Expanded(
            child: Align(
              alignment: align == TextAlign.left
                  ? Alignment.centerLeft
                  : Alignment.center,
              child: Text(
                label,
                textAlign: align,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
