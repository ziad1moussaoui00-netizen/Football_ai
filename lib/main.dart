import 'package:flutter/material.dart';

void main() {
  runApp(const FootballAIApp());
}

class FootballAIApp extends StatelessWidget {
  const FootballAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Football Analyst Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.greenAccent,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardColor: const Color(0xFF1E293B),
        colorScheme: const ColorScheme.dark(
          primary: Colors.greenAccent,
          secondary: Colors.tealAccent,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _savedHistory = [];

  void _addToHistory(Map<String, dynamic> analysisData) {
    setState(() {
      _savedHistory.insert(0, analysisData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onAnalysisComplete: _addToHistory),
      HistoryScreen(historyList: _savedHistory),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'التحليل',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'السجل',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAnalysisComplete;

  const HomeScreen({super.key, required this.onAnalysisComplete});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _homeTeamController = TextEditingController(text: "FC Barcelona");
  final TextEditingController _awayTeamController = TextEditingController(text: "Real Madrid");
  
  String _selectedLeague = "دوري أبطال أوروبا";
  bool _enableNotifications = true;
  bool _isLoading = false;
  Map<String, dynamic>? _analysisResult;

  final List<String> _leagues = [
    "دوري أبطال أوروبا",
    "الدوري الإسباني (LaLiga)",
    "الدوري الإنجليزي الممتاز",
    "الدوري الإيطالي",
    "الدوري الألماني",
    "بطولة أخرى"
  ];

  Future<void> _analyzeMatch() async {
    setState(() {
      _isLoading = true;
      _analysisResult = null;
    });

    // محاكاة الاتصال الذكي لمعالجة البيانات
    await Future.delayed(const Duration(seconds: 2));

    final simulated = {
      "league": _selectedLeague,
      "match": "${_homeTeamController.text} vs ${_awayTeamController.text}",
      "home_team": _homeTeamController.text,
      "away_team": _awayTeamController.text,
      "date": DateTime.now().toString().split(' ')[0],
      "home_win_prob": 48,
      "draw_prob": 27,
      "away_win_prob": 25,
      "expected_goals": "2.8 (مباراة هجومية متوقعة)",
      "tactical_analysis":
          "ضغط عالي متوقع من الفريق المستضيف مع اعتماد الفريق الضيف على التحول السريع والهجمات المرتدة عبر الأجنحة.",
      "ai_recommendation": "أفضلية طفيفة للفريق المستضيف لحسم اللقاء بفارق هدف.",
      "notifications": _enableNotifications ? "مُفعلة للمباراة" : "معطلة"
    };

    setState(() {
      _isLoading = false;
      _analysisResult = simulated;
    });

    widget.onAnalysisComplete(simulated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محلل المباريات الذكي AI'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "بيانات المباراة والبطولة",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedLeague,
                      decoration: const InputDecoration(
                        labelText: "اختر البطولة",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.emoji_events),
                      ),
                      items: _leagues.map((league) {
                        return DropdownMenuItem(value: league, child: Text(league));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedLeague = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _homeTeamController,
                      decoration: const InputDecoration(
                        labelText: "الفريق المستضيف (Home)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.sports_soccer),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _awayTeamController,
                      decoration: const InputDecoration(
                        labelText: "الفريق الضيف (Away)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.sports_soccer_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: const Text("تفعيل تتبع إشعارات المباراة"),
                      subtitle: const Text("تنبيه عند اقتراب بداية المباراة"),
                      value: _enableNotifications,
                      activeColor: Colors.greenAccent,
                      onChanged: (val) => setState(() => _enableNotifications = val),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _analyzeMatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                              "بدء التحليل التكتيكي",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_analysisResult != null) ...[
              _buildProbabilityCard(_analysisResult!),
              const SizedBox(height: 12),
              _buildDetailCard(
                title: "الأهداف المتوقعة (xG)",
                content: _analysisResult!['expected_goals'],
                icon: Icons.score,
              ),
              const SizedBox(height: 12),
              _buildDetailCard(
                title: "التحليل التكتيكي",
                content: _analysisResult!['tactical_analysis'],
                icon: Icons.analytics,
              ),
              const SizedBox(height: 12),
              _buildDetailCard(
                title: "توصيات الذكاء الاصطناعي",
                content: _analysisResult!['ai_recommendation'],
                icon: Icons.psychology,
                accentColor: Colors.greenAccent,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProbabilityCard(Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "${data['league']} | ${data['match']}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              "نسب الاحتمالات",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProbItem("فوز المستضيف", "${data['home_win_prob']}%", Colors.green),
                _buildProbItem("تعادل", "${data['draw_prob']}%", Colors.orange),
                _buildProbItem("فوز الضيف", "${data['away_win_prob']}%", Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProbItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String content,
    required IconData icon,
    Color? accentColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: accentColor ?? Colors.greenAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 20),
            Text(
              content,
              style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.white90),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> historyList;

  const HistoryScreen({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل التحليلات السابقة'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: historyList.isEmpty
          ? const Center(
              child: Text(
                'لا توجد مباريات محللة سابقاً',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.sports_soccer, color: Colors.greenAccent),
                    title: Text(item['match'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${item['league']} - ${item['date']}"),
                    trailing: Text(
                      "${item['home_win_prob']}% / ${item['away_win_prob']}%",
                      style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
