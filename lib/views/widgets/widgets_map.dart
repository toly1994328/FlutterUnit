import 'package:flutter/material.dart';
import 'package:flutter_unit/views/widgets/StatefulWidget/stateful_unit.dart';

import 'ProxyWidget/Flexible.dart';
import 'ProxyWidget/Positioned.dart';
import 'ProxyWidget/Spacer.dart';
import 'RenderObjectWidget/MultiChildRenderObjectWidget/Column.dart';
import 'ProxyWidget/Expended.dart';
import 'RenderObjectWidget/MultiChildRenderObjectWidget/Row.dart';
import 'RenderObjectWidget/SingleChildRenderObjectWidget/Center.dart';
import 'RenderObjectWidget/render_object_widget.dart';
import 'StatefulWidget/AnimatedCrossFade.dart';
import 'StatefulWidget/AnimatedList.dart';
import 'StatefulWidget/AnimatedSwitcher.dart';
import 'StatefulWidget/AnimatedWidget/AlignTransition.dart';
import 'StatefulWidget/AnimatedWidget/DecoratedBoxTransition.dart';
import 'StatefulWidget/AnimatedWidget/DefaultTextStyleTransition.dart';
import 'StatefulWidget/AnimatedWidget/RelativePositionedTransition.dart';
import 'StatefulWidget/AnimatedWidget/SlideTransition.dart';
import 'StatefulWidget/DataTable.dart';
import 'StatefulWidget/DragTarget.dart';
import 'StatefulWidget/Draggable.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedAlign.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedContainer.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedDefaultTextStyle.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedOpacity.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedPadding.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedPositioned.dart';
import 'StatefulWidget/ImplicitlyAnimatedWidget/AnimatedPositionedDirectional.dart';
import 'StatefulWidget/LongPressDraggable.dart';
import 'StatefulWidget/PopupMenuButton.dart';
import 'StatefulWidget/indicator/LinearProgressIndicator.dart';
import 'StatefulWidget/nav/MaterialApp.dart';
import 'StatefulWidget/nav/Scaffold.dart';
import 'StatefulWidget/nav/TabBarView.dart';
import 'StatelessWidget/dialog/AboutDialog.dart';
import 'StatelessWidget/dialog/AlertDialog.dart';
import 'StatelessWidget/AnimatedIcon.dart';
import 'StatelessWidget/dialog/BottomSheet.dart';
import 'StatelessWidget/dialog/CupertinoActionSheet.dart';
import 'StatelessWidget/dialog/CupertinoActionSheetAction.dart';
import 'StatelessWidget/dialog/CupertinoAlertDialog.dart';
import 'StatelessWidget/dialog/CupertinoDatePicker.dart';
import 'StatelessWidget/dialog/CupertinoPicker.dart';
import 'StatelessWidget/dialog/CupertinoTimerPicker.dart';
import 'StatelessWidget/dialog/DayPicker.dart';
import 'StatelessWidget/dialog/Dialog.dart';
import 'StatelessWidget/dialog/MonthPicker.dart';
import 'StatelessWidget/dialog/SimpleDialog.dart';
import 'StatelessWidget/dialog/SimpleDialogOption.dart';
import 'StatelessWidget/dialog/SnackBar.dart';
import 'StatelessWidget/dialog/SnackBarAction.dart';
import 'StatelessWidget/dialog/YearPicker.dart';
import 'StatelessWidget/stateless_unit.dart';
import 'TabBar.dart';

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
      case "Text":
        return [
          CustomText(),
          DecorationText(),
          ShadowText(),
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
      case "ActionChip":
        return [CustomActionChip()];
      case "InputChip":
        return [PressInputChip(), SelectInputChip()];
      case "FilterChip":
        return [CustomFilterChip()];
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
          CustomDecoratedBox(),
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
          CustomPadding(),
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
          CustomFlex(),
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
      case "Expended":
        return [
          CustomExpended(),
        ];
      case "Spacer":
        return [
          CustomSpacer(),
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
          CustomCupertinoDialog(),
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
          CustomBottomSheet(),
        ];
    }
  }
}
