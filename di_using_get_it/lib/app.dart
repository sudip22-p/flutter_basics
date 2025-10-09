import 'package:flutter/material.dart';
import 'locator.dart';

class DependencyWidget extends StatelessWidget {
  const DependencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var myService = locator<MyService>();
    myService.doSomething();

    return Center(child: Text('Service has been called!'));
  }
}
