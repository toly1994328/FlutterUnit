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
        case "DropdownMenu":
        return [
          const DropdownMenuNode1(),
          const DropdownMenuNode2(),
          const DropdownMenuNode3(),
        ];
      case "CupertinoSegmentedControl":
        return [
          const CupertinoSegmentedControlDemo(),
          const CupertinoSegmentedControlColor()
        ];
      case "ImageFiltered":
        return [
          const ImageFilteredBlur(),
          const ImageFilteredColor(),
          const ImageFilteredMatrix()
        ];
      case "Autocomplete":
        return [const AutocompleteDemo(), const AutocompleteType()];
      case "Badge":
        return [
          const BadgeDemo(),
          const BadgeLabelDemo(),
          const BadgeAlignOffsetDemo(),
        ];
      case "DateRangePickerDialog":
        return [
          const DateRangePickerDialogDemo(),
          const DiyDateRangePickerDialogDemo()
        ];
      case "CompositedTransformTarget":
        return [
          const CompositedTransformTargetDemo(),
        ];
      case "CompositedTransformFollower":
        return [
          const CompositedTransformFollowerDemo(),
        ];
      case "PrimaryScrollController":
        return [
          const PrimaryScrollControllerDemo(),
        ];
      case "CupertinoFullscreenDialogTransition":
        return [
          const CupertinoFullscreenDialogTransitionDemo(),
        ];
      case "CupertinoPageTransition":
        return [
          const CupertinoPageTransitionDemo(),
        ];
      case "HtmlElementView":
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
          const ElevatedButtonDemo(),
          const ElevatedButtonStyleDemo(),
        ];
      case "TextButton":
        return [
          const TextButtonDemo(),
          const TextButtonStyleDemo(),
        ];
      case "OutlinedButton":
        return [
          const OutlinedButtonDemo(),
          const OutlinedButtonStyleDemo(),
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
          const UniqueWidgetDemo(),
        ];
      case "ShrinkWrappingViewport":
        return [
          const ShrinkWrappingViewportDemo(),
        ];
      case "NestedScrollViewViewport":
        return [
          const NestedScrollViewViewportDemo(),
        ];
      case "ParentDataWidget":
        return [
          const ParentDataWidgetDemo(),
        ];
      case "AutomaticKeepAlive":
        return [
          AutomaticKeepAliveDemo(),
        ];
      case "StatusTransitionWidget":
        return [
          const StatusTransitionWidgetDemo(),
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
          const InheritedThemeDemo(),
        ];
      case "ModalBarrier":
        return [
          const ModalBarrierDemo(),
        ];
      case "AnimatedModalBarrier":
        return [
          const AnimatedModalBarrierDemo(),
        ];
      case "DefaultAssetBundle":
        return [
          const DefaultAssetBundleDemo(),
        ];
      case "DropdownButtonFormField":
        return [
          const DropdownButtonFormFieldDemo(),
        ];
      case "FormField":
        return [
          const FormFieldDemo(),
        ];
      case "PaginatedDataTable":
        return [
          const PaginatedDataTableDemo(),
        ];
      case "InheritedWidget":
        return [
          const InheritedWidgetDemo(),
        ];
      case "ScrollView":
        return [
          const ScrollViewDemo(),
        ];
      case "SliverWithKeepAliveWidget":
        return [
          const SliverWithKeepAliveWidgetDemo(),
        ];
      case "BoxScrollView":
        return [
          const BoxScrollViewDemo(),
        ];
      case "CupertinoUserInterfaceLevel":
        return [
          const CupertinoUserInterfaceLevelDemo(),
        ];
      case "CupertinoSliverNavigationBar":
        return [
          CupertinoSliverNavigationBarDemo(),
        ];
      case "CupertinoSliverRefreshControl":
        return [
          const CupertinoSliverRefreshControlDemo(),
        ];
      case "SliverAnimatedList":
        return [
          const SliverAnimatedListDemo(),
        ];
      case "SliverFillRemaining":
        return [
          const SliverFillRemainingDemo(),
        ];
      case "SliverIgnorePointer":
        return [
          const SliverIgnorePointerDemo(),
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
          const RenderObjectToWidgetAdapterDemo(),
        ];
      case "SliverPrototypeExtentList":
        return [
          const SliverPrototypeExtentListDemo(),
        ];
      case "InputDecorator":
        return [
          const InputDecoratorDemo(),
        ];
      case "ColoredBox":
        return [
          const ColoredBoxDemo(),
        ];
      case "StatefulBuilder":
        return [
          const StatefulBuilderDemo(),
        ];
      case "RawKeyboardListener":
        return [
          const RawKeyboardListenerDemo(),
        ];
      case "RawGestureDetector":
        return [
          const RawGestureDetectorDemo(),
        ];
      case "SafeArea":
        return [
          const SafeAreaDemo(),
        ];
      case "AnimatedBuilder":
        return [
          const AnimatedBuilderDemo(),
        ];
      case "TweenAnimationBuilder":
        return [
          const TweenAnimationBuilderDemo(),
        ];
      case "WidgetInspector":
        return [
          const WidgetInspectorDemo(),
        ];
      case "PageStorage":
        return [
          const PageStorageDemo(),
        ];
      case "NotificationListener":
        return [
          const NotificationListenerDemo(),
          const NotificationListenerUpdate()
        ];

      case "Scrollable":
        return [
          ScrollableDemo(),
        ];
      case "PhysicalModel":
        return [
          const PhysicalModelDemo(),
        ];
      case "Directionality":
        return [
          const DirectionalityDemo(),
        ];
      case "AnimatedTheme":
        return [
          const AnimatedThemeDemo(),
        ];
      case "CupertinoSlidingSegmentedControl":
        return [
          const CupertinoSlidingSegmentedControlDemo(),
        ];
      case "WidgetsApp":
        return [
          const WidgetsAppDemo(),
        ];
      case "TableCell":
        return [
          const TableCellDemo(),
        ];

      case "EditableText":
        return [
          const EditableTextDemo(),
        ];
      case "PhysicalShape":
        return [
          const PhysicalShapeDemo(),
        ];
      case "ListBody":
        return [
          const ListBodyDemo(),
        ];
      case "FractionalTranslation":
        return [
          const FractionalTranslationDemo(),
        ];
      case "MouseRegion":
        return [
          const MouseRegionDemo(),
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
          const ToggleButtonsThemeDemo(),
        ];
      case "PerformanceOverlay":
        return [
          const PerformanceOverlayDemo(),
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
          const ButtonBarThemeDemo(),
        ];
      case "RawImage":
        return [
          const RawImageDemo(),
        ];
      case "TooltipTheme":
        return [
          const TooltipThemeDemo(),
        ];
      case "CupertinoTextField":
        return [
          const CupertinoTextFieldDemo(),
          const CupertinoTextFieldStyle(),
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
          const InteractiveViewerDemo(),
          const InteractiveViewerDemo2(),
          const InteractiveViewerDemo3(),
        ];
      case "CircleAvatar":
        return [
          const CustomCircleAvatar(),
        ];
      case "SliverLayoutBuilder":
        return [
          const SliverLayoutBuilderDemo(),
        ];
      case "Visibility":
        return [
          const CustomVisibility(),
          const ReplacementVisibility(),
        ];
      case "RepaintBoundary":
        return [
          const RepaintBoundaryDemo(),
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
        return [const ListTileThemeDemo()];
      case "ValueListenableBuilder":
        return [ValueListenableBuilderDemo()];
      case "ActionChip":
        return [const CustomActionChip()];
      case "MaterialBannerTheme":
        return [const MaterialBannerThemeDemo()];
      case "PopupMenuTheme":
        return [const PopupMenuThemeDemo()];
      case "InputChip":
        return [const PressInputChip(), const SelectInputChip()];
      case "FilterChip":
        return [const CustomFilterChip()];
      case "IntrinsicHeight":
        return [const IntrinsicHeightDemo()];
      case "IntrinsicWidth":
        return [const IntrinsicWidthDemo()];
      case "ChipTheme":
        return [const ChipThemeDemo()];
      case "ListTile":
        return [
          const CustomListTile(),
          const SelectListTile(),
          const DenseListTile()
        ];
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
      case "NestedScrollView":
        return [
          const NestedScrollViewDemo(),
        ];
      case "SliverOverlapAbsorber":
        return [
          const SliverOverlapAbsorberDemo(),
        ];
      case "SliverOverlapInjector":
        return [
          const SliverOverlapInjectorDemo(),
        ];
      case "Divider":
        return [
          const CustomDivider(),
          const HeightDivider(),
        ];
      case "VerticalDivider":
        return [
          const CustomVerticalDivider(),
          const WidthVerticalDivider(),
        ];
      case "Placeholder":
        return [
          const CustomPlaceholder(),
          const FallbackPlaceholder(),
        ];
      case "GridPaper":
        return [
          const CustomGridPaper(),
          const DivisionsGridPaper(),
        ];
      case "Image":
        return [
          const LoadImage(),
          const FitImage(),
          const AlignmentImage(),
          const BlendModeImage(),
          const RepeatImage(),
          const CenterSliceImage(),
        ];
      case "Checkbox":
        return [
          const CustomCheckbox(),
          const TristateCheckBok(),
        ];
      case "Switch":
        return [
          const CustomSwitch(),
          const ImageSwitch(),
        ];
      case "CupertinoSwitch":
        return [
          const CustomCupertinoSwitch(),
        ];
      case "Slider":
        return [
          const CustomSlider(),
          const DivisionsSlider(),
        ];
      case "CupertinoSlider":
        return [
          const CustomCupertinoSlider(),
        ];
      case "RangeSlider":
        return [
          const CustomRangeSlider(),
        ];
      case "Radio":
        return [
          const CustomRadio(),
        ];
      case "CustomMultiChildLayout":
        return [
          const CustomMultiChildLayoutDemo(),
        ];
      case "LayoutId":
        return [
          const LayoutIdDemo(),
        ];
      case "CircularProgressIndicator":
        return [
          const CustomCircularProgressIndicator(),
        ];
      case "LinearProgressIndicator":
        return [
          const CustomLinearProgressIndicator(),
        ];
      case "CupertinoActivityIndicator":
        return [
          const CustomCupertinoActivityIndicator(),
        ];
      case "RefreshIndicator":
        return [
          const CustomRefreshIndicator(),
        ];
      case "Tooltip":
        return [
          const CustomTooltip(),
          const DecorationTooltip(),
        ];
      case "ExpandIcon":
        return [
          const CustomExpandIcon(),
        ];
      case "ExpansionTile":
        return [
          const CustomExpansionTile(),
        ];

      case "AnnotatedRegion":
        return [
          const AnnotatedRegionDemo(),
        ];
      case "CheckedModeBanner":
        return [
          const CheckedModeBannerDemo(),
        ];
      case "DefaultTabController":
        return [
          const DefaultTabControllerDemo(),
        ];
      case "CupertinoTabView":
        return [
          const CupertinoTabViewDemo(),
        ];
      case "CupertinoTextSelectionToolbar":
        return [
          const CupertinoTextSelectionToolbarDemo(),
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
          const DraggableScrollableSheetDemo(),
        ];
      case "DrawerController":
        return [
          const DrawerControllerDemo(),
        ];
      case "MergeableMaterial":
        return [
          const MergeableMaterialDemo(),
        ];
      case "SizeChangedLayoutNotifier":
        return [
          const SizeChangedLayoutNotifierDemo(),
        ];
      case "SelectableText":
        return [
          const CustomSelectableText(),
          const AlignSelectableText(),
        ];
      case "TextField":
        return [
          const CustomTextField(),
          const CursorTextField(),
          const ComplexTextField(),
        ];
      case "DropdownButton":
        return [
          const CustomDropDownButton(),
          const StyleDropDownButton(),
        ];
      case "PopupMenuButton":
        return [
          const CustomPopupMenuButton(),
        ];
      case "AppBar":
        return [
          const CustomAppBar(),
          const TabAppBar(),
        ];
      case "TabBar":
        return [
          const CustomTabBar(),
          const NoShadowTabBarDemo(),
        ];
      case "TabBarView":
        return [
          const CustomTabBarView(),
        ];
      case "BottomNavigationBar":
        return [
          const CustomBottomNavigationBar(),
          const BottomNavigationBarWithPageView()
        ];
      case "BottomAppBar":
        return [
          const CustomBottomAppBar(),
        ];
      case "CupertinoNavigationBar":
        return [
          const CustomCupertinoNavigationBar(),
        ];
      case "CupertinoTabBar":
        return [
          const CustomCupertinoTabBar(),
        ];
      case "Scaffold":
        return [
          const CustomScaffold(),
        ];
      case "MaterialApp":
        return [
          const MaterialAppDemo(),
        ];
      case "ClipOval":
        return [
          const CustomClipOval(),
        ];
      case "ClipRect":
        return [
          const CustomClipRect(),
        ];
      case "ClipRRect":
        return [
          const CustomClipRRect(),
        ];
      case "ClipPath":
        return [
          const CustomClipPath(),
        ];
      case "DecoratedBox":
        return const [
          BoxDecorationDemo(),
          ShapeImageDemo(),
          BorderDemo(),
          ShapeDecorationDemo(),
          UnderlineTabIndicatorDemo(),
          FlutterLogoDecorationDemo(),
        ];
      case "Offstage":
        return [
          const CustomOffstage(),
        ];
      case "RotatedBox":
        return [
          const CustomRotatedBox(),
        ];
      case "Opacity":
        return [
          const CustomOpacity(),
        ];
      case "Padding":
        return [
          const PaddingAll(),
          const PaddingOnly(),
          const PaddingSymmetric(),
        ];
      case "Baseline":
        return [
          const CustomBaseline(),
        ];
      case "SizedBox":
        return [
          const CustomSizedBox(),
        ];
      case "AspectRatio":
        return [
          const CustomAspectRatio(),
        ];
      case "Transform":
        return [
          const SkewTransform(),
          const TranslationTransform(),
          const ScaleTransform(),
          const RotateTransform(),
          const R3C2(),
        ];
      case "LimitedBox":
        return [
          const CustomLimitedBox(),
        ];
      case "ConstrainedBox":
        return [
          const CustomConstrainedBox(),
        ];
      case "UnconstrainedBox":
        return [
          const CustomUnConstrainedBox(),
        ];
      case "FractionallySizedBox":
        return [
          const CustomFractionallySizedBox(),
        ];
      case "OverflowBox":
        return [
          const CustomOverflowBox(),
        ];
      case "SizedOverflowBox":
        return [
          const CustomSizedOverflowBox(),
        ];
      case "Align":
        return [const CustomAlign(), const SinLayout()];
      case "Center":
        return [
          const CustomCenter(),
        ];
      case "FittedBox":
        return [
          const CustomFittedBox(),
        ];
      case "ColorFiltered":
        return [
          const CustomColorFiltered(),
        ];
      case "FadeTransition":
        return [
          const CustomFadeTransition(),
        ];
      case "RotationTransition":
        return [
          const CustomRotationTransition(),
        ];
      case "ScaleTransition":
        return [
          const CustomScaleTransition(),
        ];
      case "SizeTransition":
        return [
          const CustomSizeTransition(),
        ];
      case "PositionedTransition":
        return [
          const CustomPositionedTransition(),
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
          const CustomRow(),
        ];
      case "Column":
        return [
          const CustomColumn(),
        ];
      case "Stack":
        return [const CustomStack(), const PositionedStack()];
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
          const CustomAnimatedCrossFade(),
          const CurveAnimatedCrossFade(),
        ];
      case "RichText":
        return [
          const CustomRichText(),
          const RichTextWithWidget(),
        ];
      case "DataTable":
        return [
          CustomDataTable(),
          const SortDataTable(),
        ];
      case "Draggable":
        return [
          const CustomDraggable(),
          const DraggablePage(),
          const DeleteDraggable(),
        ];
      case "DragTarget":
        return [
          const CustomDragTarget(),
        ];
      case "LongPressDraggable":
        return [
          const CustomLongPressDraggable(),
        ];
      case "Expanded":
        return [
          const CustomExpended(),
        ];
      case "Spacer":
        return [
          const OneSpacer(),
          const ManySpacer(),
        ];
      case "Positioned":
        return [
          const CustomPositioned(),
        ];
      case "Flexible":
        return [
          const CustomFlexible(),
        ];
      case "Table":
        return [
          const CustomTable(),
        ];
      case "AlignTransition":
        return [
          const CustomAlignTransition(),
        ];
      case "SlideTransition":
        return [
          const CustomSlideTransition(),
        ];
      case "DecoratedBoxTransition":
        return [
          const CustomDecoratedBoxTransition(),
        ];
      case "DefaultTextStyleTransition":
        return [
          const CustomDefaultTextStyleTransition(),
        ];
      case "RelativePositionedTransition":
        return [
          const CustomRelativePositionedTransition(),
        ];
      case "AnimatedSwitcher":
        return [
          const CustomAnimatedSwitcher(),
        ];
      case "AnimatedList":
        return [
          const CustomAnimatedList(),
        ];
      case "AnimatedOpacity":
        return [
          const CustomAnimatedOpacity(),
        ];
      case "AnimatedPadding":
        return [
          const CustomAnimatedPadding(),
        ];
      case "AnimatedAlign":
        return [
          const CustomAnimatedAlign(),
        ];
      case "AnimatedPositioned":
        return [
          const CustomAnimatedPositioned(),
        ];
      case "AnimatedPositionedDirectional":
        return [
          const CustomAnimatedPositionedDirectional(),
        ];
      case "AnimatedContainer":
        return [
          const CustomAnimatedContainer(),
        ];
      case "AnimatedDefaultTextStyle":
        return [
          const CustomAnimatedDefaultTextStyle(),
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
          const CustomMonthPicker(),
        ];
      case "YearPicker":
        return [
          const CustomYearPicker(),
        ];
      case "CupertinoDatePicker":
        return [
          const CustomCupertinoDatePicker(),
        ];
      case "CupertinoTimerPicker":
        return [
          const CustomCupertinoTimerPicker(),
        ];
      case "CupertinoPicker":
        return [
          const CustomCupertinoPicker(),
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
          const CustomCupertinoContextMenu(),
        ];
      case "CupertinoContextMenuAction":
        return [
          const CustomCupertinoContextMenuAction(),
        ];
      case "LicensePage":
        return [
          const CustomLicensePage(),
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
          const CustomInkResponse(),
          const ColorInkResponse(),
        ];
      case "InkWell":
        return [
          const CustomInkWell(),
          const ColorInkWell(),
        ];
      case "TableRowInkWell":
        return [
          const CustomTableRowInkWell(),
        ];
      case "Ink":
        return [
          const CustomInk(),
          const InkImage(),
        ];
      case "RawChip":
        return [
          const PressRawChip(),
          const SelectRawChip(),
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
          const CustomCupertinoApp(),
        ];
      case "CupertinoPageScaffold":
        return [
          const CustomCupertinoPageScaffold(),
        ];
      case "CupertinoTabScaffold":
        return [
          const CustomCupertinoTabScaffold(),
        ];
      case "PositionedDirectional":
        return [
          const CustomPositionedDirectional(),
        ];
      case "Material":
        return [
          const CustomMaterial(),
          const ShapeMaterial(),
        ];
      case "IndexedStack":
        return [
          const CustomIndexedStack(),
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
          const CtrlPageView(),
        ];
      case "CustomPaint":
        return [
          const ClockPage(),
          const PlayBezier3Page(),
        ];
      case "MediaQuery":
        return [
          const CustomMediaQuery(),
        ];
      case "Theme":
        return [const TextThemeDemo(), const CustomTheme()];
      case "CupertinoTheme":
        return [const TextCupertinoTheme(), const CustomCupertinoTheme()];
      case "WillPopScope":
        return [
          const CustomWillPopScope(),
        ];
      case "Hero":
        return [
          const CustomHero(),
        ];
      case "FutureBuilder":
        return [
          const CustomFutureBuilder(),
        ];
      case "StreamBuilder":
        return [
          const CustomStreamBuilder(),
        ];
      case "PopupMenuDivider":
        return [
          const CustomPopupMenuDivider(),
        ];
      case "RawMaterialButton":
        return [
          const CustomRawMaterialButton(),
          const ShapeRawMaterialButton(),
        ];
      case "Dismissible":
        return [
          const CustomDismissible(),
          const DirectionDismissible(),
        ];
      case "ReorderableListView":
        return [
          const CustomReorderableListView(),
          const DirectionReorderableListView(),
        ];
      case "ExpansionPanelList":
        return [
          const CustomExpansionPanelList(),
        ];
      case "ListWheelScrollView":
        return [
          const CustomListWheelScrollView(),
        ];
      case "ScrollConfiguration":
        return [
          CustomScrollConfiguration(),
        ];
      case "DropdownButtonHideUnderline":
        return [
          const CustomDropDownButtonHideUnderline(),
        ];
      case "Overlay":
        return [
          const CustomOverlay(),
        ];
      case "CustomScrollView":
        return [
          CustomScrollViewDemo(),
        ];
      case "SliverAppBar":
        return [
          const SliverAppBarDemo(),
        ];
      case "SliverList":
        return [
          SliverListDemo(),
        ];
      case "SliverFixedExtentList":
        return [
          const SliverFixedExtentListDemo(),
        ];
      case "SliverFillViewport":
        return [
          const SliverFillViewportDemo(),
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
          const ErrorWidgetDemo(),
        ];
      case "Form":
        return [
          const CustomForm(),
        ];
      case "TextFormField":
        return [
          const CustomTextFormField(),
        ];
      case "Stepper":
        return [
          const StepperDemo(),
          const VerticalStepper(),
        ];
      case "AnimatedSize":
        return [
          const CustomAnimatedSize(),
        ];
      case "ShaderMask":
        return [
          const RadialShaderMask(),
          const LinearShaderMask(),
        ];
      case "DefaultTextStyle":
        return [
          const DefaultTextStyleDemo(),
        ];
      case "IconTheme":
        return [
          const IconThemeDemo(),
        ];
      case "ButtonTheme":
        return [
          const ButtonThemeDemo(),
        ];
      case "DividerTheme":
        return [
          const DividerThemeDemo(),
        ];
      case "Navigator":
        return [
          const NavigatorDemo(),
        ];
      case "SliderTheme":
        return [
          const SliderThemeDemo(),
          const DIYSliderTheme(),
        ];
      case "LayoutBuilder":
        return [
          const CustomLayoutBuilder(),
          const FitByLayoutBuilder(),
          const SimpleExpandableText(),
        ];
      case "IgnorePointer":
        return [
          const CustomIgnorePointer(),
        ];
      case "AbsorbPointer":
        return [
          const CustomAbsorbPointer(),
        ];
      case "BackdropFilter":
        return [
          const CustomBackdropFilter(),
        ];
      case "AnimatedPhysicalModel":
        return [
          const AnimatedPhysicalModelDemo(),
        ];
      case "CustomSingleChildLayout":
        return [
          const CustomSingleChildLayoutDemo(),
          const OffSetWidgetDemo(),
        ];
      case "NavigationRail":
        return [
          const AnotherPage(child: CustomNavigationRail()),
          const AnotherPage(child: ExtendableNavigationRail()),
          const AnotherPage(child: DarkNavigationRail()),
        ];
      case "RawMagnifier":
        return [
          const MagnifierCircleShape(),
          const MagnifierStarShape(),
        ];
      case "DecoratedSliver":
        return [
          const DecorationSliverDemo(),
        ];
      case "SliverConstrainedCrossAxis":
        return [
          const SliverConstrainedCrossAxisDemo(),
        ];
      case "SliverCrossAxisExpanded":
        return [
          const SliverCrossAxisExpandedDemo(),
        ];
      case "SliverCrossAxisGroup":
        return [
          const SliverCrossAxisGroupDemo(),
        ];
      case "SliverMainAxisGroup":
        return [
          const SliverMainAxisGroupDemo(),
        ];
      case "BackButtonIcon":
        return [
          const BackButtonIconDemo(),
        ];
      case "DrawerButtonIcon":
        return [
          const DrawerButtonIconDemo(),
        ];
      case "CloseButtonIcon":
        return [
          const CloseButtonIconDemo(),
        ];
      case "EndDrawerButtonIcon":
        return [
          const EndDrawerButtonIconDemo(),
        ];
      case "EndDrawerButton":
        return [
          const EndDrawerButtonDemo(),
        ];
      case "DrawerButton":
        return [
          const DrawerButtonDemo(),
        ];
      default:
        return [];
    }
  }
}

class AnotherPage extends StatelessWidget {
  final Widget child;
  const AnotherPage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Scaffold(
                  appBar: AppBar(
                    leading: const BackButton(),
                  ),
                  body: child)));
        },
        child: Text('跳转到新界面查看效果'));
  }
}
