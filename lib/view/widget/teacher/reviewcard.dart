import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Arabic layout
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Name, Image
            Row(
              children: [
                /// Name & Stars
                 CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(AppImageassets.profileimage), // Replace with actual asset
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "محمد خليل",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         
                          SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Icon(Icons.star_border, color: Colors.grey, size: 18),
                        ],
                      )
                    ],
                  ),
                ),

                /// Profile Image
               
              ],
            ),

            SizedBox(height: 16),

            /// Comment
            Text(
              "استاذ رائع بكل معنى الكلمة له طريقة تعليم خاصة مع الطلاب واسلوب مقنع",
              style: TextStyle(fontSize: 14),
            ),
           

            SizedBox(height: 20),

            /// Like/Dislike Row
            Row(
              children: [
                /// Like
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, color: Colors.purple),
                    SizedBox(width: 4),
                    Text(
                      "30",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ],
                ),

                SizedBox(width: 20),

                /// Dislike
                Row(
                  children: [
                    Icon(Icons.thumb_down_alt_outlined, color: Colors.purple),
                    SizedBox(width: 4),
                    Text(
                      "55",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                Spacer(),

                /// Time (top left)
                Text(
                  "منذ يومين",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      
    
    );
  }
}
