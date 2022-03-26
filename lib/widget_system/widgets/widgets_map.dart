import 'package:flutter/material.dart';

import 'exp/other_unit.dart';
import 'exp/proxy_unit.dart';
import 'exp/render_object_unit.dart';
import 'exp/sliver_unit.dart';
import 'exp/stateful_unit.dart';
import 'exp/stateless_unit.dart';

/// AUTO CREATED BY [张风捷特烈] , DON'T MODIFY!

class WidgetsMap {
  static List<Widget> map(String name) {
    switch (name) {
      case "Container":
        return [
          const CustomContainer(),
          const ContainerWithChild(),
          const ContainerAlignment(),
          ContainerDecoration(),
          const ContainerTransform(),
          const ContainerConstraints()
        ];
      case "CupertinoSegmentedControl":
        return [
          CupertinoSegmentedControlDemo(),
          CupertinoSegmentedControlColor()
        ];
      case "CompositedTransformTarget":
        return [
          const CompositedTransformTargetDemo(),
        ];
      case "CompositedTransformFollower":
        return [
          const CompositedTransformFollowerDemo(),
        ];      case "PrimaryScrollController":
        return [
           PrimaryScrollControllerDemo(),
        ];case "CupertinoFullscreenDialogTransition":
        return [
          const CupertinoFullscreenDialogTransitionDemo(),
        ];case "CupertinoPageTransition":
        return [
          const CupertinoPageTransitionDemo(),
        ];case "HtmlElementView":
        return [
          const HtmlElementViewDemo(),
        ];
      case "Text":
        return [
          const CustomText(),
          const ShadowText(),
          const DecorationText(),
          const TextAlignText(),
          const TextDirectionText(),
          const SoftWrapText()
        ];
      case "Card":
        return [
          const CustomCard(),
          const ShapeCard(),
        ];
      case "ElevatedButton":
        return [
          ElevatedButtonDemo(),
          ElevatedButtonStyleDemo(),
        ];
      case "TextButton":
        return [
          TextButtonDemo(),
          TextButtonStyleDemo(),
        ];
      case "OutlinedButton":
        return [
          OutlinedButtonDemo(),
          OutlinedButtonStyleDemo(),
        ];
      case "FlutterLogo":
        return [
          const CustomFlutterLogo(),
          const FlutterLogoWithText(),
        ];
      case "Banner":
        return [
          CustomBanner(),
        ];
      case "UniqueWidget":
        return [
          UniqueWidgetDemo(),
        ];
      case "ShrinkWrappingViewport":
        return [
          ShrinkWrappingViewportDemo(),
        ];      case "NestedScrollViewViewport":
        return [
          NestedScrollViewViewportDemo(),
        ];
      case "ParentDataWidget":
        return [
          ParentDataWidgetDemo(),
        ];
      case "AutomaticKeepAlive":
        return [
          AutomaticKeepAliveDemo(),
        ];
      case "StatusTransitionWidget":
        return [
          StatusTransitionWidgetDemo(),
        ];
      case "KeepAlive":
        return [
          KeepAliveDemo(),
        ];
      case "ListWheelViewport":
        return [
          ListWheelViewportDemo(),
          ListWheelViewportDemo2(),
          ListWheelViewportDemo3(),
          ListWheelViewportDemo4(),
        ];
      case "InheritedTheme":
        return [
          InheritedThemeDemo(),
        ];
      case "ModalBarrier":
        return [
          const ModalBarrierDemo(),
        ];
      case "AnimatedModalBarrier":
        return [
          AnimatedModalBarrierDemo(),
        ];
      case "DefaultAssetBundle":
        return [
          DefaultAssetBundleDemo(),
        ];
      case "DropdownButtonFormField":
        return [
          DropdownButtonFormFieldDemo(),
        ];
      case "FormField":
        return [
          FormFieldDemo(),
        ];
      case "PaginatedDataTable":
        return [
          PaginatedDataTableDemo(),
        ];
      case "InheritedWidget":
        return [
          InheritedWidgetDemo(),
        ];
      case "ScrollView":
        return [
          const ScrollViewDemo(),
        ];
      case "SliverWithKeepAliveWidget":
        return [
          SliverWithKeepAliveWidgetDemo(),
        ];
      case "BoxScrollView":
        return [
          const BoxScrollViewDemo(),
        ];
      case "CupertinoUserInterfaceLevel":
        return [
          CupertinoUserInterfaceLevelDemo(),
        ];
      case "CupertinoSliverNavigationBar":
        return [
          CupertinoSliverNavigationBarDemo(),
        ];
      case "CupertinoSliverRefreshControl":
        return [
          CupertinoSliverRefreshControlDemo(),
        ];
      case "SliverAnimatedList":
        return [
          SliverAnimatedListDemo(),
        ];
      case "SliverFillRemaining":
        return [
          SliverFillRemainingDemo(),
        ];
      case "SliverIgnorePointer":
        return [
          SliverIgnorePointerDemo(),
        ];
      case "Viewport":
        return [
          ViewportDemo(),
        ];
      case "CupertinoPopupSurface":
        return [
          CupertinoPopupSurfaceDemo(),
        ];
      case "RenderObjectToWidgetAdapter":
        return [
          RenderObjectToWidgetAdapterDemo(),
        ];
      case "SliverPrototypeExtentList":
        return [
          SliverPrototypeExtentListDemo(),
        ];
      case "InputDecorator":
        return [
          InputDecoratorDemo(),
        ];
      case "ColoredBox":
        return [
          ColoredBoxDemo(),
        ];
      case "StatefulBuilder":
        return [
          StatefulBuilderDemo(),
        ];
      case "RawKeyboardListener":
        return [
          RawKeyboardListenerDemo(),
        ];
      case "RawGestureDetector":
        return [
          RawGestureDetectorDemo(),
        ];
      case "SafeArea":
        return [
          const SafeAreaDemo(),
        ];
      case "AnimatedBuilder":
        return [
          AnimatedBuilderDemo(),
        ];
      case "TweenAnimationBuilder":
        return [
          TweenAnimationBuilderDemo(),
        ];
      case "WidgetInspector":
        return [
          WidgetInspectorDemo(),
        ];
      case "PageStorage":
        return [
          const PageStorageDemo(),
        ];
      case "NotificationListener":
        return [const NotificationListenerDemo(), const NotificationListenerUpdate()];

      case "Scrollable":
        return [
          ScrollableDemo(),
        ];
      case "PhysicalModel":
        return [
          PhysicalModelDemo(),
        ];
      case "Directionality":
        return [
          DirectionalityDemo(),
        ];
      case "AnimatedTheme":
        return [
          AnimatedThemeDemo(),
        ];
      case "CupertinoSlidingSegmentedControl":
        return [
          CupertinoSlidingSegmentedControlDemo(),
        ];
      case "WidgetsApp":
        return [
          WidgetsAppDemo(),
        ];
      case "TableCell":
        return [
          TableCellDemo(),
        ];

      case "EditableText":
        return [
          EditableTextDemo(),
        ];
      case "PhysicalShape":
        return [
          PhysicalShapeDemo(),
        ];
      case "ListBody":
        return [
          ListBodyDemo(),
        ];
      case "FractionalTranslation":
        return [
          FractionalTranslationDemo(),
        ];
      case "MouseRegion":
        return [
          MouseRegionDemo(),
        ];
      case "TabPageSelector":
        return [
          const TabPageSelectorDemo(),
        ];
      case "CupertinoNavigationBarBackButton":
        return [
          const CupertinoNavigationBarBackButtonDemo(),
        ];
      case "TabPageSelectorIndicator":
        return [
          const TabPageSelectorIndicatorDemo(),
        ];
      case "Title":
        return [
          const TitleDemo(),
        ];
      case "ToggleButtonsTheme":
        return [
          ToggleButtonsThemeDemo(),
        ];
      case "PerformanceOverlay":
        return [
          PerformanceOverlayDemo(),
        ];
      case "NavigationToolbar":
        return [
          const NavigationToolbarDemo(),
        ];
      case "CupertinoDialogAction":
        return [
          const CupertinoDialogActionDemo(),
        ];
      case "ButtonBarTheme":
        return [
          ButtonBarThemeDemo(),
        ];
      case "RawImage":
        return [
          RawImageDemo(),
        ];
      case "TooltipTheme":
        return [
          TooltipThemeDemo(),
        ];
      case "CupertinoTextField":
        return [
          CupertinoTextFieldDemo(),
          CupertinoTextFieldStyle(),
        ];
      case "MaterialBanner":
        return [
          const MaterialBannerDemo(),
          const MaterialBannerDemoTwo(),
        ];
      case "OrientationBuilder":
        return [
          const OrientationBuilderDemo(),
        ];
      case "Icon":
        return [
          const CustomIcon(),
          const MyIcon(),
        ];
      case "ImageIcon":
        return [
          const CustomImageIcon(),
        ];
      case "FadeInImage":
        return [
          const CustomFadeInImage(),
        ];
      case "InteractiveViewer":
        return [
          InteractiveViewerDemo(),
          InteractiveViewerDemo2(),
          InteractiveViewerDemo3(),
        ];
      case "CircleAvatar":
        return [
          const CustomCircleAvatar(),
        ];
      case "SliverLayoutBuilder":
        return [
          SliverLayoutBuilderDemo(),
        ];
      case "Visibility":
        return [
          const CustomVisibility(),
          const ReplacementVisibility(),
        ];
      case "RepaintBoundary":
        return [
          RepaintBoundaryDemo(),
          RepaintBoundarySave(),
        ];
      case "Chip":
        return [
          const CustomChip(),
          const ColorOfChip(),
          const DeleteOfChip(),
        ];
      case "ChoiceChip":
        return [const CustomChoiceChip()];
      case "ListTileTheme":
        return [ListTileThemeDemo()];
      case "ValueListenableBuilder":
        return [ValueListenableBuilderDemo()];
      case "ActionChip":
        return [const CustomActionChip()];
      case "MaterialBannerTheme":
        return [MaterialBannerThemeDemo()];
      case "PopupMenuTheme":
        return [PopupMenuThemeDemo()];
      case "InputChip":
        return [const PressInputChip(), const SelectInputChip()];
      case "FilterChip":
        return [const CustomFilterChip()];
      case "IntrinsicHeight":
        return [IntrinsicHeightDemo()];
      case "IntrinsicWidth":
        return [IntrinsicWidthDemo()];
      case "ChipTheme":
        return [ChipThemeDemo()];
      case "ListTile":
        return [const CustomListTile(), const SelectListTile(), const DenseListTile()];
      case "CheckboxListTile":
        return [
          const CustomCheckBoxListTile(),
          const SelectCheckBoxListTile(),
          const DenseCheckBoxListTile()
        ];
      case "SwitchListTile":
        return [
          const CustomSwitchListTile(),
          const SelectSwitchListTile(),
          const DenseSwitchListTile()
        ];

      case "RadioListTile":
        return [
          const CustomRadioListTile(),
          const DenseRadioListTile(),
        ];

      case "GridTileBar":
        return [
          const CustomGridTileBar(),
        ];

      case "GridTile":
        return [
          const CustomGridTile(),
        ];
      case "UserAccountsDrawerHeader":
        return [
          const CustomUAGHP(),
          const ProUAGHP(),
        ];

      case "MaterialButton":
        return [
          const CustomMaterialButton(),
          const LongPressMaterialButton(),
          const ShapeMaterialButton(),
        ];
      case "CupertinoButton":
        return [CustomCupertinoButton()];
      case "FlatButton":
        return [const CustomFlatButton()];
      case "RaisedButton":
        return [const CustomRaisedButton()];
      case "OutlineButton":
        return [const CustomOutlineButton()];
      case "FloatingActionButton":
        return [const CustomFAB(), const MiniFAB(), const ShapeFAB()];

      case "ButtonBar":
        return [
          const CustomButtonBar(),
          const PaddingButtonBar(),
        ];

      case "IconButton":
        return [
          const CustomIconButton(),
        ];
      case "BackButton":
        return [
          CustomBackButton(),
        ];

      case "CloseButton":
        return [
          const CustomCloseButton(),
        ];
      case "ToggleButtons":
        return [
          const CustomToggleButtons(),
          const ColorToggleButtons(),
          const ProToggleButtons(),
        ];
      case "ToggleButtons":
        return [
          const CustomToggleButtons(),
          const ColorToggleButtons(),
          const ProToggleButtons(),
        ];
      case "NestedScrollView":
        return [
          NestedScrollViewDemo(),
        ];
      case "SliverOverlapAbsorber":
        return [
          SliverOverlapAbsorberDemo(),
        ];
      case "SliverOverlapInjector":
        return [
          SliverOverlapInjectorDemo(),
        ];
      case "Divider":
        return [
          const CustomDivider(),
          const HeightDivider(),
        ];
      case "VerticalDivider":
        return [
          const CustomVerticalDivider(),
          const HeightVerticalDivider(),
        ];
      case "Placeholder":
        return [
          const CustomPlaceholder(),
          const FallbackPlaceholder(),
        ];
      case "GridPager":
        return [
          const CustomGridPage(),
          const DivisionsGridPage(),
        ];
      case "Image":
        return [
          LoadImage(),
          FitImage(),
          AlignmentImage(),
          BlendModeImage(),
          RepeatImage(),
          CenterSliceImage(),
        ];
      case "Checkbox":
        return [
          CustomCheckbox(),
          TristateCheckBok(),
        ];
      case "Switch":
        return [
          CustomSwitch(),
          ImageSwitch(),
        ];
      case "CupertinoSwitch":
        return [
          CustomCupertinoSwitch(),
        ];
      case "Slider":
        return [
          CustomSlider(),
          DivisionsSlider(),
        ];
      case "CupertinoSlider":
        return [
          CustomCupertinoSlider(),
        ];
      case "RangeSlider":
        return [
          CustomRangeSlider(),
        ];
      case "Radio":
        return [
          CustomRadio(),
        ];
      case "CustomMultiChildLayout":
        return [
          CustomMultiChildLayoutDemo(),
        ];
      case "LayoutId":
        return [
          LayoutIdDemo(),
        ];
      case "CircularProgressIndicator":
        return [
          CustomCircularProgressIndicator(),
        ];
      case "LinearProgressIndicator":
        return [
          CustomLinearProgressIndicator(),
        ];
      case "CupertinoActivityIndicator":
        return [
          CustomCupertinoActivityIndicator(),
        ];
      case "RefreshIndicator":
        return [
          CustomRefreshIndicator(),
        ];
      case "Tooltip":
        return [
          CustomTooltip(),
          DecorationTooltip(),
        ];
      case "ExpandIcon":
        return [
          CustomExpandIcon(),
        ];
      case "ExpansionTile":
        return [
          CustomExpansionTile(),
        ];

      case "AnnotatedRegion":
        return [
          AnnotatedRegionDemo(),
        ];
      case "CheckedModeBanner":
        return [
          const CheckedModeBannerDemo(),
        ];
      case "DefaultTabController":
        return [
          DefaultTabControllerDemo(),
        ];
      case "CupertinoTabView":
        return [
          CupertinoTabViewDemo(),
        ];
      case "CupertinoTextSelectionToolbar":
        return [
          CupertinoTextSelectionToolbarDemo(),
        ];
      case "DraggableScrollableActuator":
        return [
          const DraggableScrollableActuatorDemo(),
        ];
      case "GlowingOverscrollIndicator":
        return [
          GlowingOverscrollIndicatorDemo(),
        ];
      case "DraggableScrollableSheet":
        return [
          DraggableScrollableSheetDemo(),
        ];
      case "DrawerController":
        return [
          DrawerControllerDemo(),
        ];
      case "MergeableMaterial":
        return [
          MergeableMaterialDemo(),
        ];
      case "SizeChangedLayoutNotifier":
        return [
          SizeChangedLayoutNotifierDemo(),
        ];
      case "SelectableText":
        return [
          CustomSelectableText(),
          AlignSelectableText(),
        ];
      case "TextField":
        return [
          CustomTextField(),
          CursorTextField(),
          ComplexTextField(),
        ];
      case "DropdownButton":
        return [
          CustomDropDownButton(),
          StyleDropDownButton(),
        ];
      case "PopupMenuButton":
        return [
          CustomPopupMenuButton(),
        ];
      case "AppBar":
        return [
          CustomAppBar(),
          TabAppBar(),
        ];
      case "TabBar":
        return [
          const CustomTabBar(),
          const NoShadowTabBarDemo(),
        ];
      case "TabBarView":
        return [
          CustomTabBarView(),
        ];
      case "BottomNavigationBar":
        return [CustomBottomNavigationBar(), BottomNavigationBarWithPageView()];
      case "BottomAppBar":
        return [
          CustomBottomAppBar(),
        ];
      case "CupertinoNavigationBar":
        return [
          CustomCupertinoNavigationBar(),
        ];
      case "CupertinoTabBar":
        return [
          CustomCupertinoTabBar(),
        ];
      case "Scaffold":
        return [
          CustomScaffold(),
        ];
      case "MaterialApp":
        return [
          MaterialAppDemo(),
        ];
      case "ClipOval":
        return [
          CustomClipOval(),
        ];
      case "ClipRect":
        return [
          CustomClipRect(),
        ];
      case "ClipRRect":
        return [
          CustomClipRRect(),
        ];
      case "ClipPath":
        return [
          CustomClipPath(),
        ];
      case "DecoratedBox":
        return [
          BoxDecorationDemo(),
          ShapeImageDemo(),
          BorderDemo(),
          ShapeDecorationDemo(),
          UnderlineTabIndicatorDemo(),
          FlutterLogoDecorationDemo(),
        ];
      case "Offstage":
        return [
          CustomOffstage(),
        ];
      case "RotatedBox":
        return [
          CustomRotatedBox(),
        ];
      case "Opacity":
        return [
          CustomOpacity(),
        ];
      case "Padding":
        return [
          PaddingAll(),
          PaddingOnly(),
          PaddingSymmetric(),
        ];
      case "Baseline":
        return [
          CustomBaseline(),
        ];
      case "SizedBox":
        return [
          CustomSizedBox(),
        ];
      case "AspectRatio":
        return [
          CustomAspectRatio(),
        ];
      case "Transform":
        return [
          SkewTransform(),
          TranslationTransform(),
          ScaleTransform(),
          RotateTransform(),
          R3C2(),
        ];
      case "LimitedBox":
        return [
          CustomLimitedBox(),
        ];
      case "ConstrainedBox":
        return [
          CustomConstrainedBox(),
        ];
      case "UnconstrainedBox":
        return [
          CustomUnConstrainedBox(),
        ];
      case "FractionallySizedBox":
        return [
          CustomFractionallySizedBox(),
        ];
      case "OverflowBox":
        return [
          CustomOverflowBox(),
        ];
      case "SizedOverflowBox":
        return [
          CustomSizedOverflowBox(),
        ];
      case "Align":
        return [CustomAlign(), SinLayout()];
      case "Center":
        return [
          CustomCenter(),
        ];
      case "FittedBox":
        return [
          CustomFittedBox(),
        ];
      case "ColorFiltered":
        return [
          CustomColorFiltered(),
        ];
      case "FadeTransition":
        return [
          CustomFadeTransition(),
        ];
      case "RotationTransition":
        return [
          CustomRotationTransition(),
        ];
      case "ScaleTransition":
        return [
          CustomScaleTransition(),
        ];
      case "SizeTransition":
        return [
          CustomSizeTransition(),
        ];
      case "PositionedTransition":
        return [
          CustomPositionedTransition(),
        ];
      case "Flex":
        return [
          DirectionFlex(),
          MainAxisAlignmentFlex(),
          CrossAxisAlignmentFlex(),
          VerticalDirectionFlex(),
          TextDirectionFlex(),
        ];
      case "Row":
        return [
          CustomRow(),
        ];
      case "Column":
        return [
          CustomColumn(),
        ];
      case "Stack":
        return [CustomStack(), PositionedStack()];
      case "Wrap":
        return [
          DirectionWrap(),
          WrapAlignmentWrap(),
          CrossAxisAlignmentWrap(),
          TextDirectionWrap(),
          VerticalDirectionWrap(),
        ];
      case "Flow":
        return [
          CircleFlow(),
          BurstFlow.show,
        ];
      case "AnimatedCrossFade":
        return [
          CustomAnimatedCrossFade(),
          CurveAnimatedCrossFade(),
        ];
      case "RichText":
        return [
          CustomRichText(),
          RichTextWithWidget(),
        ];
      case "DataTable":
        return [
          CustomDataTable(),
          const SortDataTable(),
        ];
      case "Draggable":
        return [
          CustomDraggable(),
          DraggablePage(),
          DeleteDraggable(),
        ];
      case "DragTarget":
        return [
          CustomDragTarget(),
        ];
      case "LongPressDraggable":
        return [
          CustomLongPressDraggable(),
        ];
      case "Expanded":
        return [
          CustomExpended(),
        ];
      case "Spacer":
        return [
          const OneSpacer(),
          const ManySpacer(),
        ];
      case "Positioned":
        return [
          CustomPositioned(),
        ];
      case "Flexible":
        return [
          CustomFlexible(),
        ];
      case "Table":
        return [
          CustomTable(),
        ];
      case "AlignTransition":
        return [
          CustomAlignTransition(),
        ];
      case "SlideTransition":
        return [
          CustomSlideTransition(),
        ];
      case "DecoratedBoxTransition":
        return [
          CustomDecoratedBoxTransition(),
        ];
      case "DefaultTextStyleTransition":
        return [
          CustomDefaultTextStyleTransition(),
        ];
      case "RelativePositionedTransition":
        return [
          CustomRelativePositionedTransition(),
        ];
      case "AnimatedSwitcher":
        return [
          CustomAnimatedSwitcher(),
        ];
      case "AnimatedList":
        return [
          CustomAnimatedList(),
        ];
      case "AnimatedOpacity":
        return [
          CustomAnimatedOpacity(),
        ];
      case "AnimatedPadding":
        return [
          CustomAnimatedPadding(),
        ];
      case "AnimatedAlign":
        return [
          CustomAnimatedAlign(),
        ];
      case "AnimatedPositioned":
        return [
          CustomAnimatedPositioned(),
        ];
      case "AnimatedPositionedDirectional":
        return [
          CustomAnimatedPositionedDirectional(),
        ];
      case "AnimatedContainer":
        return [
          CustomAnimatedContainer(),
        ];
      case "AnimatedDefaultTextStyle":
        return [
          CustomAnimatedDefaultTextStyle(),
        ];
      case "AnimatedIcon":
        return [
          const CustomAnimatedIcon(),
        ];
      case "Dialog":
        return [
          const CustomDialog(),
        ];
      case "AlertDialog":
        return [
          const CustomAlertDialog(),
        ];
      case "SimpleDialog":
        return [
          const CustomSimpleDialog(),
        ];
      case "CupertinoAlertDialog":
        return [
          const CustomCupertinoAlertDialog(),
        ];
      case "AboutDialog":
        return [
          const CustomAboutDialog(),
        ];
      case "CupertinoActionSheet":
        return [
          const CustomCupertinoActionSheet(),
        ];
      case "CupertinoActionSheetAction":
        return [
          const CustomCupertinoActionSheetAction(),
        ];
      case "SimpleDialogOption":
        return [
          const CustomSimpleDialogOption(),
        ];
      case "DayPicker":
        return [
          const CustomDayPicker(),
        ];
      case "MonthPicker":
        return [
          CustomMonthPicker(),
        ];
      case "YearPicker":
        return [
          CustomYearPicker(),
        ];
      case "CupertinoDatePicker":
        return [
          CustomCupertinoDatePicker(),
        ];
      case "CupertinoTimerPicker":
        return [
          CustomCupertinoTimerPicker(),
        ];
      case "CupertinoPicker":
        return [
          CustomCupertinoPicker(),
        ];
      case "SnackBar":
        return [
          const CustomSnackBar(),
        ];
      case "SnackBarAction":
        return [
          const CustomSnackBarAction(),
        ];
      case "BottomSheet":
        return [
          const CustomBottomSheet(),
        ];
      case "CupertinoContextMenu":
        return [
          CustomCupertinoContextMenu(),
        ];
      case "CupertinoContextMenuAction":
        return [
          CustomCupertinoContextMenuAction(),
        ];
      case "LicensePage":
        return [
          CustomLicensePage(),
        ];
      case "Builder":
        return [
          const BuilderDemo(),
        ];
      case "GestureDetector":
        return [
          const CustomGestureDetector(),
          const TapGestureDetector(),
          const PanGestureDetector(),
        ];
      case "Listener":
        return [
          const CustomListener(),
        ];
      case "Tab":
        return [
          const CustomTab(),
        ];
      case "PreferredSize":
        return [
          const CustomPreferredSize(),
          const AdapterPreferredSize(),
        ];
      case "InkResponse":
        return [
          CustomInkResponse(),
          ColorInkResponse(),
        ];
      case "InkWell":
        return [
          CustomInkWell(),
          ColorInkWell(),
        ];
      case "TableRowInkWell":
        return [
          CustomTableRowInkWell(),
        ];
      case "Ink":
        return [
          CustomInk(),
          InkImage(),
        ];
      case "RawChip":
        return [
          PressRawChip(),
          SelectRawChip(),
        ];
      case "Drawer":
        return [
          const CustomDrawer(),
        ];
      case "DrawerHeader":
        return [
          const CustomDrawerHeader(),
        ];
      case "CupertinoApp":
        return [
          CustomCupertinoApp(),
        ];
      case "CupertinoPageScaffold":
        return [
          CustomCupertinoPageScaffold(),
        ];
      case "CupertinoTabScaffold":
        return [
          CustomCupertinoTabScaffold(),
        ];
      case "PositionedDirectional":
        return [
          const CustomPositionedDirectional(),
        ];
      case "Material":
        return [
          CustomMaterial(),
          ShapeMaterial(),
        ];
      case "IndexedStack":
        return [
          CustomIndexedStack(),
        ];
      case "ListView":
        return [
          CustomListView(),
          HorizontalListView(),
          SeparatedListView(),
          BuilderListView(),
        ];
      case "GridView":
        return [
          CustomGridView(),
          HorizontalGridView(),
          ExtentGridView(),
          BuilderGridView()
        ];
      case "SingleChildScrollView":
        return [
          CustomSingleChildScrollView(),
          DirectionSingleChildScrollView(),
        ];
      case "PageView":
        return [
          CustomPageView(),
          DirectionPageView(),
          CtrlPageView(),
        ];
      case "CustomPaint":
        return [
          ClockPage(),
          PlayBezier3Page(),
        ];
      case "MediaQuery":
        return [
          CustomMediaQuery(),
        ];
      case "Theme":
        return [const TextThemeDemo(), const CustomTheme()];
      case "CupertinoTheme":
        return [const TextCupertinoTheme(), const CustomCupertinoTheme()];
      case "WillPopScope":
        return [
          CustomWillPopScope(),
        ];
      case "Hero":
        return [
          CustomHero(),
        ];
      case "FutureBuilder":
        return [
          CustomFutureBuilder(),
        ];
      case "StreamBuilder":
        return [
          CustomStreamBuilder(),
        ];
      case "PopupMenuDivider":
        return [
          CustomPopupMenuDivider(),
        ];
      case "RawMaterialButton":
        return [
          CustomRawMaterialButton(),
          ShapeRawMaterialButton(),
        ];
      case "Dismissible":
        return [
          CustomDismissible(),
          DirectionDismissible(),
        ];
      case "ReorderableListView":
        return [
          CustomReorderableListView(),
          DirectionReorderableListView(),
        ];
      case "ExpansionPanelList":
        return [
          CustomExpansionPanelList(),
        ];
      case "ListWheelScrollView":
        return [
          CustomListWheelScrollView(),
        ];
      case "ScrollConfiguration":
        return [
          CustomScrollConfiguration(),
        ];
      case "DropdownButtonHideUnderline":
        return [
          CustomDropDownButtonHideUnderline(),
        ];
      case "Overlay":
        return [
          CustomOverlay(),
        ];
      case "CustomScrollView":
        return [
          CustomScrollViewDemo(),
        ];
      case "SliverAppBar":
        return [
          SliverAppBarDemo(),
        ];
      case "SliverList":
        return [
          SliverListDemo(),
        ];
      case "SliverFixedExtentList":
        return [
          SliverFixedExtentListDemo(),
        ];
      case "SliverFillViewport":
        return [
          SliverFillViewportDemo(),
        ];
      case "SliverGird":
        return [
          SliverGirdDemo(),
        ];
      case "SliverToBoxAdapter":
        return [
          SliverToBoxAdapterDemo(),
        ];
      case "SliverPersistentHeader":
        return [
          SliverPersistentHeaderDemo(),
        ];
      case "SliverPadding":
        return [
          SliverPaddingDemo(),
        ];
      case "SliverOpacity":
        return [
          SliverOpacityDemo(),
        ];
      case "AboutListTile":
        return [
          const AboutListTileDemo(),
        ];
      case "Scrollbar":
        return [
          CustomScrollbar(),
        ];
      case "CupertinoScrollbar":
        return [
          CustomCupertinoScrollbar(),
        ];
      case "FlexibleSpaceBar":
        return [
          FlexibleSpaceBarDemo(),
        ];
      case "ErrorWidget":
        return [
          ErrorWidgetDemo(),
        ];
      case "Form":
        return [
          CustomForm(),
        ];
      case "TextFormField":
        return [
          CustomTextFormField(),
        ];
      case "Stepper":
        return [
          StepperDemo(),
          VerticalStepper(),
        ];
      case "AnimatedSize":
        return [
          CustomAnimatedSize(),
        ];
      case "ShaderMask":
        return [
          RadialShaderMask(),
          LinearShaderMask(),
        ];
      case "DefaultTextStyle":
        return [
          DefaultTextStyleDemo(),
        ];
      case "IconTheme":
        return [
          IconThemeDemo(),
        ];
      case "ButtonTheme":
        return [
          ButtonThemeDemo(),
        ];
      case "DividerTheme":
        return [
          DividerThemeDemo(),
        ];
      case "Navigator":
        return [
          NavigatorDemo(),
        ];
      case "SliderTheme":
        return [
          SliderThemeDemo(),
          DIYSliderTheme(),
        ];
      case "LayoutBuilder":
        return [
          CustomLayoutBuilder(),
          FitByLayoutBuilder(),
          SimpleExpandableText(),
        ];
      case "IgnorePointer":
        return [
          CustomIgnorePointer(),
        ];
      case "AbsorbPointer":
        return [
          CustomAbsorbPointer(),
        ];
      case "BackdropFilter":
        return [
          CustomBackdropFilter(),
        ];
      case "AnimatedPhysicalModel":
        return [
          AnimatedPhysicalModelDemo(),
        ];
      case "CustomSingleChildLayout":
        return [
          CustomSingleChildLayoutDemo(),
          OffSetWidgetDemo(),
        ];
      default: return [];
    }
  }
}
