import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:pkg_player/src/view/detail/plugin_tags.dart';

import '../bloc/comments/comments_cubit.dart';
import '../bloc/comments/comments_state.dart';
import 'comments/comments_top_bar.dart';
import 'comments/comment_replies_page.dart';
import 'detail/detail_flexible_bar.dart';
import 'detail/comments_section.dart';
import 'detail/plugin_info_section.dart';
import 'detail/plugin_dependencies_section.dart';

class PluginDetailPage extends StatefulWidget {
  final PluginModel plugin;

  const PluginDetailPage({Key? key, required this.plugin}) : super(key: key);

  @override
  _PluginDetailPageState createState() => _PluginDetailPageState();
}

class _PluginDetailPageState extends State<PluginDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            centerTitle: true,
            backgroundColor: getDetailGradientColors(widget.plugin.name)[0],
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 16, top: 8),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: GestureDetector(
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PluginCardPage(plugin: widget.plugin),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0.0, 1.0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            )),
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 400),
                      ),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: DetailFlexibleBar(
              desc: widget.plugin.desc ?? '',
              name: widget.plugin.name,
              version: widget.plugin.lastVersion,
            ),
          ),
          SliverToBoxAdapter(
            child: PluginInfoSection(plugin: widget.plugin),
          ),
          if (widget.plugin.tags.isNotEmpty)
            SliverToBoxAdapter(
              child: PluginTags(
                tags: widget.plugin.tags,
              ),
            ),
          if (widget.plugin.tags.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: PluginDependenciesSection(
                    dependencies: widget.plugin.dependencies),
              ),
            ),
          SliverToBoxAdapter(
            child: CommentsTopBar(
              onTapComment: () => _showReplyInput(-1),
            ),
          ),
          CommentsSection(
            packageId: widget.plugin.id,
            packageName: widget.plugin.name,
            onReplay: _showReplyInput,
            onViewMoreDetail: _onViewMoreDetail,
          )
        ],
      ),
    );
  }

  final TextEditingController _commentController = TextEditingController();

  void _sendComment({int? parentId}) {
    if (_commentController.text.trim().isEmpty) return;
    String content = _commentController.text.trim();
    context.read<CommentsCubit>().sendComment(content, parentId: parentId);
    Navigator.pop(context);
  }

  void _showReplyInput(int parentId) {
    String hintText = parentId == -1 ? '写下你的评论...' : '回复评论...';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () => _sendComment(parentId: parentId),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      _commentController.clear();
    });
  }

  void _onViewMoreDetail(int commentId) {
    // 需要先获取评论对象，这里简化处理
    final currentState = context.read<CommentsCubit>().state;
    if (currentState is CommentsLoaded) {
      final comment = currentState.comments.data.firstWhere(
        (c) => c.id == commentId,
        orElse: () => Comment(
          id: commentId,
          packageId: widget.plugin.id!,
          userId: 0,
          guestName: '未知用户',
          content: '评论内容',
          contentType: 'text',
          createAt: DateTime.now().toString(),
          replies: [],
          repliesTotal: 0,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentRepliesPage(
            parentComment: comment,
          ),
        ),
      );
    }
  }
}
