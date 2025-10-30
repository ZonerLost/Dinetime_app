// lib/Widgets/bio_widgets.dart
import 'package:flutter/material.dart';

Widget sectionTitle(String text) => Text(
  text,
  style: const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  ),
);

Widget pill(String label) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.10),
    borderRadius: BorderRadius.circular(999),
    border: Border.all(color: Colors.white24, width: 0.8),
  ),
  child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
);

class PhotoGrid extends StatelessWidget {
  final List<String> photos;
  final int crossAxisCount;
  const PhotoGrid({super.key, required this.photos, this.crossAxisCount = 2});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: photos.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.2,
      ),
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(photos[i], fit: BoxFit.cover),
      ),
    );
  }
}

class FollowTile extends StatelessWidget {
  final String name;
  final String handle;
  final String avatar;
  const FollowTile({super.key, required this.name, required this.handle, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(999), child: Image.asset(avatar, width: 36, height: 36, fit: BoxFit.cover)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          Text(handle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.10), borderRadius: BorderRadius.circular(8)),
          child: const Text('Following', style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }
}
