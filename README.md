# Problem & Solution Note App

## Deskripsi Aplikasi

**Problem & Solution Note** adalah aplikasi mobile sederhana yang dibuat menggunakan **Flutter** untuk mencatat berbagai permasalahan dan solusi yang ditemukan selama proses belajar atau bekerja.

Aplikasi ini memungkinkan pengguna untuk menyimpan, melihat, memperbarui, dan menghapus catatan masalah beserta solusi yang terkait. Semua data disimpan secara online menggunakan **Supabase** sebagai backend database sehingga data dapat diakses secara dinamis oleh aplikasi.

Aplikasi ini dikembangkan sebagai bagian dari **Mini Project 2** pada praktikum Mobile Programming dengan fokus pada implementasi **CRUD (Create, Read, Update, Delete)** serta integrasi database.

---

## Fitur Aplikasi

Aplikasi ini memiliki beberapa fitur utama, yaitu:

* **Create Note**
  Pengguna dapat menambahkan catatan baru yang berisi judul, kategori, deskripsi masalah, dan solusi.

* **Read Note**
  Menampilkan seluruh catatan yang tersimpan di database Supabase dalam bentuk daftar.

* **Update Note**
  Pengguna dapat mengedit catatan yang sudah dibuat sebelumnya.

* **Delete Note**
  Catatan dapat dihapus dari database.

* **Light Mode & Dark Mode**
  Aplikasi mendukung perubahan tema antara mode terang dan mode gelap.

* **Database Integration (Supabase)**
  Semua data disimpan dan dikelola melalui database Supabase.

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

## Struktur Halaman Aplikasi

Aplikasi terdiri dari beberapa halaman utama:

* **Home Screen**
  Menampilkan daftar seluruh catatan yang tersimpan.

* **Add Note Screen**
  Digunakan untuk menambahkan catatan baru.

* **Edit Note Screen**
  Digunakan untuk memperbarui catatan yang sudah ada.

---

## Repository

Source code aplikasi dapat diakses melalui repository GitHub berikut:

```
https://github.com/JM-glich/Aplikasi_Problem-Solution_Note
```
