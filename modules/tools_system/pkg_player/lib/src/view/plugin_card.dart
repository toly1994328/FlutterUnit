import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';
import 'dart:math' as math;

class PluginCard extends StatefulWidget {
  final PluginModel plugin;

  const PluginCard({Key? key, required this.plugin}) : super(key: key);

  @override
  _PluginCardState createState() => _PluginCardState();
}

class _PluginCardState extends State<PluginCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _glowController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _glowController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _glowController.dispose();
    super.dispose();
  }

  List<Color> _getGradientColors() {
    final colorSets = [
      [Color(0xFF667eea), Color(0xFF764ba2)], // 紫蓝渐变
      [Color(0xFFf093fb), Color(0xFFf5576c)], // 粉红渐变
      [Color(0xFF4facfe), Color(0xFF00f2fe)], // 蓝青渐变
      [Color(0xFF43e97b), Color(0xFF38f9d7)], // 绿青渐变
      [Color(0xFFfa709a), Color(0xFFfee140)], // 粉黄渐变
      [Color(0xFFa8edea), Color(0xFFfed6e3)], // 青粉渐变
      [Color(0xFFff9a9e), Color(0xFFfecfef)], // 珊瑚渐变
      [Color(0xFF667eea), Color(0xFF764ba2)], // 深紫渐变
    ];
    final hash = widget.plugin.name.hashCode.abs();
    return colorSets[hash % colorSets.length];
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getGradientColors();
    
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _glowController]),
      builder: (context, child) {
        return Container(
          width: 350,
          height: 500,
          child: Stack(
            children: [
              // 外层发光效果
              AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors[0].withOpacity(0.4 * _glowAnimation.value),
                          blurRadius: 30 * _glowAnimation.value,
                          spreadRadius: 5 * _glowAnimation.value,
                        ),
                        BoxShadow(
                          color: gradientColors[1].withOpacity(0.3 * _glowAnimation.value),
                          blurRadius: 50 * _glowAnimation.value,
                          spreadRadius: 2 * _glowAnimation.value,
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              // 主卡片
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              
              // 旋转的装饰环
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // 旋转光点
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // 几何装饰
              Positioned(
                top: -30,
                right: -30,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 0.5,
                  child: Container(
                    width: 120,
                    height: 120,
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
              
              // 底部装饰
              Positioned(
                bottom: -40,
                left: -40,
                child: Transform.rotate(
                  angle: -_rotationAnimation.value * 0.3,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
              ...List.generate(5, (index) {
                final angle = (index * 2 * math.pi / 5) + _rotationAnimation.value * 2;
                final radius = 80 + math.sin(_rotationAnimation.value * 3 + index) * 20;
                return Positioned(
                  left: 175 + math.cos(angle) * radius,
                  top: 250 + math.sin(angle) * radius,
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.6 + 0.4 * math.sin(_rotationAnimation.value * 4 + index)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                );
              }),
          
              // 内容
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 头部
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Colors.white, Colors.white70],
                            ).createShader(bounds),
                            child: Icon(
                              Icons.extension,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'v${widget.plugin.lastVersion}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                
                SizedBox(height: 24),
                
                    // 包名
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.white, Colors.white70],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        widget.plugin.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                
                SizedBox(height: 16),
                
                    // 描述
                    Text(
                      widget.plugin.desc ?? '暂无描述',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                
                Spacer(),
                
                    // 统计数据
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.25),
                            Colors.white.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(Icons.favorite, _formatNumber(widget.plugin.statistics.likes)),
                          _buildStatItem(Icons.star, _formatNumber(widget.plugin.statistics.points)),
                          _buildStatItem(Icons.download, _formatNumber(widget.plugin.statistics.downloads)),
                        ],
                      ),
                    ),
                
                SizedBox(height: 16),
                
                    // 标签
                    if (widget.plugin.tags.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.plugin.tags.take(3).map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.15),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: 16),
                    ],
                
                    // 发布者信息
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.white.withOpacity(0.9), size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.plugin.publisher ?? '未知发布者',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
              // Flutter logo 水印
              Positioned(
                bottom: 16,
                right: 16,
                child: Transform.rotate(
                  angle: math.sin(_rotationAnimation.value * 2) * 0.1,
                  child: Opacity(
                    opacity: 0.15 + 0.05 * math.sin(_rotationAnimation.value * 3),
                    child: FlutterLogo(
                      size: 40,
                      style: FlutterLogoStyle.stacked,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}