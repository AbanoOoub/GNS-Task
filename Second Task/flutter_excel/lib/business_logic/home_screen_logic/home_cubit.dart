import 'package:bloc/bloc.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Product> products = [];
  String fileName = '';
  Map<String, double> ans1 = {};
  Map<String, String> ans2 = {};

  void readExcelFile({required String fileName}) async {
    this.fileName = fileName;

    ByteData data = await rootBundle.load("assets/$fileName.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        Product product = Product(row[0]!.value, row[1]!.value, row[2]!.value,
            row[3]!.value, row[4]!.value);
        products.add(product);
      }
    }
    emit(ReadFilesSucessState());
  }

  void solve() {
    int soledItem = 0;
    for (int j = 0; j < products.length; j++) {
      String selectedProductName = products[j].name!;

      if (ans2.containsKey(selectedProductName) == false) {
        ans2[selectedProductName] = products[j].brand!;
      }

      for (int i = 1; i < products.length; i++) {
        if (products[i].name == products[j].name && j == 0 && i == 1) {
          soledItem = products[i].quantity! + products[j].quantity!;
        } else if (products[i].name == products[j].name) {
          soledItem += products[i].quantity!;
        }
      }
      if (ans1.containsKey(selectedProductName) == false) {
        ans1[selectedProductName] = soledItem / products.length;
      }
      soledItem = 0;
    }
    emit(SolveSuccessState());
  }


  void saveExcelFiles() {
    saveFirstFile();
    saveSecondFile();
    emit(SavedFilesSuccessState());
  }

  void saveFirstFile() {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    int cnt = 1;

    ans1.forEach((key, value) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A$cnt"));
      var cell2 = sheetObject.cell(CellIndex.indexByString("B$cnt"));
      cell1.value = key;
      cell2.value = value;
      cnt++;
    });
    excel.save(fileName: "0_$fileName.xlsx");
  }

  void saveSecondFile() {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    int cnt = 1;

    ans2.forEach((key, value) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A$cnt"));
      var cell2 = sheetObject.cell(CellIndex.indexByString("B$cnt"));
      cell1.value = key;
      cell2.value = value;
      cnt++;
    });
    excel.save(fileName: "1_$fileName.xlsx");
  }

}
