# 📝 To-do List App

## Deskripsi
Aplikasi Flutter sederhana untuk mencatat daftar tugas (to-do list).  
Pengguna dapat:
- Menambahkan tugas baru
- Memberi tanda centang jika tugas sudah selesai
- Menghapus tugas satu per satu atau sekaligus
- Melihat daftar tugas yang sudah selesai di halaman khusus

Aplikasi ini terdiri dari **2 layar**:  
1. **HomeScreen** = menampilkan daftar semua tugas  
2. **DoneScreen** = menampilkan daftar tugas yang sudah selesai  

---

## Diagram Widget Tree 
MaterialApp
└── ChangeNotifierProvider (TodoProvider)
└── HomeScreen (Scaffold)
├── AppBar
│ ├── IconButton → Navigasi ke DoneScreen
│ └── IconButton → Hapus semua tugas selesai
├── Column
│ ├── TextField → Input tugas
│ ├── ElevatedButton → Tambah tugas
│ └── Expanded → ListView (TodoItem)

DoneScreen (Scaffold)
└── ListView → Menampilkan daftar tugas selesai

## 🛠️ Pendekatan State Management
- **Provider (ChangeNotifier)** digunakan sebagai state management
- **Alasan pemilihan:**
  - Provider resmi didukung Flutter   
  - Cocok untuk pemula karena sintaksnya sederhana  
  - Mudah menghubungkan data dengan UI secara reaktif
  - Skalabel jika aplikasi bertambah besar di kemudian hari
