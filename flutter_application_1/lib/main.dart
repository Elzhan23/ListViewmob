import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListView',
      home: Scaffold(
        appBar: AppBar(title: Text('Building List View')),
        body: BodyListView(),
      ),
    );
  }
}

class BodyListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyListViewState();
}

class _BodyListViewState extends State<BodyListView> {
  List<bool> checked = List.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    return _myListView();
  }

  Widget _myListView() {
    final List<ListItem> items = List<ListItem>.generate(
      100,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', ('MessageItem $i')),
    );
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is HeadingItem) {
          return ListTile(
            title: Text(
              item.heading,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        } else if (item is MessageItem) {
          return ListTile(
            title: Text(item.sender),
            subtitle: Text(item.body),
            leading: Checkbox(
              value: checked[index],
              onChanged: (value) {
                setState(() {
                  checked[index] = value!;
                });
              },
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        }

        return SizedBox();
      },
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
