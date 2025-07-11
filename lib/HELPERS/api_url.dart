class ApiUrl{
  static const String baseUrl = 'http://10.0.2.2/toko_api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String Login = baseUrl + '/registrasi';
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';

  static String updatrProduk(int id) {
    return baseUrl + '/produk/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }
}