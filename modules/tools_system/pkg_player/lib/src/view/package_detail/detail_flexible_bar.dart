import 'dart:math' as math;

import 'package:flutter/material.dart';

class DetailFlexibleBar extends StatefulWidget {
  final String name;
  final String desc;
  final String version;

  const DetailFlexibleBar(
      {super.key,
      required this.name,
      required this.version,
      required this.desc});

  @override
  State<DetailFlexibleBar> createState() => _DetailFlexibleBarState();
}

class _DetailFlexibleBarState extends State<DetailFlexibleBar>
    with TickerProviderStateMixin {
  late Animation<double> _rotationAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      titlePadding: EdgeInsets.only(bottom: 8),
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.white, Colors.white70],
        ).createShader(bounds),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(1, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.desc,
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
            )
          ],
        ),
      ),
      background: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              // 渐变背景
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: getDetailGradientColors(widget.name),
                  ),
                ),
              ),

              // 旋转装饰环
              Positioned.fill(
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 动态装饰元素
              Positioned(
                top: -50,
                right: -50,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 0.5,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: -30,
                left: -30,
                child: Transform.rotate(
                  angle: -_rotationAnimation.value * 0.3,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // 闪烁粒子效果
              ...List.generate(3, (index) {
                final angle =
                    (index * 2 * math.pi / 3) + _rotationAnimation.value * 2;
                final radius =
                    60 + math.sin(_rotationAnimation.value * 3 + index) * 15;
                return Positioned(
                  left: MediaQuery.of(context).size.width / 2 +
                      math.cos(angle) * radius,
                  top: 90 + math.sin(angle) * radius,
                  child: Container(
                    width: 2,
                    height: 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.6 +
                          0.4 * math.sin(_rotationAnimation.value * 4 + index)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // 中心内容
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'v${widget.version}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<Color> getDetailGradientColors(String name) {
  final colorSets = [
    [Color(0xFF667eea), Color(0xFF764ba2)], // 紫蓝渐变
    [Color(0xFF667eea), Color(0xFF764ba2)], // 深紫渐变
  ];
  final hash = name.hashCode.abs();
  return colorSets[hash % colorSets.length];
}
