import 'package:flutter/material.dart';
import 'package:h1d023028_tugas7/sidemenu.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidemenu(),
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F9FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSectionTitle("Tentang Student Hub"),
              const SizedBox(height: 10),
              _buildParagraph(
                "Student Hub adalah aplikasi sederhana yang dirancang untuk membantu mahasiswa "
                "mengatur jadwal kuliah, mencatat kegiatan penting, dan memantau aktivitas akademik "
                "secara lebih terstruktur.",
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Fitur Utama"),
              const SizedBox(height: 10),
              _buildFeatureTile(
                icon: Icons.date_range_rounded,
                title: "Jadwal Kuliah",
                desc: "Atur jadwal perkuliahan harian sesuai kebutuhanmu.",
              ),
              _buildFeatureTile(
                icon: Icons.note_alt_rounded,
                title: "Catatan Akademik",
                desc:
                    "Tambahkan notes penting seperti tugas, reminder, atau kegiatan kampus.",
              ),
              _buildFeatureTile(
                icon: Icons.person_pin_circle_rounded,
                title: "Profil Mahasiswa",
                desc:
                    "Tampilkan informasi dasar seperti nama dan program studi.",
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Tujuan Dibuat"),
              const SizedBox(height: 10),
              _buildParagraph(
                "Aplikasi ini dibuat sebagai bagian dari tugas pemrograman Flutter, dengan tujuan "
                "melatih kemampuan membangun UI modern, stateful widget, serta pengelolaan data "
                "menggunakan Shared Preferences.",
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Tentang Developer"),
              const SizedBox(height: 10),
              _buildDeveloperCard(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ============================
  // ==== COMPONENT BUILDER =====
  // ============================

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueAccent, width: 3),
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.school_rounded,
                color: Color(0xFF00A8E8),
                size: 60,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Student Hub / Jadwal Kuliah",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF102A43),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF102A43),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Color(0xFF243B53),
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A43),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: const [
          Icon(Icons.person_rounded, size: 60, color: Colors.blueAccent),
          SizedBox(height: 12),
          Text(
            "Dibuat oleh:",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          SizedBox(height: 4),
          Text(
            "Prasetyo Angga Permana (H1D023028)",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF102A43),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Mahasiswa Informatika yang sedang belajar Flutter.",
            style: TextStyle(fontSize: 13, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
