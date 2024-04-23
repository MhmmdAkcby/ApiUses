import 'package:api_uses/services/post_model.dart';
import 'package:api_uses/services/post_services.dart';
import 'package:api_uses/widget/comment_view.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  List<PostModel>? _items;
  bool _isLoading = false;
  late final IPostService _postService;
  final String appbarName = 'Api Services Data';

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    fetchPostItemsAdvance();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItemsAdvance() async {
    _changeLoading();

    _items = await _postService.fetchPostItemsAdvance();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarName),
        actions: [_isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()],
      ),
      body: _items == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return _PostCards(model: _items?[index]);
              },
            ),
    );
  }
}

class _PostCards extends StatelessWidget {
  const _PostCards({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommentView(postId: _model?.id),
          ));
        },
        title: Text(_model?.title ?? ''),
        subtitle: Text(_model?.body ?? ''),
      ),
    );
  }
}
