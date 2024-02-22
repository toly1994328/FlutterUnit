import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @widgetCollection.
  ///
  /// In zh, this message translates to:
  /// **'组件集录'**
  String get widgetCollection;

  /// No description provided for @paintCollection.
  ///
  /// In zh, this message translates to:
  /// **'绘制集录'**
  String get paintCollection;

  /// No description provided for @knowledgeCollection.
  ///
  /// In zh, this message translates to:
  /// **'知识集锦'**
  String get knowledgeCollection;

  /// No description provided for @treasureTools.
  ///
  /// In zh, this message translates to:
  /// **'工具宝箱'**
  String get treasureTools;

  /// No description provided for @collectCollection.
  ///
  /// In zh, this message translates to:
  /// **'收藏集录'**
  String get collectCollection;

  /// No description provided for @essentialCollection.
  ///
  /// In zh, this message translates to:
  /// **'要点集录'**
  String get essentialCollection;

  /// No description provided for @homeAccount.
  ///
  /// In zh, this message translates to:
  /// **'应用信息'**
  String get homeAccount;

  /// No description provided for @homeAccountTabInfo.
  ///
  /// In zh, this message translates to:
  /// **'关于应用'**
  String get homeAccountTabInfo;

  /// No description provided for @homeAccountTabMe.
  ///
  /// In zh, this message translates to:
  /// **'联系本王'**
  String get homeAccountTabMe;

  /// No description provided for @homeAccountSupport.
  ///
  /// In zh, this message translates to:
  /// **'支持项目'**
  String get homeAccountSupport;

  /// No description provided for @searchWidget.
  ///
  /// In zh, this message translates to:
  /// **'搜索组件'**
  String get searchWidget;

  /// No description provided for @stateless.
  ///
  /// In zh, this message translates to:
  /// **'无态'**
  String get stateless;

  /// No description provided for @stateful.
  ///
  /// In zh, this message translates to:
  /// **'有态'**
  String get stateful;

  /// No description provided for @single.
  ///
  /// In zh, this message translates to:
  /// **'单渲'**
  String get single;

  /// No description provided for @multi.
  ///
  /// In zh, this message translates to:
  /// **'多渲'**
  String get multi;

  /// No description provided for @sliver.
  ///
  /// In zh, this message translates to:
  /// **'滑片'**
  String get sliver;

  /// No description provided for @proxy.
  ///
  /// In zh, this message translates to:
  /// **'代理'**
  String get proxy;

  /// No description provided for @other.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get other;

  /// No description provided for @homeTabWidget.
  ///
  /// In zh, this message translates to:
  /// **'组件'**
  String get homeTabWidget;

  /// No description provided for @homeTabPaint.
  ///
  /// In zh, this message translates to:
  /// **'绘制'**
  String get homeTabPaint;

  /// No description provided for @homeTabKnowledge.
  ///
  /// In zh, this message translates to:
  /// **'知识'**
  String get homeTabKnowledge;

  /// No description provided for @homeTabTools.
  ///
  /// In zh, this message translates to:
  /// **'工具'**
  String get homeTabTools;

  /// No description provided for @homeTabMine.
  ///
  /// In zh, this message translates to:
  /// **'我的'**
  String get homeTabMine;

  /// No description provided for @dataManagement.
  ///
  /// In zh, this message translates to:
  /// **'数据管理'**
  String get dataManagement;

  /// No description provided for @userCollection.
  ///
  /// In zh, this message translates to:
  /// **'我的收藏'**
  String get userCollection;

  /// No description provided for @aboutApplications.
  ///
  /// In zh, this message translates to:
  /// **'关于应用'**
  String get aboutApplications;

  /// No description provided for @contactThisKing.
  ///
  /// In zh, this message translates to:
  /// **'联系本王'**
  String get contactThisKing;

  /// No description provided for @appSettings.
  ///
  /// In zh, this message translates to:
  /// **'应用设置'**
  String get appSettings;

  /// No description provided for @darkMode.
  ///
  /// In zh, this message translates to:
  /// **'深色模式'**
  String get darkMode;

  /// No description provided for @themeColorSetting.
  ///
  /// In zh, this message translates to:
  /// **'主题色设置'**
  String get themeColorSetting;

  /// No description provided for @fontSetting.
  ///
  /// In zh, this message translates to:
  /// **'字体设置'**
  String get fontSetting;

  /// No description provided for @settingLanguageText.
  ///
  /// In zh, this message translates to:
  /// **'多语言'**
  String get settingLanguageText;

  /// No description provided for @codeHighlightStyle.
  ///
  /// In zh, this message translates to:
  /// **'代码高亮样式'**
  String get codeHighlightStyle;

  /// No description provided for @versionInformation.
  ///
  /// In zh, this message translates to:
  /// **'版本信息'**
  String get versionInformation;

  /// No description provided for @displayPerformanceFloatingLayer.
  ///
  /// In zh, this message translates to:
  /// **'显示性能浮层'**
  String get displayPerformanceFloatingLayer;

  /// No description provided for @showFloatingTools.
  ///
  /// In zh, this message translates to:
  /// **'显示浮动工具'**
  String get showFloatingTools;

  /// No description provided for @followSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get followSystem;

  /// No description provided for @afterOpeningWillFollowTheSystemToOpenOrCloseDarkMode.
  ///
  /// In zh, this message translates to:
  /// **'开启后,将跟随系统打开或关闭深色模式'**
  String get afterOpeningWillFollowTheSystemToOpenOrCloseDarkMode;

  /// No description provided for @manualSetting.
  ///
  /// In zh, this message translates to:
  /// **'手动设置'**
  String get manualSetting;

  /// No description provided for @lightMode.
  ///
  /// In zh, this message translates to:
  /// **'浅色模式'**
  String get lightMode;

  /// No description provided for @settingLanguage.
  ///
  /// In zh, this message translates to:
  /// **'设置语言'**
  String get settingLanguage;

  /// No description provided for @appDetails.
  ///
  /// In zh, this message translates to:
  /// **'应用详情'**
  String get appDetails;

  /// No description provided for @checkUpdate.
  ///
  /// In zh, this message translates to:
  /// **'检查新版本'**
  String get checkUpdate;

  /// No description provided for @downloadNewVersion.
  ///
  /// In zh, this message translates to:
  /// **'下载新版本'**
  String get downloadNewVersion;

  /// No description provided for @downloadingNewVersion.
  ///
  /// In zh, this message translates to:
  /// **'新版本下载中...'**
  String get downloadingNewVersion;

  /// No description provided for @currentIsNew.
  ///
  /// In zh, this message translates to:
  /// **'当前应用已是最新版本!'**
  String get currentIsNew;

  /// No description provided for @checkDatabaseNewVersion.
  ///
  /// In zh, this message translates to:
  /// **'检查数据库新版本'**
  String get checkDatabaseNewVersion;

  /// No description provided for @viewThisProjectGithubRepository.
  ///
  /// In zh, this message translates to:
  /// **'《查看本项目Github仓库》'**
  String get viewThisProjectGithubRepository;

  /// No description provided for @favorite.
  ///
  /// In zh, this message translates to:
  /// **'已收藏'**
  String get favorite;

  /// No description provided for @enterComponentName.
  ///
  /// In zh, this message translates to:
  /// **'输入组件名称'**
  String get enterComponentName;

  /// No description provided for @containerComponents.
  ///
  /// In zh, this message translates to:
  /// **'容器组件'**
  String get containerComponents;

  /// No description provided for @componentTavern.
  ///
  /// In zh, this message translates to:
  /// **'组件酒肆'**
  String get componentTavern;

  /// No description provided for @cherishedComponents.
  ///
  /// In zh, this message translates to:
  /// **'珍藏组件'**
  String get cherishedComponents;

  /// No description provided for @textImageCollection.
  ///
  /// In zh, this message translates to:
  /// **'图文集'**
  String get textImageCollection;

  /// No description provided for @layoutCollection.
  ///
  /// In zh, this message translates to:
  /// **'布局集'**
  String get layoutCollection;

  /// No description provided for @eventCollection.
  ///
  /// In zh, this message translates to:
  /// **'事件集'**
  String get eventCollection;

  /// No description provided for @animationCollection.
  ///
  /// In zh, this message translates to:
  /// **'动画集'**
  String get animationCollection;

  /// No description provided for @slidingCollection.
  ///
  /// In zh, this message translates to:
  /// **'滑动集'**
  String get slidingCollection;

  /// No description provided for @decorationCollection.
  ///
  /// In zh, this message translates to:
  /// **'装饰集'**
  String get decorationCollection;

  /// No description provided for @assemblyCollection.
  ///
  /// In zh, this message translates to:
  /// **'组装集'**
  String get assemblyCollection;

  /// No description provided for @functionCollection.
  ///
  /// In zh, this message translates to:
  /// **'功能集'**
  String get functionCollection;

  /// No description provided for @popupCollection.
  ///
  /// In zh, this message translates to:
  /// **'弹出集'**
  String get popupCollection;

  /// No description provided for @themeCollection.
  ///
  /// In zh, this message translates to:
  /// **'主题集'**
  String get themeCollection;

  /// No description provided for @derivativeCollection.
  ///
  /// In zh, this message translates to:
  /// **'衍生集'**
  String get derivativeCollection;

  /// No description provided for @hardToCategorize.
  ///
  /// In zh, this message translates to:
  /// **'很难分'**
  String get hardToCategorize;

  /// No description provided for @basicDrawing.
  ///
  /// In zh, this message translates to:
  /// **'基础绘制'**
  String get basicDrawing;

  /// No description provided for @basicDrawingDesc.
  ///
  /// In zh, this message translates to:
  /// **'收录一些基础图形绘制案例，这些案例对初涉绘制的编程者会非常友好。通过这些案例，可以学会点、线、矩形、圆、圆弧、文字、图片等基本图形的绘制方法，了解 Canvas、Paint、Path 等绘制中核心对象的使用。'**
  String get basicDrawingDesc;

  /// No description provided for @animationGesture.
  ///
  /// In zh, this message translates to:
  /// **'动画手势'**
  String get animationGesture;

  /// No description provided for @animationGestureDesc.
  ///
  /// In zh, this message translates to:
  /// **'收录一些动画和手势的绘制案例，这些案例会让绘制更具有操作性。通过这些案例，可以学会动画和手势的使用，如滑动、旋转、缩放、移动等效果，让绘制不再只是静态展现。'**
  String get animationGestureDesc;

  /// No description provided for @particleDrawing.
  ///
  /// In zh, this message translates to:
  /// **'粒子绘制'**
  String get particleDrawing;

  /// No description provided for @particleDrawingDesc.
  ///
  /// In zh, this message translates to:
  /// **'收录一些粒子相关的绘制案例，这些案例将是绘制的顶级操作。通过这些案例，可以学会如何使用粒子来绘制惊艳的视觉效果，如粒子时钟、粒子爆炸、粒子背景等效果，让绘制拥有无限可能。'**
  String get particleDrawingDesc;

  /// No description provided for @interestingDrawing.
  ///
  /// In zh, this message translates to:
  /// **'趣味绘制'**
  String get interestingDrawing;

  /// No description provided for @interestingDrawingDesc.
  ///
  /// In zh, this message translates to:
  /// **'收录一些比较有趣的绘制案例，让我们一起在这里一起体验绘制的乐趣、编程的乐趣和智慧的乐趣吧。'**
  String get interestingDrawingDesc;

  /// No description provided for @artGallery.
  ///
  /// In zh, this message translates to:
  /// **'艺术画廊'**
  String get artGallery;

  /// No description provided for @artGalleryDesc.
  ///
  /// In zh, this message translates to:
  /// **'收录一些殿堂级的绘制案例，这些案例将是绘制的巅峰作品，它们的没有任何的实用性，也不为任何需求而生，它们仅是因为存在而存在，是人类智慧和表达的媒介，称谓艺术。'**
  String get artGalleryDesc;

  /// No description provided for @drawingOfImages.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何进行图片的绘制: 通过加载图片并将图片资源绘制到指定的区域。在上层绘制一批 45”倾角的栅格线，来练习线条的绘制 '**
  String get drawingOfImages;

  /// No description provided for @digitalDisplayTube.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何绘制 LED 数字显示管，以此练习对路径 Path 的使用、变换、组合，以及组件封装的知识。是一个非常好的绘制案例 '**
  String get digitalDisplayTube;

  /// No description provided for @pathDrawing.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何进行简单的路径绘制，以及画板的旋转，再结合动画让风车旋转。这是一个非常精简的绘制与动画结合的案例。 '**
  String get pathDrawing;

  /// No description provided for @gridCoordinateSystem.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何使用线路径和文字绘制网格坐标系，并将绘制对象进行封装，方便重用。坐标系也会在绘制时提供参考，入门必备。 '**
  String get gridCoordinateSystem;

  /// No description provided for @polarCoordinateSystemOfFaces.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何使用绘制平面的极坐标系，并根据函数方程收集极坐标进行绘制。 '**
  String get polarCoordinateSystemOfFaces;

  /// No description provided for @drawFunctionCurvesForPathPairs.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何使用路径对函数曲线进行绘制，通过函数曲线上的少量点通过贝塞尔曲线进行拟合。 '**
  String get drawFunctionCurvesForPathPairs;

  /// No description provided for @drawRegularPolygons.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何在圆中收集点位，绘制正多边形，是练习绘制及形成路径的很好案例。\n特殊操作：+、- 修改边数'**
  String get drawRegularPolygons;

  /// No description provided for @randomNumberProcessing.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。可以练习对数据的控制能力。'**
  String get randomNumberProcessing;

  /// No description provided for @clockDrawing.
  ///
  /// In zh, this message translates to:
  /// **'本样例通过时钟的绘制，练习 Flutter 中旋转刻度类型的绘制技巧，并通过动画使表盘指针转动。'**
  String get clockDrawing;

  /// No description provided for @drawSprings.
  ///
  /// In zh, this message translates to:
  /// **' 本样例介绍如何绘制弹簧，通过触点竖直拖拽拉伸、压缩，放手时进行恢复动画，是一个很好的综合小案例。特殊操作:上下拖拽伸缩弹簧 '**
  String get drawSprings;

  /// No description provided for @theApplicationOfAnglesInDrawing.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何根据以某个点为中心，进行旋转运动。以此学习两点间的角度在绘制中的应用。\n特殊操作：点击运行'**
  String get theApplicationOfAnglesInDrawing;

  /// No description provided for @usingShadersAndFilters.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何在绘制中使用着色器和过滤器，并通过动画进行数值变化达到旋转流光效果。'**
  String get usingShadersAndFilters;

  /// No description provided for @pathDrawingFunctionCurve.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何使用路径绘制函数曲线，并使用路径测量进行动画'**
  String get pathDrawingFunctionCurve;

  /// No description provided for @thePathOfBingDwenDwen.
  ///
  /// In zh, this message translates to:
  /// **'本样例会绘制 2022 年北京冬奥会吉祥物冰墩墩的路径，并使用路径测量进行动画。\n特殊操作：点击运行'**
  String get thePathOfBingDwenDwen;

  /// No description provided for @drawCubicBesselCurve.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何绘制三次贝塞尔曲线，通过触点判断某点是否激活，据此控制点的位置达到拖动控制效果。\n特殊操作：单击绘点，双击清除'**
  String get drawCubicBesselCurve;

  /// No description provided for @theEffectOfAnimationCurve.
  ///
  /// In zh, this message translates to:
  /// **'本样例通过直观的方式，来查看动画曲线 curve 的作用效果，让大家对动画有更深的理解。\n特殊操作：点击运行'**
  String get theEffectOfAnimationCurve;

  /// No description provided for @randomParticlesAndBoundaryBouncing.
  ///
  /// In zh, this message translates to:
  /// **' 本样例介绍如何创建随机粒子及边界反弹逻辑处理，是学习粒子运动非常好的入门案例特殊操作:单击停止/运行 '**
  String get randomParticlesAndBoundaryBouncing;

  /// No description provided for @particleCollision.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍如何对个粒子进行碰撞检测，并分裂处多个粒子，是一个比较有趣的案例。\n特殊操作：单击重置'**
  String get particleCollision;

  /// No description provided for @particle.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍将图片使用粒子表示，并对粒子进行动画处理，达到爆炸的效果。\n特殊操作：单击运行'**
  String get particle;

  /// No description provided for @rectangleAndRandomNumbers.
  ///
  /// In zh, this message translates to:
  /// **'本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。可以练习对数据的控制能力。\n特殊操作：点击随机生成'**
  String get rectangleAndRandomNumbers;

  /// No description provided for @bingDwenDwen.
  ///
  /// In zh, this message translates to:
  /// **'本样例是绘制 2022 年北京冬奥会吉祥物冰墩墩的形体，从中可以学到路径绘制、渐变色等知识。'**
  String get bingDwenDwen;

  /// No description provided for @pufengInjectionTest.
  ///
  /// In zh, this message translates to:
  /// **'本样实现蒲丰投针试验的测试过程，根据概率来估算圆周率。其中可以学习到一些绘制小技巧已经数据的逻辑处理。'**
  String get pufengInjectionTest;

  /// No description provided for @ticTacToe.
  ///
  /// In zh, this message translates to:
  /// **'本例通过井字棋的绘制与逻辑校验，集合了手势、绘制、动画、校验等重要的技能，是一个非常好的联系案例。\n特殊操作：双击重置'**
  String get ticTacToe;

  /// No description provided for @tiledLines.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的tiled-lines,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get tiledLines;

  /// No description provided for @joyDivision.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的joy-division,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get joyDivision;

  /// No description provided for @cubicDisarray.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的cubic-disarray,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get cubicDisarray;

  /// No description provided for @triangularMesh.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的triangular-mesh,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get triangularMesh;

  /// No description provided for @unDeuxTrois.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的un-deux-trois,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get unDeuxTrois;

  /// No description provided for @circlePacking.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的circle-packing,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get circlePacking;

  /// No description provided for @hypnoticSquares.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的hypnotic-squares,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get hypnoticSquares;

  /// No description provided for @pietMondrian.
  ///
  /// In zh, this message translates to:
  /// **'本样例根源来自generativeartistry.com的piet-mondrian,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry'**
  String get pietMondrian;

  /// No description provided for @downloadCompressedPackage.
  ///
  /// In zh, this message translates to:
  /// **'使用方式:\n1. 在 iconfont.cn 挑选图标，加入项目，下载压缩包。\n2. 选择 Flutter 项目地址，配置资源、产物文件位置。\n3. 点击生成代码按钮，即可生成相关代码。'**
  String get downloadCompressedPackage;

  /// No description provided for @qAIssues.
  ///
  /// In zh, this message translates to:
  /// **'要点集录中的 QA 数据收录rUnit 以 point 为标签的 issues 中。如果需要提供数据，在 issues 中问答即可。'**
  String get qAIssues;

  /// No description provided for @tips.
  ///
  /// In zh, this message translates to:
  /// **'注:'**
  String get tips;

  /// No description provided for @visualSorting.
  ///
  /// In zh, this message translates to:
  /// **'可视化排序'**
  String get visualSorting;

  /// No description provided for @visual.
  ///
  /// In zh, this message translates to:
  /// **'可视排序'**
  String get visual;

  /// No description provided for @insertion.
  ///
  /// In zh, this message translates to:
  /// **'插入排序'**
  String get insertion;

  /// No description provided for @bubble.
  ///
  /// In zh, this message translates to:
  /// **'冒泡排序'**
  String get bubble;

  /// No description provided for @cocktail.
  ///
  /// In zh, this message translates to:
  /// **'鸡尾酒排序(双向冒泡排序)'**
  String get cocktail;

  /// No description provided for @comb.
  ///
  /// In zh, this message translates to:
  /// **'梳排序'**
  String get comb;

  /// No description provided for @pigeonHole.
  ///
  /// In zh, this message translates to:
  /// **'鸽巢排序'**
  String get pigeonHole;

  /// No description provided for @shell.
  ///
  /// In zh, this message translates to:
  /// **'希尔排序'**
  String get shell;

  /// No description provided for @selection.
  ///
  /// In zh, this message translates to:
  /// **'选择排序'**
  String get selection;

  /// No description provided for @gnome.
  ///
  /// In zh, this message translates to:
  /// **'侏儒排序'**
  String get gnome;

  /// No description provided for @cycle.
  ///
  /// In zh, this message translates to:
  /// **'循环排序'**
  String get cycle;

  /// No description provided for @heap.
  ///
  /// In zh, this message translates to:
  /// **'堆排序'**
  String get heap;

  /// No description provided for @quick.
  ///
  /// In zh, this message translates to:
  /// **'快速排序'**
  String get quick;

  /// No description provided for @merge.
  ///
  /// In zh, this message translates to:
  /// **'归并排序'**
  String get merge;

  /// No description provided for @sortingAlgorithmConfiguration.
  ///
  /// In zh, this message translates to:
  /// **'排序算法配置'**
  String get sortingAlgorithmConfiguration;

  /// No description provided for @dataCount.
  ///
  /// In zh, this message translates to:
  /// **'数据数量(个数)'**
  String get dataCount;

  /// No description provided for @timeInterval.
  ///
  /// In zh, this message translates to:
  /// **'时间间隔(微秒)'**
  String get timeInterval;

  /// No description provided for @randomSeed.
  ///
  /// In zh, this message translates to:
  /// **'随机种子'**
  String get randomSeed;

  /// No description provided for @codeGeneration.
  ///
  /// In zh, this message translates to:
  /// **'代码生成'**
  String get codeGeneration;

  /// No description provided for @generateCode.
  ///
  /// In zh, this message translates to:
  /// **'生成代码'**
  String get generateCode;

  /// No description provided for @artifactLocation.
  ///
  /// In zh, this message translates to:
  /// **'产物位置'**
  String get artifactLocation;

  /// No description provided for @codeClassLocation.
  ///
  /// In zh, this message translates to:
  /// **'代码类存放位置'**
  String get codeClassLocation;

  /// No description provided for @resourceDirectory.
  ///
  /// In zh, this message translates to:
  /// **'资源目录'**
  String get resourceDirectory;

  /// No description provided for @iconfontResourceLocation.
  ///
  /// In zh, this message translates to:
  /// **'iconfont 资源存放位置'**
  String get iconfontResourceLocation;

  /// No description provided for @projectPath.
  ///
  /// In zh, this message translates to:
  /// **'项目路径'**
  String get projectPath;

  /// No description provided for @inputProjectAddress.
  ///
  /// In zh, this message translates to:
  /// **'请选择或输入项目地址'**
  String get inputProjectAddress;

  /// No description provided for @iconfontCompressedPackagePath.
  ///
  /// In zh, this message translates to:
  /// **'Iconfont 压缩包路径'**
  String get iconfontCompressedPackagePath;

  /// No description provided for @pleaseSelectOrInputIconfontCompressedPackagePath.
  ///
  /// In zh, this message translates to:
  /// **'请选择或输入 iconfont 下载的压缩包路径'**
  String get pleaseSelectOrInputIconfontCompressedPackagePath;

  /// No description provided for @stayTuned.
  ///
  /// In zh, this message translates to:
  /// **'敬请期待'**
  String get stayTuned;

  /// No description provided for @iconFont.
  ///
  /// In zh, this message translates to:
  /// **'IconFont'**
  String get iconFont;

  /// No description provided for @dataClass.
  ///
  /// In zh, this message translates to:
  /// **'数据类'**
  String get dataClass;

  /// No description provided for @stateManagement.
  ///
  /// In zh, this message translates to:
  /// **'状态管理'**
  String get stateManagement;

  /// No description provided for @jsonParsing.
  ///
  /// In zh, this message translates to:
  /// **'Json 解析'**
  String get jsonParsing;

  /// No description provided for @clickHereToJump.
  ///
  /// In zh, this message translates to:
  /// **'点击这里跳转'**
  String get clickHereToJump;

  /// No description provided for @knowledgeTabToly.
  ///
  /// In zh, this message translates to:
  /// **'捷特文库'**
  String get knowledgeTabToly;

  /// No description provided for @knowledgeTabAlgo.
  ///
  /// In zh, this message translates to:
  /// **'算法演绎'**
  String get knowledgeTabAlgo;

  /// No description provided for @knowledgeTabLayout.
  ///
  /// In zh, this message translates to:
  /// **'布局宝库'**
  String get knowledgeTabLayout;

  /// No description provided for @knowledgeTabPoint.
  ///
  /// In zh, this message translates to:
  /// **'要点宝库'**
  String get knowledgeTabPoint;

  /// No description provided for @knowledgeConstruction.
  ///
  /// In zh, this message translates to:
  /// **'正在建设中'**
  String get knowledgeConstruction;

  /// No description provided for @knowledgeToJuejin.
  ///
  /// In zh, this message translates to:
  /// **'前往掘金'**
  String get knowledgeToJuejin;

  /// No description provided for @srcPath.
  ///
  /// In zh, this message translates to:
  /// **'源码地址'**
  String get srcPath;

  /// No description provided for @widgetsInn.
  ///
  /// In zh, this message translates to:
  /// **'组件酒肆'**
  String get widgetsInn;

  /// No description provided for @likedWidgets.
  ///
  /// In zh, this message translates to:
  /// **'珍藏组件'**
  String get likedWidgets;

  /// No description provided for @relatedComponents.
  ///
  /// In zh, this message translates to:
  /// **'相关组件'**
  String get relatedComponents;

  /// No description provided for @backupFavoritesCollectionData.
  ///
  /// In zh, this message translates to:
  /// **'备份收藏集数据'**
  String get backupFavoritesCollectionData;

  /// No description provided for @syncFavoritesCollectionData.
  ///
  /// In zh, this message translates to:
  /// **'同步收藏集数据'**
  String get syncFavoritesCollectionData;

  /// No description provided for @favoritesCollectionDataReset.
  ///
  /// In zh, this message translates to:
  /// **'收藏集数据重置'**
  String get favoritesCollectionDataReset;

  /// No description provided for @resetSuccess.
  ///
  /// In zh, this message translates to:
  /// **'重置成功!'**
  String get resetSuccess;

  /// No description provided for @dataSetBackupSuccess.
  ///
  /// In zh, this message translates to:
  /// **'数据集备份成功!'**
  String get dataSetBackupSuccess;

  /// No description provided for @dataSetBackupFailure.
  ///
  /// In zh, this message translates to:
  /// **'数据集备份失败!'**
  String get dataSetBackupFailure;

  /// No description provided for @dataSynchronizationCopySuccess.
  ///
  /// In zh, this message translates to:
  /// **'数据同步份成功!'**
  String get dataSynchronizationCopySuccess;

  /// No description provided for @dataSynchronizationCopyFailure.
  ///
  /// In zh, this message translates to:
  /// **'数据同步份失败!'**
  String get dataSynchronizationCopyFailure;

  /// No description provided for @destructionRed.
  ///
  /// In zh, this message translates to:
  /// **'毁灭之红'**
  String get destructionRed;

  /// No description provided for @rageOrange.
  ///
  /// In zh, this message translates to:
  /// **'愤怒之橙'**
  String get rageOrange;

  /// No description provided for @warningYellow.
  ///
  /// In zh, this message translates to:
  /// **'警告之黄'**
  String get warningYellow;

  /// No description provided for @camouflageGreen.
  ///
  /// In zh, this message translates to:
  /// **'伪装之绿'**
  String get camouflageGreen;

  /// No description provided for @coldBlue.
  ///
  /// In zh, this message translates to:
  /// **'冷漠之蓝'**
  String get coldBlue;

  /// No description provided for @infiniteBlue.
  ///
  /// In zh, this message translates to:
  /// **'无限之靛'**
  String get infiniteBlue;

  /// No description provided for @mysteryPurple.
  ///
  /// In zh, this message translates to:
  /// **'神秘之紫'**
  String get mysteryPurple;

  /// No description provided for @destinyBlack.
  ///
  /// In zh, this message translates to:
  /// **'归宿之黑'**
  String get destinyBlack;

  /// No description provided for @showBackground.
  ///
  /// In zh, this message translates to:
  /// **'显示背景'**
  String get showBackground;

  /// No description provided for @toly.
  ///
  /// In zh, this message translates to:
  /// **'张风捷特烈'**
  String get toly;

  /// No description provided for @dartHandbook.
  ///
  /// In zh, this message translates to:
  /// **'Dart 手册'**
  String get dartHandbook;

  /// No description provided for @codeCopiedSuccessfully.
  ///
  /// In zh, this message translates to:
  /// **'代码复制成功'**
  String get codeCopiedSuccessfully;

  /// No description provided for @favoriteFolderManagement.
  ///
  /// In zh, this message translates to:
  /// **'收藏夹管理'**
  String get favoriteFolderManagement;

  /// No description provided for @assembly.
  ///
  /// In zh, this message translates to:
  /// **'组件'**
  String get assembly;

  /// No description provided for @draw.
  ///
  /// In zh, this message translates to:
  /// **'绘制'**
  String get draw;

  /// No description provided for @knowledge.
  ///
  /// In zh, this message translates to:
  /// **'知识'**
  String get knowledge;

  /// No description provided for @collection.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get collection;

  /// No description provided for @my.
  ///
  /// In zh, this message translates to:
  /// **'我的'**
  String get my;

  /// No description provided for @picture.
  ///
  /// In zh, this message translates to:
  /// **'幅'**
  String get picture;

  /// No description provided for @slogan.
  ///
  /// In zh, this message translates to:
  /// **'Flutter 的联合，编程者的联合'**
  String get slogan;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
