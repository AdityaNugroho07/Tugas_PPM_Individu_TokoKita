import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  const ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukDetail> createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final produk = widget.produk!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kode : ${produk.kodeProduk}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Nama : ${produk.namaProduk}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Harga : Rp. ${produk.hargaProduk}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
               builder: (context) => const ProdukForm(),

              ),
            );
          },
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          child: _isDeleting
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("DELETE"),
          onPressed: _isDeleting ? null : confirmHapus,
        ),
      ],
    );
  }

  void confirmHapus() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Ya"),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog dulu
              hapusProduk();
            },
          ),
        ],
      ),
    );
  }

  void hapusProduk() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      await ProdukBloc.deleteProduk(id: widget.produk!.id!);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ProdukPage()),
      );
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(
          description: "Hapus gagal, silakan coba lagi",
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }
}
