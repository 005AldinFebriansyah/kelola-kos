
class itemPenghuni {
  final String itemNama;
  final String itemNIK;
  final String itemNoHP;
  final String itemAlamat;
  final String itemNoKmr;

  itemPenghuni({required this.itemNama, required this.itemNIK, required this.itemNoHP, required this.itemAlamat, required this.itemNoKmr});

  Map<String, dynamic> toJson(){
    return {
      'Nama': itemNama,
      'NIK': itemNIK,
      'No HP': itemNoHP,
      'Alamat': itemAlamat,
      'No Kamar': itemNoKmr,
    };
  }

  factory itemPenghuni.fromJson(Map<String, dynamic> json){
    return itemPenghuni(
      itemNama: json['Nama'], 
      itemNIK: json['NIK'], 
      itemNoHP: json['No HP'], 
      itemAlamat: json['Alamat'], 
      itemNoKmr: json['No Kamar']
    );
  }
}