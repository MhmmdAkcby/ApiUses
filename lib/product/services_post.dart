import 'dart:io';

import 'package:api_uses/core/project_padding.dart';
import 'package:api_uses/services/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ServicesPost extends StatefulWidget {
  const ServicesPost({Key? key}) : super(key: key);

  @override
  State<ServicesPost> createState() => _ServicesPostState();
}

class _ServicesPostState extends State<ServicesPost> {
  String? _appBarName;
  late final Dio _dio;
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<void> _addItemToServices(PostModel postModel) async {
    try {
      final response = await _dio.post('/posts', data: postModel.toJson());

      if (response.statusCode == HttpStatus.created) {
        setState(() {
          _appBarName = 'Başarılı';
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarName ?? ''),
      ),
      body: Padding(
        padding: ProjectPadding.normalPadding,
        child: SizedBox(
          height: _ItemNumbers().textFieldNumber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              ),
              TextField(
                controller: _bodyController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Body', border: OutlineInputBorder()),
              ),
              TextField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'User Id', border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _bodyController.text.isNotEmpty &&
                      _userIdController.text.isNotEmpty) {
                    final model = PostModel(
                      body: _bodyController.text,
                      title: _titleController.text,
                      userId: int.tryParse(_userIdController.text) ?? 0,
                    );
                    _addItemToServices(model);
                  }
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemNumbers {
  final double textFieldNumber = 250;
}
