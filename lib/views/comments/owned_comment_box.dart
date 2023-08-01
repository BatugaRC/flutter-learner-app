import 'package:flutter/material.dart';
import 'package:learner_app/utilities/random_color.dart';
import 'package:learner_app/views/comments/edit_comment.dart';

class OwnedCommentBox extends StatelessWidget {
  final String commentId;
  final String commenter;
  final String content;
  const OwnedCommentBox(
      {super.key,
      required this.commenter,
      required this.content,
      required this.commentId});

  @override
  Widget build(BuildContext context) {
    Color color = getRandomColor();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: Center(
                        child: Text(
                          commenter[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      commenter,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return EditCommentForm(
                              commentId: commentId,
                              comment: content,
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.cyan,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(content),
          ],
        ),
      ),
    );
  }
}
