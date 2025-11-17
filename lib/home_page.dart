import 'package:flutter/material.dart';
import 'package:h1d023028_tugas7/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? namauser;
  final List<_ScheduleItem> _schedules = [];

  // Controller untuk input jadwal
  final TextEditingController _matkulController = TextEditingController();
  final TextEditingController _jamController = TextEditingController();
  final TextEditingController _ruangController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  String _selectedDay = 'Senin';

  final List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = prefs.getString('username');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _seedExampleData();
  }

  void _seedExampleData() {
    _schedules.addAll([
      _ScheduleItem(
        day: 'Senin',
        course: 'Pemrograman Mobile',
        time: '08.00 - 09.40',
        room: 'Lab RPL 1',
        note: 'Bawa laptop & charger.',
      ),
      _ScheduleItem(
        day: 'Rabu',
        course: 'Struktur Data',
        time: '10.00 - 11.40',
        room: 'Ruang 204',
        note: 'Review materi linked list.',
      ),
      _ScheduleItem(
        day: 'Jumat',
        course: 'Basis Data',
        time: '13.00 - 14.40',
        room: 'Lab Basis Data',
        note: 'Ada kuis kecil, jangan telat.',
      ),
    ]);
  }

  @override
  void dispose() {
    _matkulController.dispose();
    _jamController.dispose();
    _ruangController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _openAddScheduleSheet() {
    _matkulController.clear();
    _jamController.clear();
    _ruangController.clear();
    _catatanController.clear();
    _selectedDay = 'Senin';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Text(
                  'Tambah Jadwal Kuliah',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A43),
                  ),
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField<String>(
                  value: _selectedDay,
                  decoration: const InputDecoration(
                    labelText: 'Hari',
                    border: OutlineInputBorder(),
                  ),
                  items: _days
                      .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedDay = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _matkulController,
                  decoration: const InputDecoration(
                    labelText: 'Mata Kuliah',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _jamController,
                  decoration: const InputDecoration(
                    labelText: 'Jam (contoh: 08.00 - 09.40)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ruangController,
                  decoration: const InputDecoration(
                    labelText: 'Ruang (contoh: Lab RPL 1)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _catatanController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan tambahan (opsional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _saveSchedule,
                    icon: const Icon(Icons.save_rounded, color: Colors.white),
                    label: const Text(
                      'Simpan Jadwal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007EA7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveSchedule() {
    final matkul = _matkulController.text.trim();
    final jam = _jamController.text.trim();
    final ruang = _ruangController.text.trim();
    final catatan = _catatanController.text.trim();

    if (matkul.isEmpty || jam.isEmpty || ruang.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mata kuliah, jam, dan ruang tidak boleh kosong.'),
        ),
      );
      return;
    }

    setState(() {
      _schedules.add(
        _ScheduleItem(
          day: _selectedDay,
          course: matkul,
          time: jam,
          room: ruang,
          note: catatan.isEmpty ? '-' : catatan,
        ),
      );
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jadwal berhasil ditambahkan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = (namauser != null && namauser!.isNotEmpty)
        ? namauser!
        : 'Mahasiswa';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Kuliah',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00A8E8), Color(0xFF007EA7)],
            ),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const Sidemenu(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F9FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(displayName),
              const SizedBox(height: 20),
              const Text(
                'Daftar Jadwal Kuliah',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF102A43),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kamu bisa menambahkan jadwal baru dan memberi catatan kecil '
                'agar tidak lupa.',
                style: TextStyle(fontSize: 13, color: Color(0xFF627D98)),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _schedules.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada jadwal.\nTekan tombol + untuk menambahkan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF627D98),
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _schedules.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = _schedules[index];
                          return _buildScheduleCard(item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddScheduleSheet,
        backgroundColor: const Color(0xFF00A8E8),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Tambah Jadwal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00A8E8), Color(0xFF007EA7)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A8E8).withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Halo 👋',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ini ringkasan jadwal dan catatan kuliahmu.\n'
            'Jangan lupa update kalau ada perubahan kelas ya!',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(_ScheduleItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              color: _colorForDay(item.day),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.day,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF627D98),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.course,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF829AB1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.meeting_room_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.room,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF829AB1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Catatan: ${item.note}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF486581),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForDay(String day) {
    switch (day) {
      case 'Senin':
        return const Color(0xFF00A8E8);
      case 'Selasa':
        return const Color(0xFF06D6A0);
      case 'Rabu':
        return const Color(0xFFFFC857);
      case 'Kamis':
        return const Color(0xFFEF476F);
      case 'Jumat':
        return const Color(0xFF118AB2);
      case 'Sabtu':
        return const Color(0xFF9B5DE5);
      default:
        return const Color(0xFF00A8E8);
    }
  }
}

class _ScheduleItem {
  final String day;
  final String course;
  final String time;
  final String room;
  final String note;

  _ScheduleItem({
    required this.day,
    required this.course,
    required this.time,
    required this.room,
    required this.note,
  });
}
