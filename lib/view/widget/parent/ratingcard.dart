import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:flutter/material.dart';

class RatingCardWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  RatingCardWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: const AssetImage(AppImageassets.profileimage)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(data["time"], style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              
              children: List.generate(
                5,
                (index) => Icon(
                  index < data["stars"] ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(data["text"]),
            SizedBox(height: 8,)
          ],
        ),
      ),
    );
  }
}