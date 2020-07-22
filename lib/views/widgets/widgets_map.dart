import 'package:flutter/material.dart';

import 'exp/stateful_unit.dart';
import 'exp/stateless_unit.dart';
import 'exp/render_object_unit.dart';
import 'exp/proxy_unit.dart';
import 'exp/other_unit.dart';
import 'exp/sliver_unit.dart';

/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明:

class WidgetsMap {
  static List<Widget> map(String name) {
    switch (name) {
      case "Container":
        return [
          CustomContainer(),
          ContainerWithChild(),
          ContainerAlignment(),
          ContainerDecoration(),
          ContainerTransform(),
          ContainerConstraints()
        ];
      case "CupertinoSegmentedControl":
        return [
          CupertinoSegmentedControlDemo(),
          CupertinoSegmentedControlColor()
        ];
      case "Text":
        return [
          CustomText(),
          ShadowText(),
          DecorationText(),
          TextAlignText(),
          TextDirectionText(),
          SoftWrapText()
        ];
      case "Card":
        return [
          CustomCard(),
          ShapeCard(),
        ];
      case "FlutterLogo":
        return [
          CustomFlutterLogo(),
          FlutterLogoWithText(),
        ];
      case "Banner":
        return [
          CustomBanner(),
        ];

      case "Title":
        return [
          TitleDemo(),
        ];
      case "ToggleButtonsTheme":
        return [
          ToggleButtonsThemeDemo(),
        ];
      case "NavigationToolbar":
        return [
          NavigationToolbarDemo(),
        ];
      case "CupertinoTextField":
        return [
          CupertinoTextFieldDemo(),
          CupertinoTextFieldStyle(),
        ];
      case "MaterialBanner":
        return [
          MaterialBannerDemo(),
          MaterialBannerDemoTwo(),
        ];
      case "OrientationBuilder":
        return [
          OrientationBuilderDemo(),
        ];
      case "Icon":
        return [
          CustomIcon(),
          MyIcon(),
        ];
      case "ImageIcon":
        return [
          CustomImageIcon(),
        ];
      case "FadeInImage":
        return [
          CustomFadeInImage(),
        ];
      case "CircleAvatar":
        return [
          CustomCircleAvatar(),
        ];
      case "Visibility":
        return [
          CustomVisibility(),
          ReplacementVisibility(),
        ];
      case "Chip":
        return [
          CustomChip(),
          ColorOfChip(),
          DeleteOfChip(),
        ];
      case "ChoiceChip":
        return [CustomChoiceChip()];
      case "ListTileTheme":
        return [ListTileThemeDemo()];
      case "ValueListenableBuilder":
        return [ValueListenableBuilderDemo()];
      case "ActionChip":
        return [CustomActionChip()];
      case "MaterialBannerTheme":
        return [MaterialBannerThemeDemo()];
      case "PopupMenuTheme":
        return [PopupMenuThemeDemo()];
      case "InputChip":
        return [PressInputChip(), SelectInputChip()];
      case "FilterChip":
        return [CustomFilterChip()];
      case "IntrinsicHeight":
        return [IntrinsicHeightDemo()];
      case "IntrinsicWidth":
        return [IntrinsicWidthDemo()];
      case "ChipTheme":
        return [ChipThemeDemo()];
      case "ListTile":
        return [CustomListTile(), SelectListTile(), DenseListTile()];
      case "CheckboxListTile":
        return [
          CustomCheckBoxListTile(),
          SelectCheckBoxListTile(),
          DenseCheckBoxListTile()
        ];
      case "SwitchListTile":
        return [
          CustomSwitchListTile(),
          SelectSwitchListTile(),
          DenseSwitchListTile()
        ];

      case "RadioListTile":
        return [
          CustomRadioListTile(),
          DenseRadioListTile(),
        ];

      case "GridTileBar":
        return [
          CustomGridTileBar(),
        ];

      case "GridTile":
        return [
          CustomGridTile(),
        ];
      case "UserAccountsDrawerHeader":
        return [
          CustomUAGHP(),
          ProUAGHP(),
        ];

      case "MaterialButton":
        return [
          CustomMaterialButton(),
          LongPressMaterialButton(),
          ShapeMaterialButton(),
        ];
      case "CupertinoButton":
        return [CustomCupertinoButton()];
      case "FlatButton":
        return [CustomFlatButton()];
      case "RaisedButton":
        return [CustomRaisedButton()];
      case "OutlineButton":
        return [CustomOutlineButton()];
      case "FloatingActionButton":
        return [CustomFAB(), MiniFAB(), ShapeFAB()];

      case "ButtonBar":
        return [
          CustomButtonBar(),
          PaddingButtonBar(),
        ];

      case "IconButton":
        return [
          CustomIconButton(),
        ];
      case "BackButton":
        return [
          CustomBackButton(),
        ];

      case "CloseButton":
        return [
          CustomCloseButton(),
        ];
      case "ToggleButtons":
        return [
          CustomToggleButtons(),
          ColorToggleButtons(),
          ProToggleButtons(),
        ];
      case "ToggleButtons":
        return [
          CustomToggleButtons(),
          ColorToggleButtons(),
          ProToggleButtons(),
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
          CustomDivider(),
          HeightDivider(),
        ];
      case "VerticalDivider":
        return [
          CustomVerticalDivider(),
          HeightVerticalDivider(),
        ];
      case "Placeholder":
        return [
          CustomPlaceholder(),
          FallbackPlaceholder(),
        ];
      case "GridPager":
        return [
          CustomGridPage(),
          DivisionsGridPage(),
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
          CustomTabBar(),
          NoShadowTabBarDemo(),
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
          CustomMaterialApp(),
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
          SortDataTable(),
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
          OneSpacer(),
          ManySpacer(),
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
          CustomAnimatedIcon(),
        ];
      case "Dialog":
        return [
          CustomDialog(),
        ];
      case "AlertDialog":
        return [
          CustomAlertDialog(),
        ];
      case "SimpleDialog":
        return [
          CustomSimpleDialog(),
        ];
      case "CupertinoAlertDialog":
        return [
          CustomCupertinoAlertDialog(),
        ];
      case "AboutDialog":
        return [
          CustomAboutDialog(),
        ];
      case "CupertinoActionSheet":
        return [
          CustomCupertinoActionSheet(),
        ];
      case "CupertinoActionSheetAction":
        return [
          CustomCupertinoActionSheetAction(),
        ];
      case "SimpleDialogOption":
        return [
          CustomSimpleDialogOption(),
        ];
      case "DayPicker":
        return [
          CustomDayPicker(),
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
          CustomSnackBar(),
        ];
      case "SnackBarAction":
        return [
          CustomSnackBarAction(),
        ];
      case "BottomSheet":
        return [
          CustomBottomSheet(),
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
          BuilderDemo(),
        ];
      case "GestureDetector":
        return [
          CustomGestureDetector(),
          TapGestureDetector(),
          PanGestureDetector(),
        ];
      case "Listener":
        return [
          CustomListener(),
        ];
      case "Tab":
        return [
          CustomTab(),
        ];
      case "PreferredSize":
        return [
          CustomPreferredSize(),
          AdapterPreferredSize(),
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
          CustomDrawer(),
        ];
      case "DrawerHeader":
        return [
          CustomDrawerHeader(),
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
          CustomPositionedDirectional(),
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
          BuilderListView(),
          SeparatedListView(),
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
        return [TextThemeDemo(), CustomTheme()];
      case "CupertinoTheme":
        return [TextCupertinoTheme(), CustomCupertinoTheme()];
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
          AboutListTileDemo(),
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
      case "CustomSingleChildLayout":
        return [
          CustomSingleChildLayoutDemo(),
          OffSetWidgetDemo(),
        ];
    }
  }
}
