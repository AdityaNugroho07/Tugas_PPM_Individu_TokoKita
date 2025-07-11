import 'package:flutter/material.dart';
import 'package:tokokita/bloc/logout_bloc.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/UI/login_page.dart';
import 'package:tokokita/UI/produk_detail.dart';
import 'package:tokokita/UI/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late Future<List<Produk>> _futureProduk;

  @override
  void initState() {
    super.initState();
    _loadProduks();
  }

  void _loadProduks() {
    _futureProduk = ProdukBloc.getProduks();
  }

  void _refreshPage() {
    setState(() {
      _loadProduks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProdukForm()),
                );
                _refreshPage();
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Produk>>(
        future: _futureProduk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Gagal memuat data: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada produk"));
          }

          final produks = snapshot.data!;
          return ListView.builder(
            itemCount: produks.length,
            itemBuilder: (context, index) {
              return ItemProduk(
                produk: produks[index],
                onUpdate: _refreshPage,
              );
            },
          );
        },
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  final VoidCallback onUpdate;

  const ItemProduk({Key? key, required this.produk, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProdukDetail(produk: produk),
          ),
        );
        onUpdate();
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk ?? '-'),
          subtitle: Text("Rp ${produk.hargaProduk}"),
        ),
      ),
    );
  }
}