import 'package:ass1/features/day_report/logic/day_report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayReportView extends StatefulWidget {
  const DayReportView({super.key});

  @override
  State<DayReportView> createState() => _DayReportViewState();
}

class _DayReportViewState extends State<DayReportView> {
  @override
  void initState() {
    super.initState();
    context.read<DayReportCubit>().loadDayReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day Report')),
      body: BlocBuilder<DayReportCubit, DayReportState>(
        builder: (context, state) {
          if (state is DayReportLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DayReportError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading report',
                    style: TextStyle(fontSize: 18, color: Colors.red[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<DayReportCubit>().refreshReport(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final cubit = context.read<DayReportCubit>();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards
                _buildSummarySection(cubit),
                const SizedBox(height: 24),
          
                // Popular Drinks Section
                _buildPopularDrinksSection(cubit),
                const SizedBox(height: 24),
          
                // Recent Orders Section
                _buildRecentOrdersSection(cubit),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummarySection(DayReportCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Summary',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                title: 'Total Income',
                value: '\$${cubit.totalIncome.toStringAsFixed(2)}',
                icon: Icons.attach_money,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                title: 'Items Served',
                value: '${cubit.totalInvoicesServed}',
                icon: Icons.local_cafe,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                title: 'Completed Orders',
                value: '${cubit.servedInvoicesCount}',
                icon: Icons.check_circle,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                title: 'Pending Orders',
                value: '${cubit.pendingInvoicesCount}',
                icon: Icons.pending,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDrinksSection(DayReportCubit cubit) {
    final popularDrinks = cubit.popularDrinks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Drinks',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: popularDrinks.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.local_cafe, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No drinks served yet',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: popularDrinks.entries.take(5).map((entry) {
                    final isFirst = popularDrinks.entries.first == entry;
                    return _buildPopularDrinkItem(
                      entry.key.name,
                      entry.value,
                      entry.key.price,
                      isFirst,
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildPopularDrinkItem(
    String name,
    int quantity,
    double price,
    bool isTop,
  ) {
    return ListTile(
      leading: isTop
          ? Icon(Icons.emoji_events, color: Colors.amber[700], size: 24)
          : const SizedBox(width: 24),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('\$${price.toStringAsFixed(2)} each'),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '$quantity sold',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection(DayReportCubit cubit) {
    final recentOrders = cubit.recentServedInvoices;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Completed Orders',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: recentOrders.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No completed orders yet',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: recentOrders
                      .map((invoice) => _buildRecentOrderItem(invoice))
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildRecentOrderItem(invoice) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.check, color: Colors.green[700]),
      ),
      title: Text(
        'Invoice #${invoice.id} - ${invoice.customerName}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('${invoice.orders.length} items'),
      trailing: Text(
        '\$${invoice.totalAmount.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
