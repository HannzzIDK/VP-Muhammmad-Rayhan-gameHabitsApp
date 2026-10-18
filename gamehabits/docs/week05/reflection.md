# Week 5 Reflection

**1. Which structural decision from Week 1 helped you most by Week 5?**
Keputusan untuk mengadopsi mindset "everything is a widget" sejak awal dan menerapkan *Separation of Concerns*. Dengan memisahkan komponen antarmuka ke dalam folder `widgets/` (seperti `quest_card.dart` dan `empty_quest_view.dart`) serta logika data di `models/`, kode halaman utama tetap bersih dan berada di bawah batas 200 baris. Modulariasi ini sangat memudahkan navigasi dan perbaikan *bug* saat aplikasi mulai memiliki banyak layar.

**2. Which one cost you time, and what would you do differently?**
Penggunaan *styling* statis (*hardcoded colors* dan *font sizes*) serta asumsi ruang layar yang kaku pada minggu-minggu awal. Hal ini memakan waktu saat harus membersihkan peringatan *linter* dan memperbaiki serangkaian *error layout* (seperti Horizontal/Vertical RenderFlex Overflow). Ke depannya, saya akan selalu menggunakan `Theme.of(context)` sejak baris kode pertama ditulis dan merencanakan struktur *scrollable* atau *flex* (`Expanded`) sebelum menyusun antarmuka agar desain langsung responsif.

**3. Where is your app's state right now, and what will be hard about moving it in Module 2?**
Saat ini, *state* aplikasi masih sangat sederhana, statis, dan terikat pada UI lokal. Tantangan terbesar saat memasuki Modul 2 adalah mengimplementasikan arsitektur *state management* yang mampu menangani sinkronisasi data yang kompleks. Aplikasi ini membutuhkan operasi CRUD penuh yang terhubung ke *backend*, sistem akun autentikasi, serta pengelolaan *state* lintas layar untuk fitur seperti sistem *avatar* pemain. Selain itu, mengubah tema bawaan Material menjadi UI kustom bernuansa *fantasy* akan membutuhkan kontrol *state* visual yang jauh lebih dinamis.