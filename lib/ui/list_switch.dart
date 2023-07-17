import 'package:flutter/material.dart';
import 'package:widgetscomponent/widgets/item_label_switch.dart';

class ListSwitch extends StatelessWidget {
  const ListSwitch({super.key});

  static const String routeName = '/list_switch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Switch',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 70,
                child: ItemLabelSwitch(
                  labelText: 'Enabled $index',
                  stateSwitch: false,
                  widthFromLabelToSwitch: 30.0,
                  switchbackgroundactiveColor: Colors.pink[400],
                  switchbackgroundinactiveColor: Colors.grey[300],
                ),
              );
            },
          ),
        ));
  }
}
