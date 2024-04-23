import 'package:api_uses/services/coment_model.dart';
import 'package:api_uses/services/post_services.dart';
import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key, required this.postId});
  final int? postId;

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  late final IPostService postService;
  bool _isLoading = false;
  List<CommentModel>? _commentItem;

  @override
  void initState() {
    super.initState();
    postService = PostService();
    fetchItemWithId(widget.postId ?? 0);
  }

  void _chanegeIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchItemWithId(int postId) async {
    _chanegeIsLoading();
    _commentItem = await postService.fetchRelatedCommentsWithPostId(postId);
    _chanegeIsLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: _commentItem?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(_commentItem?[index].name ?? ''),
                      Text(_commentItem?[index].email ?? ''),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
