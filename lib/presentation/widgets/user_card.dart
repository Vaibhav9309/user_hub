import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onTap;
  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(user.avatar),
          radius: 22,
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.w800,color: Color(0xFF212121)),
        ),
        subtitle: Text(user.email,style: TextStyle(color: Color(0xFF747d87)),),
        onTap: onTap,
      ),
    );
  }
}
