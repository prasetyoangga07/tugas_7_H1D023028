# 📚 Student Hub – Jadwal Kuliah 


---

## Prasetyo Angga Permana
## H1D023028
## SHIFT A

---

## Dokumentasi 


https://github.com/user-attachments/assets/1d5ef9c2-f85e-43f1-8d99-823373e8b9a4



## ✅ 1. Kenapa Login Bisa Berhasil?
Mekanisme login bekerja melalui 3 tahap:

### ✔ Pengambilan Input  
Aplikasi membaca username dan password dari:
```dart
TextEditingController

```
## ✔ Validasi Data

Aplikasi mengecek kecocokan:

``if (username == 'Pras' && password == 'H1D023028')``

## ✔ Penyimpanan & Navigasi

Jika benar:

``prefs.setString('username', username);``
``Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));``

Jika salah → muncul dialog gagal.

Singkatnya: login berhasil karena input dicek, disimpan, lalu diarahkan ke halaman utama.

## Menambahkan Jadwal di HomePage
itur penambahan jadwal bekerja karena tiga komponen utama:

## ✔ A. Struktur Penyimpanan

Aplikasi menyimpan daftar jadwal dalam List:

``final List<_ScheduleItem> _schedules = [];``

## ✔ B. Form Input Menggunakan BottomSheet

Saat menekan tombol Tambah Jadwal, muncul:

``showModalBottomSheet(...)``


yang berisi form:
- Hari
- Mata kuliah
- Jam
- Ruang
- Catatan

## ✔ C. Penyimpanan Data ke List

Ketika tombol “Simpan Jadwal” ditekan, fungsi berikut berjalan:

``_saveSchedule();``


Di dalamnya terjadi:
Membaca input dari controller

Membuat objek jadwal baru:

``_ScheduleItem(...)``


Menambah objek ke dalam list:

``_schedules.add(...)``


Update UI dengan:

``setState(() {});``


Singkatnya: jadwal berhasil ditambahkan karena datanya dimasukkan ke List dan UI diperbarui dengan setState().
