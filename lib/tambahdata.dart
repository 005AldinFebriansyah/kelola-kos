import 'package:data_penghuni_kos/dataclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dbservices.dart';

class detData extends StatefulWidget {
  final itemPenghuni? dataDet;
  const detData({Key? key, this.dataDet}) : super(key: key);

  @override
  State<detData> createState() => _detDataState();
}

class _detDataState extends State<detData> {

  final _ctrNama = TextEditingController();
  final _ctrNIK = TextEditingController();
  final _ctrNoHP = TextEditingController();
  final _ctrAlamat = TextEditingController();
  final _ctrNoKmr = TextEditingController();
  bool _isDisabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _ctrNama.dispose();
    _ctrNIK.dispose();
    _ctrNoHP.dispose();
    _ctrAlamat.dispose();
    _ctrNoKmr.dispose();
    super.dispose();
  } 
  @override
  void initState() {
    // TODO: implement initState
    _ctrNama.text = widget.dataDet?.itemNama ?? "";
    _ctrNIK.text = widget.dataDet?.itemNIK ?? "";
    _ctrNoHP.text = widget.dataDet?.itemNoHP ?? "";
    _ctrAlamat.text = widget.dataDet?.itemAlamat ?? "";
    _ctrNoKmr.text = widget.dataDet?.itemNoKmr ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.dataDet == null)
      _isDisabled = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Data Penghuni'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _ctrNama,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Nama',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _ctrNIK,
              enabled: _isDisabled,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan NIK',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _ctrNoHP,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan No HP',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _ctrAlamat,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Alamat',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _ctrNoKmr,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan No Kamar',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                final dt = itemPenghuni(itemNama: _ctrNama.text, itemNIK: _ctrNIK.text, itemNoHP: _ctrNoHP.text, itemAlamat: _ctrAlamat.text, itemNoKmr: _ctrNoKmr.text);
                DataBase.tambahData(item: dt);
                Navigator.pop(context);
              },
              child: Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }
}
