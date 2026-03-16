# Problem & Solution Note App_Jemis Movid_2409116070

## Deskripsi Aplikasi

**Problem & Solution Note** adalah aplikasi mobile sederhana yang dibuat menggunakan **Flutter** untuk mencatat berbagai permasalahan dan solusi yang ditemukan selama proses belajar atau bekerja.

Aplikasi ini memungkinkan pengguna untuk menyimpan, melihat, memperbarui, dan menghapus catatan masalah beserta solusi yang terkait. Semua data disimpan secara online menggunakan **Supabase** sebagai backend database sehingga data dapat diakses secara dinamis oleh aplikasi.

Aplikasi ini dikembangkan sebagai bagian dari **Mini Project 2** pada praktikum Mobile Programming dengan fokus pada implementasi **CRUD (Create, Read, Update, Delete)** serta integrasi database.

---

## Widget yang Digunakan

Berikut beberapa widget Flutter yang digunakan dalam pengembangan aplikasi ini:

* `MaterialApp`
* `Scaffold`
* `AppBar`    
* `ListView`
* `ListTile`
* `Card`
* `Text`
* `TextFormField`
* `ElevatedButton`
* `FloatingActionButton`
* `IconButton`
* `AlertDialog`
* `Snackbar`
* `Navigator`

---

## Teknologi yang Digunakan

* **Flutter**
* **Dart**
* **Supabase (Database Backend)**

---

---
## Struktur Folder

```dart
l
```

---

## Fitur Aplikasi

Aplikasi ini memiliki beberapa fitur utama, yaitu:

* **Read Note**
  Menampilkan seluruh catatan yang tersimpan di database Supabase dalam bentuk daftar.

* **Create Note**
  Pengguna dapat menambahkan catatan baru yang berisi judul, kategori, deskripsi masalah, dan solusi.

* **Update Note**
  Pengguna dapat mengedit catatan yang sudah dibuat sebelumnya.

* **Delete Note**
  Catatan dapat dihapus dari database.

* **Light Mode & Dark Mode**
  Aplikasi mendukung perubahan tema antara mode terang dan mode gelap.

* **Database Integration (Supabase)**
  Semua data disimpan dan dikelola melalui database Supabase.

---

## Penjelasan Fitur Aplikasi

Aplikasi **Problem & Solution Note** memiliki beberapa fitur utama yang memungkinkan pengguna untuk mengelola catatan masalah dan solusi secara dinamis menggunakan database Supabase.

### 1. Menampilkan Data Catatan (Read)

Fitur ini berfungsi untuk menampilkan seluruh catatan yang tersimpan di database Supabase ke dalam tampilan aplikasi.

Pada saat aplikasi dijalankan, fungsi `loadNotes()` akan dipanggil untuk mengambil data dari Supabase melalui service layer. Data yang diterima kemudian disimpan ke dalam state dan ditampilkan menggunakan `ListView`.

Contoh implementasi pada `HomeScreen`:

```dart
Future<void> loadNotes() async {

  final data = await supabaseService.getNotes();

  setState(() {
    notes = data;
  });

}
```

Data tersebut diambil dari Supabase menggunakan fungsi berikut pada `supabase_service.dart`:

```dart
Future<List<Note>> getNotes() async {
  final data = await supabase.from('notes').select();

  return (data as List)
      .map((note) => Note.fromJson(note))
      .toList();
}
```

Fungsi ini mengambil seluruh data dari tabel `notes` kemudian mengubahnya menjadi objek `Note`.

---

### 2. Menambahkan Catatan Baru (Create)

Fitur ini memungkinkan pengguna untuk menambahkan catatan baru yang berisi beberapa field, yaitu:

* Judul catatan
* Deskripsi masalah
* Solusi
* Kategori

Pengguna mengisi form pada halaman **Add Note Screen**, kemudian data akan dikirim ke database Supabase melalui fungsi `addNote()`.

Contoh pemanggilan fungsi pada `AddNoteScreen`:

```dart
Future<void> saveNote() async {

  if (_formKey.currentState!.validate()) {

    await supabaseService.addNote(
      titleController.text,
      problemController.text,
      solutionController.text,
      categoryController.text,
    );

    Navigator.pop(context, true);
  }

}
```

Data kemudian disimpan ke database melalui service berikut:

```dart
Future<void> addNote(
  String title,
  String problem,
  String solution,
  String category,
) async {

  await supabase.from('notes').insert({
    'title': title,
    'problem': problem,
    'solution': solution,
    'category': category,
  });

}
```

Setelah proses penyimpanan selesai, aplikasi kembali ke halaman utama dan daftar catatan diperbarui.

---

### 3. Mengubah Data Catatan (Update)

Fitur ini memungkinkan pengguna untuk mengedit catatan yang sudah ada. Pengguna dapat membuka halaman **Edit Note Screen** dengan menekan salah satu item catatan pada daftar.

Data lama dari catatan tersebut akan dimasukkan ke dalam form melalui controller.

```dart
@override
void initState() {
  super.initState();

  titleController.text = widget.note.title;
  problemController.text = widget.note.problemDescription;
  solutionController.text = widget.note.solution;
  categoryController.text = widget.note.category;
}
```

Setelah pengguna memperbarui data, fungsi `updateNote()` akan dipanggil untuk memperbarui data di database.

```dart
Future<void> updateNote() async {

  if (_formKey.currentState!.validate()) {

    final updatedNote = Note(
      id: widget.note.id,
      title: titleController.text,
      problemDescription: problemController.text,
      solution: solutionController.text,
      category: categoryController.text,
    );

    await supabaseService.updateNote(updatedNote);

    Navigator.pop(context, true);
  }

}
```

Proses update pada database dilakukan oleh service berikut:

```dart
Future<void> updateNote(Note note) async {
  await supabase
      .from('notes')
      .update(note.toJson())
      .eq('id', note.id);
}
```

Fungsi ini memperbarui data berdasarkan `id` catatan yang dipilih.

---

### 4. Menghapus Catatan (Delete)

Fitur ini memungkinkan pengguna untuk menghapus catatan yang sudah tidak diperlukan lagi. Tombol hapus tersedia pada setiap item catatan di halaman utama.

Saat tombol ditekan, fungsi `deleteNote()` akan dipanggil untuk menghapus data dari database Supabase.

Contoh implementasi pada `HomeScreen`:

```dart
Future<void> deleteNote(String id) async {

  await supabaseService.deleteNote(id);

  loadNotes();

}
```

Proses penghapusan data dilakukan melalui service berikut:

```dart
Future<void> deleteNote(String id) async {
  await supabase
      .from('notes')
      .delete()
      .eq('id', id);
}
```

Setelah data berhasil dihapus, aplikasi akan memuat ulang daftar catatan sehingga perubahan langsung terlihat pada tampilan aplikasi.

## Penjelasan Fitur Untuk Nilai Tambah

Selain fitur utama CRUD dan integrasi database, aplikasi **Problem & Solution Note** juga dilengkapi dengan beberapa fitur tambahan untuk meningkatkan kualitas aplikasi, yaitu dukungan **Light Mode & Dark Mode** serta penggunaan **file `.env` untuk keamanan konfigurasi Supabase**.

---

### 1. Light Mode dan Dark Mode

Aplikasi menyediakan fitur untuk mengubah tampilan antara **Light Mode** dan **Dark Mode**. Fitur ini bertujuan untuk meningkatkan kenyamanan pengguna saat menggunakan aplikasi dalam kondisi pencahayaan yang berbeda.

Pengaturan tema dilakukan pada file `main.dart` dengan memanfaatkan properti `theme`, `darkTheme`, dan `themeMode` pada widget `MaterialApp`.

Contoh implementasi:

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Problem & Solution Note',

  themeMode: themeMode,

  theme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.light,
  ),

  darkTheme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.dark,
  ),
)
```

Variabel `themeMode` digunakan untuk menentukan apakah aplikasi menggunakan **tema terang** atau **tema gelap**.

Untuk mengganti tema secara dinamis, dibuat fungsi `toggleTheme()` yang akan mengubah nilai `ThemeMode`.

```dart
void toggleTheme() {
  setState(() {
    themeMode =
        themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  });
}
```

Fungsi ini kemudian dipanggil melalui tombol pada `AppBar` di halaman utama aplikasi.

```dart
IconButton(
  icon: const Icon(Icons.dark_mode),
  onPressed: widget.toggleTheme,
)
```

Ketika tombol ditekan, aplikasi akan langsung berpindah antara **Light Mode** dan **Dark Mode** tanpa perlu me-restart aplikasi.

---

### 2. Penggunaan File `.env` untuk Konfigurasi Supabase

Untuk meningkatkan keamanan aplikasi, konfigurasi **Supabase URL** dan **API Key** tidak dituliskan langsung di dalam kode sumber, melainkan disimpan di dalam file `.env`.

Pendekatan ini bertujuan untuk:

* Menghindari penyebaran API Key di dalam repository publik
* Memisahkan konfigurasi dari kode program
* Memudahkan pengelolaan environment aplikasi

Contoh isi file `.env`:

```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-public-key
```

Nilai tersebut kemudian dibaca oleh aplikasi saat proses inisialisasi Supabase.

Contoh penggunaan pada kode:

```dart
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
);
```

Dengan cara ini, aplikasi tetap dapat terhubung dengan database Supabase tanpa harus menuliskan informasi sensitif secara langsung di dalam kode sumber.

File `.env` juga dapat ditambahkan ke dalam `.gitignore` sehingga tidak ikut terunggah ke repository GitHub.

