import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayReportView extends StatelessWidget {
  const DayReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Day Report'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final cubit = context.read<AppCubit>();
          return RefreshIndicator(
            onRefresh: () async {
              // Simple delay to simulate refresh
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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

                  // Pending Orders Summary
                  _buildPendingOrdersSection(cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummarySection(AppCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Summary',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildPopularDrinksSection(AppCubit cubit) {
    final popularDrinks = cubit.popularDrinks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Drinks',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: popularDrinks.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.local_cafe, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No drinks served yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
        color: isTop ? Colors.amber[50] : null,
      ),
      child: Row(
        children: [
          if (isTop)
            Icon(Icons.emoji_events, color: Colors.amber[700], size: 24)
          else
            Container(width: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${price.toStringAsFixed(2)} each',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
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
        ],
      ),
    );
  }

  Widget _buildRecentOrdersSection(AppCubit cubit) {
    final recentOrders = cubit.servedInvoices.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Completed Orders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: recentOrders.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No completed orders yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.check, color: Colors.green[700]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoice #${invoice.id} - ${invoice.customerName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${invoice.orders.length} items',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            '\$${invoice.totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingOrdersSection(AppCubit cubit) {
    final pendingCount = cubit.pendingInvoicesCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: pendingCount > 0 ? Colors.orange[50] : Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: pendingCount > 0 ? Colors.orange[200]! : Colors.green[200]!,
        ),
      ),
      child: Column(
        children: [
          Icon(
            pendingCount > 0 ? Icons.pending_actions : Icons.task_alt,
            size: 48,
            color: pendingCount > 0 ? Colors.orange[700] : Colors.green[700],
          ),
          const SizedBox(height: 12),
          Text(
            pendingCount > 0
                ? 'You have $pendingCount pending orders'
                : 'All orders completed! 🎉',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: pendingCount > 0 ? Colors.orange[800] : Colors.green[800],
            ),
            textAlign: TextAlign.center,
          ),
          if (pendingCount > 0) ...[
            const SizedBox(height: 8),
            Text(
              'Check the pending orders to complete them',
              style: TextStyle(fontSize: 14, color: Colors.orange[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
