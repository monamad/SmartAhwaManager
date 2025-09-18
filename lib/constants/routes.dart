class AppRoutes {
  static const String home = '/';
  static const String addOrders = '/add-orders';
  static const String pendingOrders = '/pending-orders';
  static const String servedInvoices = '/served-invoices';
  static const String dailyReport = '/daily-report';
  static const String popularItems = '/popular-items';
  static const String dashboard = '/dashboard';
  static const String ordersList = '/orders-list';

  // Private constructor to prevent instantiation
  AppRoutes._();

  // Get all routes as a list (useful for validation)
  static List<String> get allRoutes => [
    home,
    addOrders,
    pendingOrders,
    dailyReport,
    popularItems,
    dashboard,
    ordersList,
  ];
}
