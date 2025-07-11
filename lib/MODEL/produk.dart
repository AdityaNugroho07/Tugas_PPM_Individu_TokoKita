

class Produk{
  int? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;

  Produk({this.hargaProduk, this.id, this.kodeProduk, this.namaProduk});
  factory Produk.fromJson(Map<String, dynamic>obj)
  {
    return Produk(
      id: obj['id'],
      kodeProduk: obj['kode_produk'],
      namaProduk: obj['nama_produk'],
      hargaProduk: obj['harga_produk'],
     );
    }
  }
