import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  final String imgUrl, content, username, userPic, numLikes, numComments;
  final int date;
  const PostCard(
      {super.key,
      required this.imgUrl,
      required this.content,
      required this.date,
      required this.username,
      required this.userPic,
      required this.numLikes,
      required this.numComments});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userPic),
            ),
            title: Text(username),
            subtitle:
                Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(date))),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Text(
            content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.thumb_up),
              const SizedBox(
                width: 4.0,
              ),
              Text(numLikes),
              const SizedBox(
                width: 12.0,
              ),
              const Icon(Icons.comment),
              const SizedBox(
                width: 4.0,
              ),
              Text("$numComments Comments")
            ],
          )
        ],
      ),
    );
  }
}
