import 'dart:io';
import 'dart:ui';

import 'package:authentication/blocs/authentic/bloc.dart';
import 'package:authentication/blocs/user/bloc.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentic/event.dart';
import '../../../blocs/user/state.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon trailing = const Icon(
      Icons.navigate_next,
      color: Color(0xffD9D9D9),
    );
    Color? color = Theme.of(context).listTileTheme.tileColor;
    Color? sbgColor = Theme.of(context).appBarTheme.backgroundColor;
    Color? bgColor  = Theme.of(context).scaffoldBackgroundColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    UserPerformance performance = context.select<UserBloc, UserPerformance>(
      (bloc) => bloc.state,
    );
    return Scaffold(
      backgroundColor: isDark ? null : bgColor,
      appBar: AppBar(
        backgroundColor: isDark ? null : sbgColor,
        title: Text(
          '账号资料',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => _showPicker(context),
            child: Container(
              color: color,
              height: 64,
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 15),
                      width: 120,
                      child: Text('头像')),
                  Spacer(),
                  // AuthUserAvatar(
                  //   size: 50,
                  //   borderSize: 2,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: trailing,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1 / window.devicePixelRatio,
            thickness: 1 / window.devicePixelRatio,
          ),
          GestureDetector(
            onTap: () {
              // LoggingUploader.onEvent(kSetNameAction, kMyInfoPageName);
              // Navigator.push(
              //     context,
              //     Right2LeftRouter(
              //         duration: Duration(milliseconds: 200),
              //         child: UserChangeNamePage(
              //           name: performance.username,
              //         )));
            },
            child: Container(
              color: color,
              height: 54,
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 15),
                      width: 120,
                      child: Text('昵称')),
                  Spacer(),
                  Text(
                    performance.username ?? '',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: trailing,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1 / window.devicePixelRatio,
            thickness: 1 / window.devicePixelRatio,
          ),
          Container(
            color: color,
            height: 54,
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 15),
                    width: 120,
                    child: const Text('箴言')),
                Spacer(),
                Text(
                  // '${performance.userId}',
                  '海的彼岸，有我未曾见证的风采。', style: TextStyle(color: Colors.grey,fontSize: 12),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 20,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),

          // const SizedBox(
          //   height: 10,
          // ),

          // Container(
          //   color: color,
          //   height: 54,
          //   child: Row(
          //     children: [
          //       Container(
          //           padding: EdgeInsets.only(left: 15),
          //           width: 120,
          //           child: Text('免费蜂蜜/日')),
          //       Spacer(),
          //       Text(
          //         '${ 0}',
          //         style: TextStyle(color: Colors.grey),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 12),
          //         child: Icon(
          //           Icons.arrow_forward_ios_sharp,
          //           size: 20,
          //           color: Colors.transparent,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Divider(
          //   height: 1 / window.devicePixelRatio,
          //   thickness: 1 / window.devicePixelRatio,
          // ),
          // Container(
          //   color: color,
          //   height: 54,
          //   child: Row(
          //     children: [
          //       Container(
          //           padding: EdgeInsets.only(left: 15),
          //           width: 120,
          //           child: Text('蜂蜜')),
          //       Spacer(),
          //       Text(
          //         '${0}',
          //         style: TextStyle(color: Colors.grey),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 12),
          //         child: Icon(
          //           Icons.arrow_forward_ios_sharp,
          //           size: 20,
          //           color: Colors.transparent,
          //         ),
          //       )
          //     ],
          //   ),
          // ),

          const SizedBox(
            height: 10,
          ),
          Container(
            color: color,
            height: 54,
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 15),
                    width: 120,
                    child: const Text('账号')),
                Spacer(),
                Text(
                  // '${performance.userId}',
                  '******', style: TextStyle(color: Colors.grey,fontSize: 12),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 20,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: const Center(
                child: Text(
                  '退出登录',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),

            // trailing: _nextIcon(context),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertConformDialog(
                      title: "登出提示",
                      content: "退出后将无法使用用户相关的功能，确定退出登录吗？",
                      conformText: '确定',
                      onConform: () async {
                        context.read<AuthBloc>().add(const Logout());
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   NoAnimRouter(AuthRelation(
                        //     pushLogin: false,
                        //     child: MoAILoginPage(
                        //       model: LoginModel(
                        //           appName: "蜜蜂AI智能助手",
                        //           appNameEn:
                        //           "Bee Chat AI Intelligence Assistant",
                        //           appIcon: Icons.widgets_outlined,
                        //           loginBgAssets: "assets/images/login_bg.png"),
                        //     ),
                        //   )),
                        //   ModalRoute.withName('/'),
                        // );
                        return true;
                      }));
            },
          ),
          Divider(
            height: 1 / window.devicePixelRatio,
            thickness: 1 / window.devicePixelRatio,
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // if(false)
          ListTile(
            title: Center(
                child: const Text(
                  '删除账号',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                )),

            // trailing: _nextIcon(context),
            onTap: () {
              String msg =
                  "确定删除账号吗？删除后你将无法再访问蜜蜂 ai 提供的智能服务，并清空你的所有账号资料，点击确定删除。";
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                    child: MobileMessagePanel(
                      title: '清空提示',
                      conformText: '确定',
                      msg: msg,
                      task: (_) async {
                        // await Future.delayed(Duration(seconds: 3));
                        // await context.read<UserBloc>().repo.unregister();
                        //
                        context.read<AuthBloc>().add(Logout());

                        // Navigator.of(context).pushAndRemoveUntil(
                        //   NoAnimRouter(AuthRelation(
                        //     pushLogin: false,
                        //     child: MoAILoginPage(
                        //       model: LoginModel(
                        //           appName: "蜜蜂AI智能助手",
                        //           appNameEn:
                        //           "Bee Chat AI Intelligence Assistant",
                        //           appIcon: Icons.widgets_outlined,
                        //           loginBgAssets:
                        //           "assets/images/login_bg.png"),
                        //     ),
                        //   )),
                        //   ModalRoute.withName('/'),
                        // );
                      },
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context) async {
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(type: FileType.image);
    // if (result != null) {
    //   String? p = result.files.single.path;
    //   if (p != null) {
    //     // File file = File(p);
    //     // Share.shareXFiles([XFile(file.path)], text: 'Great picture');
    //     Navigator.push(
    //         context,
    //         NoAnimRouter(ClipImagePage(
    //           image: FileImage(File(p)),
    //         )));
    //   }
    // }
    // // showCupertinoModalPopup(
    // //     context: context,
    // //     builder: (ctx) => ClipRRect(
    // //           borderRadius: BorderRadius.only(
    // //             topLeft: Radius.circular(10),
    // //             topRight: Radius.circular(10),
    // //           ),
    // //           child: SizedBox(
    // //             width: 500,
    // //             child: AsyncPopPicker(
    // //               title: Text(
    // //                 '更换头像',
    // //                 style: TextStyle(color: Colors.grey),
    // //               ),
    // //               tasks: [
    // //                 AsyncPopItem(
    // //                   task: () async {
    // //                     try {
    // //                       FilePickerResult? result = await FilePicker.platform
    // //                           .pickFiles(type: FileType.image);
    // //                       if (result != null) {
    // //                         String? p = result.files.single.path;
    // //                         if (p != null) {
    // //                           // File file = File(p);
    // //                           // Share.shareXFiles([XFile(file.path)], text: 'Great picture');
    // //                           Navigator.push(
    // //                               context,
    // //                               NoAnimRouter(ClipImagePage(
    // //                                 image: FileImage(File(p)),
    // //                               )));
    // //                         }
    // //                       }
    // //                     } catch (e) {
    // //                       Toast.warning("当前应用没有文件读写权限，请先在权限管理中允许!");
    // //                     }
    // //                   },
    // //                   info: '从相册选取',
    // //                 ),
    // //               ],
    // //             ),
    // //           ),
    // //         ));
  }
}

class UserItemPanel extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const UserItemPanel(
      {Key? key, required this.label, required this.value, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 54,
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 15), child: Text(label)),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
