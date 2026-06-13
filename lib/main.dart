import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fundo López - Smart IoT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool autotransformadorEncendido = false;
  bool bombaEncendida = false;

  // Datos simulados
  String voltajeEntrada = "220.7";
  String voltajeSalida = "220";
  String tapActivo = "3";
  String temperatura = "25";
  String estadoBomba = "OFF";
  String alarma = "OK";
  String humedadSuelo = "65";
  String modoRiego = "goteo";
  String electrovalvula = "ABIERTA";
  String tiempoRiego = "30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // AppBar Moderno
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: const Color(0xFF1A5F7A),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Smart Irrigation System',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A5F7A), Color(0xFF2E8B57)],
                  ),
                ),
              ),
            ),
          ),

          // Contenido
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Header de bienvenida
                _buildWelcomeHeader(),
                const SizedBox(height: 20),

                // Tarjeta Autotransformador
                _buildAutotransformadorCard(),
                const SizedBox(height: 20),

                // Gráfico Voltaje
                _buildVoltageChart(),
                const SizedBox(height: 20),

                // Tarjeta Riego
                _buildRiegoCard(),
                const SizedBox(height: 20),

                // Gráfico Humedad
                _buildHumidityChart(),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A5F7A), Color(0xFF2E8B57)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.bolt, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bienvenido, Operador',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fundo López · ${DateTime.now().toString().substring(0, 16)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi, color: Colors.green, size: 16),
                SizedBox(width: 4),
                Text('Online', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutotransformadorCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.blue[50]!],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.electrical_services, color: Colors.blue[700], size: 28),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Autotransformador',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Regulación inteligente',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: alarma == 'OK' ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        alarma == 'OK' ? Icons.check_circle : Icons.warning,
                        color: alarma == 'OK' ? Colors.green : Colors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        alarma,
                        style: TextStyle(
                          color: alarma == 'OK' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildModernMetric(
                    'Voltaje Entrada',
                    '$voltajeEntrada V',
                    Icons.electric_bolt,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12), 
                Expanded(
                  child: _buildModernMetric(
                    'Voltaje Salida',
                    '$voltajeSalida V',
                    Icons.electrical_services,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildModernMetric(
                    'Tap Activo',
                    tapActivo,
                    Icons.tune,
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 12), 
                Expanded(
                  child: _buildModernMetric(
                    'Temperatura',
                    '$temperatura°C',
                    Icons.thermostat,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildModernMetric(
                    'Estado Bomba',
                    estadoBomba,
                    Icons.opacity,
                    estadoBomba == 'ON' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModernMetric(
                    'Eficiencia',
                    '94%',
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildModernButton(
              label: 'Control Manual Autotransformador',
              isActive: autotransformadorEncendido,
              activeText: 'ENCENDIDO',
              inactiveText: 'APAGADO',
              onPressed: () {
                setState(() {
                  autotransformadorEncendido = !autotransformadorEncendido;
                });
                _showSnackbar('Autotransformador ${autotransformadorEncendido ? "Encendido" : "Apagado"}');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoltageChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.show_chart, color: Colors.blue[700], size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Historial de Voltaje',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insights, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      'Gráfico en tiempo real',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Próximamente',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiegoCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.green[50]!],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.water_drop, color: Colors.green[700], size: 28),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sistema de Riego',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Optimización hídrica',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Indicador circular de humedad
            Center(
              child: SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: double.parse(humedadSuelo) / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        double.parse(humedadSuelo) > 60
                            ? Colors.green
                            : double.parse(humedadSuelo) > 30
                                ? Colors.orange
                                : Colors.red,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$humedadSuelo%',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Humedad',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildModernMetric(
                    'Modo Riego',
                    modoRiego,
                    Icons.water,
                    Colors.cyan,
                  ),
                ),
                  const SizedBox(width: 12),
                Expanded(
                  child: _buildModernMetric(
                    'Electroválvula',
                    electrovalvula,
                    Icons.opacity,
                    electrovalvula == 'ABIERTA' ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildModernMetric(
                    'Tiempo Riego',
                    '$tiempoRiego min',
                    Icons.timer,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModernMetric(
                    'Agua Ahorrada',
                    '1,240 L',
                    Icons.water,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildModernButton(
              label: 'Control Manual de Bomba',
              isActive: bombaEncendida,
              activeText: 'ENCENDER',
              inactiveText: 'APAGAR',
              onPressed: () {
                setState(() {
                  bombaEncendida = !bombaEncendida;
                  estadoBomba = bombaEncendida ? "ON" : "OFF";
                });
                _showSnackbar('Bomba ${bombaEncendida ? "Encendida" : "Apagada"}');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHumidityChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: Colors.green[700], size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Historial de Humedad',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      'Tendencia últimos 24h',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Próximamente',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widgets reutilizables modernos
  Widget _buildModernMetric(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildModernButton({
  required String label,
  required bool isActive,
  required String activeText,
  required String inactiveText,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Texto con límite y wrap
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500, 
              fontSize: 12,
              height: 1.2,
            ),
            maxLines: 2,  // Permite 2 líneas
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        // Botón con tamaño fijo
        SizedBox(
          width: 120,  // Ancho fijo para el botón
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                gradient: isActive
                    ? const LinearGradient(
                        colors: [Color(0xFF2E8B57), Color(0xFF1A5F7A)],
                      )
                    : LinearGradient(
                        colors: [Colors.grey[400]!, Colors.grey[500]!],
                      ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isActive ? Icons.power_settings_new : Icons.power_off,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isActive ? activeText : inactiveText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}