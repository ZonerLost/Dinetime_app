import 'package:flutter/material.dart';


class DtNavItem {
  final String iconPath;
  final String label;
  const DtNavItem( this.iconPath, this.label);
}

class DtBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<DtNavItem> items;
  final Widget? child;

  const DtBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    final size        = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final w           = size.width;

    final isTiny   = w < 340;
    final isSmall  = w < 380;
    final isTablet = w >= 600;

    final double barHeight = isTablet ? 70 : (isSmall ? 62 : 62);
    final double iconSize  = isTablet ? 26 : (isSmall ? 20 : 22);
    final double fontSize  = isTablet ? 12.0 : (isTiny ? 10.0 : (isSmall ? 10.5 : 11.0));
    final double gap       = isSmall ? 4 : 6;

    return SizedBox(
      height: barHeight + bottomInset,
      width: double.infinity,
      child: ColoredBox(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _SpotlightPainter(
                        tabCount: items.length,
                        selected: currentIndex,
                      ),
                    ),
                  ),
                  child!

                ],
              ),
            ),
            if (bottomInset > 0) SizedBox(height: bottomInset),
          ],
        ),
      ),
    );
  }


}

class _SpotlightPainter extends CustomPainter {
  final int tabCount;
  final int selected;
  _SpotlightPainter({required this.tabCount, required this.selected});

  @override
  void paint(Canvas canvas, Size size) {
    if (tabCount <= 0) return;

    final tabW = size.width / tabCount;
    final cx   = (selected + 0.5) * tabW;

    final topY      = 0.0;
    final bottomY   = size.height;
    final halfTop   = tabW * 0.22;
    final halfBot   = tabW * 0.35;

    final path = Path()
      ..moveTo(cx - halfTop, topY)
      ..lineTo(cx + halfTop, topY)
      ..lineTo(cx + halfBot, bottomY)
      ..lineTo(cx - halfBot, bottomY)
      ..close();

    final grad = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x33FFFFFF),
        Color(0x1AFFFFFF),
        Color(0x0DFFFFFF),
        Color(0x00000000),
      ],
      stops: [0.0, 0.35, 0.7, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final paint = Paint()
      ..shader = grad
      ..isAntiAlias = true;

    canvas.drawPath(path, paint);

    final rim = Paint()
      ..color = const Color(0x22FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(cx - halfTop, topY + 0.5),
      Offset(cx + halfTop, topY + 0.5),
      rim,
    );
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) =>
      old.selected != selected || old.tabCount != tabCount;
}
