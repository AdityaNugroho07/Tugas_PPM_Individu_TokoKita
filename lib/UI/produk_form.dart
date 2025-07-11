import 'package:flutter/material.dart';
import 'package:tokokita/UI/produk_page.dart';
import 'package:tokokita/BLOC/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  final _kodeProdukController = TextEditingController();
  final _namaProdukController = TextEditingController();
  final _hargaProdukController = TextEditingController();

  bool _isLoading = false;
  late String _judul;
  late String _labelTombol;

  @override
  void initState() {
    super.initState();
    if (widget.produk != null) {
      _judul = "UBAH PRODUK";
      _labelTombol = "UBAH";
      _kodeProdukController.text = widget.produk!.kodeProduk ?? '';
      _namaProdukController.text = widget.produk!.namaProduk ?? '';
      _hargaProdukController.text = widget.produk!.hargaProduk.toString();
    } else {
      _judul = "TAMBAH PRODUK";
      _labelTombol = "SIMPAN";
    }
  }

  @override
  void dispose() {
    _kodeProdukController.dispose();
    _namaProdukController.dispose();
    _hargaProdukController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_judul)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _textField(
                controller: _kodeProdukController,
                label: "Kode Produk",
                validatorMsg: "Kode Produk harus diisi",
              ),
              _textField(
                controller: _namaProdukController,
                label: "Nama Produk",
                validatorMsg: "Nama Produk harus diisi",
              ),
              _textField(
                controller: _hargaProdukController,
                label: "Harga",
                inputType: TextInputType.number,
                validatorMsg: "Harga harus diisi",
              ),
              const SizedBox(height: 20),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String validatorMsg,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validatorMsg;
        }
        return null;
      },
    );
  }

  Widget _submitButton() {
    return OutlinedButton(
      onPressed: _isLoading ? null : _onSubmit,
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(_labelTombol),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.produk != null) {
      _ubahProduk();
    } else {
      _simpanProduk();
    }
  }

  void _simpanProduk() async {
    setState(() => _isLoading = true);

    try {
      final produkBaru = Produk(id: null)
        ..kodeProduk = _kodeProdukController.text
        ..namaProduk = _namaProdukController.text
        ..hargaProduk = int.parse(_hargaProdukController.text);

      await ProdukBloc.addProduk(produk: produkBaru);
      if (!mounted) return;
      _navigasiKeList();
    } catch (_) {
      if (!mounted) return;
      _tampilkanError("Simpan gagal, silakan coba lagi");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _ubahProduk() async {
    setState(() => _isLoading = true);

    try {
      final produkUpdate = Produk(id: widget.produk!.id)
        ..kodeProduk = _kodeProdukController.text
        ..namaProduk = _namaProdukController.text
        ..hargaProduk = int.parse(_hargaProdukController.text);

      await ProdukBloc.updateProduk(produk: produkUpdate);
      if (!mounted) return;
      _navigasiKeList();
    } catch (_) {
      if (!mounted) return;
      _tampilkanError("Permintaan ubah data gagal, silakan coba lagi");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _tampilkanError(String msg) {
    showDialog(
      context: context,
      builder: (context) => WarningDialog(description: msg),
    );
  }

  void _navigasiKeList() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ProdukPage()),
    );
  }
}
