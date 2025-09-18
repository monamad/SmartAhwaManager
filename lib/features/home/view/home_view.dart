import 'package:ass1/features/home/logic/home_controller.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller;
  const HomeView({super.key, required HomeController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home View')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.navigateToAddOrders(context);
              },
              child: const Text('Add Orders'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.navigateToPendingOrders(context);
              },
              child: const Text('View Pending Orders'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.showServedInvoices(context);
              },
              child: const Text('Served Invoices'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.showPopularItems(context);
              },
              child: const Text('Track Popular Items'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.showDailyReport(context);
              },
              child: const Text('generate daily sales reports'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
add orders with a customer name, drink
type (e.g., shai, Turkish coffee, hibiscus tea) and special instructions and mark orders as completed

view a dashboard of pending orders
track popular items

generate daily sales reports

 total orders served
*/
