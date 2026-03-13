import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const SaaSAutomationApp(),
    ),
  );
}

class AppState extends ChangeNotifier {
  bool isSpanish = false;
  void toggleLanguage() {
    isSpanish = !isSpanish;
    notifyListeners();
  }
}

class SaaSAutomationApp extends StatelessWidget {
  const SaaSAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SaaS Automation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBB86FC),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/builder',
          builder: (context, state) => const BuilderPage(),
        ),
        GoRoute(
          path: '/integrations',
          builder: (context, state) => const IntegrationsPage(),
        ),
        GoRoute(
          path: '/logs',
          builder: (context, state) => const LogsPage(),
        ),
        GoRoute(
          path: '/templates',
          builder: (context, state) => const TemplatesPage(),
        ),
        GoRoute(
          path: '/pricing',
          builder: (context, state) => const PricingPage(),
        ),
        GoRoute(
          path: '/education',
          builder: (context, state) => const EducationPage(),
        ),
      ],
    ),
  ],
);

// --- Core UI Shell ---
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text('Automation SaaS'),
              actions: [
                IconButton(
                  icon: Icon(
                      appState.isSpanish ? Icons.language : Icons.g_translate),
                  onPressed: () => appState.toggleLanguage(),
                )
              ],
            ),
      drawer: isDesktop ? null : const AppSidebar(),
      body: Row(
        children: [
          if (isDesktop) const AppSidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.toString();
    final appState = context.watch<AppState>();

    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.auto_awesome,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'AutoSaaS',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _NavItem(
                    icon: Icons.dashboard,
                    label: appState.isSpanish ? 'Inicio' : 'Dashboard',
                    route: '/',
                    currentPath: currentPath),
                _NavItem(
                    icon: Icons.account_tree,
                    label: appState.isSpanish ? 'Flujos' : 'Builder',
                    route: '/builder',
                    currentPath: currentPath),
                _NavItem(
                    icon: Icons.extension,
                    label:
                        appState.isSpanish ? 'Integraciones' : 'Integrations',
                    route: '/integrations',
                    currentPath: currentPath),
                _NavItem(
                    icon: Icons.receipt_long,
                    label: appState.isSpanish ? 'Historial' : 'Logs',
                    route: '/logs',
                    currentPath: currentPath),
                _NavItem(
                    icon: Icons.copy,
                    label: appState.isSpanish ? 'Plantillas' : 'Templates',
                    route: '/templates',
                    currentPath: currentPath),
                const Divider(),
                _NavItem(
                    icon: Icons.school,
                    label: appState.isSpanish ? 'Aprender' : 'Education',
                    route: '/education',
                    currentPath: currentPath),
                _NavItem(
                    icon: Icons.shopping_cart,
                    label: appState.isSpanish ? 'Planes' : 'Pricing',
                    route: '/pricing',
                    currentPath: currentPath),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 8),
                const Text('EN / ES'),
                const Spacer(),
                Switch(
                  value: appState.isSpanish,
                  onChanged: (val) => appState.toggleLanguage(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final String currentPath;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentPath == route;
    return ListTile(
      leading: Icon(icon,
          color: isSelected ? Theme.of(context).colorScheme.primary : null),
      title: Text(label,
          style: TextStyle(
              color: isSelected ? Theme.of(context).colorScheme.primary : null,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      onTap: () => context.go(route),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
    );
  }
}

// --- Features ---

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appState.isSpanish ? 'Panel Principal' : 'Dashboard',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                    child: _StatCard(
                        title: appState.isSpanish
                            ? 'Total Automations'
                            : 'Total Automations',
                        value: '12')),
                const SizedBox(width: 16),
                Expanded(
                    child: _StatCard(
                        title: appState.isSpanish
                            ? 'Ejecuciones Hoy'
                            : 'Executions Today',
                        value: '1,240')),
                const SizedBox(width: 16),
                Expanded(
                    child: _StatCard(
                        title: appState.isSpanish ? 'Errores' : 'Errors',
                        value: '2',
                        isError: true)),
              ],
            ),
            const SizedBox(height: 32),
            Text(appState.isSpanish ? 'Actividad Reciente' : 'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                        x: 1,
                        barRods: [BarChartRodData(toY: 8, color: Colors.blue)]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 10, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 14, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(toY: 15, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 5, barRods: [
                      BarChartRodData(toY: 13, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 6, barRods: [
                      BarChartRodData(toY: 10, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 7, barRods: [
                      BarChartRodData(toY: 16, color: Colors.blue)
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isError;
  const _StatCard(
      {required this.title, required this.value, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isError ? Colors.red : Colors.black87)),
        ],
      ),
    );
  }
}

class BuilderPage extends StatelessWidget {
  const BuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Drag and Drop Builder UI goes here. (Mocked)')),
    );
  }
}

class IntegrationsPage extends StatelessWidget {
  const IntegrationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: ['Stripe', 'Slack', 'Mailchimp', 'Salesforce'].map((e) {
            return Container(
              padding: const EdgeInsets.all(24),
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  const Icon(Icons.api, size: 40),
                  const SizedBox(height: 16),
                  Text(e, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Connect')),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 15,
        padding: const EdgeInsets.all(24),
        itemBuilder: (context, index) {
          final isSuccess = index % 4 != 0;
          return Card(
            child: ListTile(
              leading: Icon(isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? Colors.green : Colors.red),
              title: Text('Workflow Execution #${1000 - index}'),
              subtitle:
                  Text(isSuccess ? 'Completed in 1.2s' : 'Failed at API step'),
              trailing: const Text('Today 14:32'),
            ),
          );
        },
      ),
    );
  }
}

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Pre-build Templates')),
    );
  }
}

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Pricing plans: Starter, Business, Enterprise')),
    );
  }
}

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Educational Content / Benefits of Automation')),
    );
  }
}
