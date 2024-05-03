/*import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class AddProd extends StatefulWidget {
  final String taskId;

  const AddProd({Key? key, required this.taskId}) : super(key: key);

  @override
  State<AddProd> createState() => _AddProdState();
}

class _AddProdState extends State<AddProd> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _descController = TextEditingController();
  late TextEditingController _idController = TextEditingController();
  late TextEditingController _ratingController = TextEditingController();
  late TextEditingController _priceController = TextEditingController();
  late TextEditingController _categoryController = TextEditingController();
  late TextEditingController _brandController = TextEditingController();
  late TextEditingController _barcodeController = TextEditingController();
  late TextEditingController _colorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double textFieldBottomPadding = 30;
  List<String> images = [];

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    FormData formData = FormData.fromMap({
      'task_id': widget.taskId.toString(),
      'name': _nameController.text,
      'description': _descController.text,
      'rating': _ratingController.text,
      'barcode': _barcodeController.text,
      'price': _priceController.text,
      'brand': _brandController.text,
      'color': _colorController.text,
      'category': _categoryController.text,
    });

    Dio dio = Dio();
    dio.options.connectTimeout = 20000;

    try {
      Response response = await dio.post(
        Urls.thirdPartyPurchaseAdd,
        options: Options(
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "authorization": token,
          },
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        if (response.data['status'] == true) {
          print(response.data['message']);
        } else {
          print(response.data['message']);
        }
      }
    } on DioError catch (ex) {
      if (ex.response!.data['message'] != '') {
        print("Error Exception :: ${ex.response!.data['message']}");
      }
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception("Connection Timeout Exception");
      }
    }
  }

 void initstate() {
super.initState();
//_dateController.text = DateTime.now().toString().split(' ')[0];
;}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Your App Title'),
    ),
    body:const  Center(
      child: Text('Your Widget Content Here'),
    ),
  );
}}*/
/* @override
  void initState() {
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _idController = TextEditingController();
    _ratingController = TextEditingController();
    _priceController = TextEditingController();
    _categoryController = TextEditingController();
    _brandController = TextEditingController();
    _barcodeController = TextEditingController();
    _colorController = TextEditingController();
    super.initState();
  }

  //libere l'espace memoire
  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _idController.dispose();
    _ratingController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _colorController.dispose();
    super.dispose();
  }*/