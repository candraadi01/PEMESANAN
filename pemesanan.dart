import 'dart:io';

class TShirtOrder {
  String customerName;
  String design;
  String size;
  int quantity;
  double price;

  TShirtOrder(this.customerName, this.design, this.size, this.quantity, this.price);

  void displayOrder() {
    print("Pesanan Kaos Sablon Premium:");
    print("Nama Pelanggan: $customerName");
    print("Desain: $design");
    print("Ukuran: $size");
    print("Jumlah: $quantity");
    print("Harga Total: Rp${price.toStringAsFixed(2)}");
  }
}

void main() {
  // Inisialisasi daftar pesanan dan ukuran yang tersedia
  List<TShirtOrder> orders = [];
  Set<String> availableSizes = {'S', 'M', 'L', 'XL'};
  Map<String, List<TShirtOrder>> ordersByCustomer = {};

  while (true) {
    print("\nPilihan:");
    print("1. Tambah Pesanan");
    print("2. Tampilkan Pesanan");
    print("3. Tampilkan Pesanan Berdasarkan Nama Pelanggan");
    print("4. Keluar");
    stdout.write("Pilih operasi (1/2/3/4): ");
    String choice = stdin.readLineSync()!;

    switch (choice) {
      case '1':
        // Ambil informasi pesanan dari pengguna
        stdout.write("Masukkan nama pelanggan: ");
        String customerName = stdin.readLineSync()!;
        stdout.write("Masukkan desain kaos: ");
        String design = stdin.readLineSync()!;
        stdout.write("Masukkan ukuran kaos (S/M/L/XL): ");
        String size = stdin.readLineSync()!.toUpperCase();

        if (!availableSizes.contains(size)) {
          print("Ukuran tidak tersedia. Pilih ukuran yang valid (S/M/L/XL).");
          break;
        }

        stdout.write("Masukkan jumlah kaos: ");
        int quantity = int.parse(stdin.readLineSync()!);

        // Hitung harga total
        double basePrice = 50000;
        double sizeMultiplier = 1.0;
        switch (size) {
          case 'M':
            sizeMultiplier = 1.1;
            break;
          case 'L':
            sizeMultiplier = 1.2;
            break;
          case 'XL':
            sizeMultiplier = 1.3;
            break;
        }

        double totalPrice = quantity * (basePrice * sizeMultiplier);

        // Buat objek TShirtOrder dan tambahkan ke daftar
        TShirtOrder order = TShirtOrder(customerName, design, size, quantity, totalPrice);
        orders.add(order);

        // Tambahkan pesanan ke dalam map berdasarkan nama pelanggan
        if (!ordersByCustomer.containsKey(customerName)) {
          ordersByCustomer[customerName] = [];
        }
        ordersByCustomer[customerName]!.add(order);

        // Tampilkan pesan konfirmasi
        print("Pesanan berhasil ditambahkan.");
        order.displayOrder();
        break;

      case '2':
        if (orders.isEmpty) {
          print("Belum ada pesanan yang dibuat.");
        } else {
          print("Daftar Pesanan:");
          for (TShirtOrder order in orders) {
            order.displayOrder();
            print("------------------");
          }
        }
        break;

      case '3':
        if (ordersByCustomer.isEmpty) {
          print("Belum ada pesanan yang dibuat.");
        } else {
          stdout.write("Masukkan nama pelanggan: ");
          String customerName = stdin.readLineSync()!;
          if (ordersByCustomer.containsKey(customerName)) {
            print("Daftar Pesanan untuk $customerName:");
            for (TShirtOrder order in ordersByCustomer[customerName]!) {
              order.displayOrder();
              print("------------------");
            }
          } else {
            print("Tidak ada pesanan ditemukan untuk pelanggan dengan nama $customerName.");
          }
        }
        break;

      case '4':
        print("Keluar dari program.");
        return;

      default:
        print("Pilihan tidak valid.");
    }
  }
}
