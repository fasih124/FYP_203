// import 'package:flutter/material.dart';
// import 'package:fyp_203/screens/setting_screen.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../Model/CardelModel.dart';
// import '../constants/colors_constant.dart';
// import '../services/firebase_sensordata.dart';
// import 'option_screen.dart';
//
// class VideoStreamScreen extends StatefulWidget {
//   const VideoStreamScreen({super.key});
//
//   @override
//   State<VideoStreamScreen> createState() => _VideoStreamScreenState();
// }
//
// class _VideoStreamScreenState extends State<VideoStreamScreen> {
//
//   // late final WebViewController _controller;
//   late  WebViewController _controller;
//   bool isLoading = true;
//   bool isPlaying = false;
//   final String streamUrl = 'http://192.168.212.191';//'http://192.168.100.55/'; // Your ESP32 IP
//
//   @override
//   void initState() {
//     super.initState();
//     isLoading = false;
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(streamUrl));
//
//     // Force loading spinner to disappear after 3 seconds
//     Future.delayed(Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 16.0),
//             decoration: const BoxDecoration(
//               color: AppColorCode.primaryColor_500,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(25), // Rounded bottom-left corner
//                 bottomRight: Radius.circular(25), // Rounded bottom-right corner
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0x402E5077), // Shadow color
//                   blurRadius: 10, // Softness of the shadow
//                   spreadRadius: 2, // Spread of the shadow
//                   offset: Offset(0, 4), // Shadow offset (horizontal, vertical)
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Live Stream',
//                         style: TextStyle(
//                           color: AppColorCode.White_shade,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (builder) => const OptionScreen(),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           'assets/icons_img/gear_2_icon.png',
//                           width: 25,
//                           height: 23,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                       color: AppColorCode.White_shade, // Line color
//                       thickness: 1, // Line thickness
//                       indent: 0, // Start padding
//                       endIndent: 0 // End padding
//                       ),
//                   const SizedBox(
//                     height: 6,
//                   ),
//                   StreamBuilder<CradleModelData>(
//                     stream: CradleModelService.getCradleModel(),
//                     builder: (context, snapshot) {
//                       String modelName = '...';
//                       if (snapshot.hasData) {
//                         modelName = snapshot.data!.model;
//                       } else if (snapshot.hasError) {
//                         modelName = 'Error';
//                       }
//                       return Text(
//                         'Cradle : $modelName',
//                         style: const TextStyle(
//                           color: AppColorCode.White_shade,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(
//                     height: 6,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14.0),
//             child: isPlaying
//                 ? ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     height: 300,
//                     width: 350,
//                     child: WebViewWidget(controller: _controller),
//                   ),
//                   if (isLoading)
//                     Container(
//                       height: 300,
//                       width: 350,
//                       color: Colors.black26,
//                       child: const Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       ),
//                     ),
//                 ],
//               ),
//             )
//                 : Container(
//               width: 350,
//               height: 300,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: const Color(0xFF2F2E41),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x992F2E41),
//                     spreadRadius: 4,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0x33FFFFFF),
//                         spreadRadius: 4,
//                         blurRadius: 10,
//                         offset: Offset(0, 0),
//                       ),
//                     ],
//                   ),
//                   child: InkWell(
//                     // onTap: () {
//                     //   setState(() {
//                     //     isPlaying = true;
//                     //     isLoading = true;
//                     //   });
//                     //
//                     //   // Delay for 3 seconds to simulate stream load
//                     //   Future.delayed(Duration(seconds: 3), () {
//                     //     if (mounted) {
//                     //       setState(() {
//                     //         isLoading = false;
//                     //       });
//                     //     }
//                     //   });
//                     // },
//                     onTap: () async {
//                       setState(() {
//                         isPlaying = false;
//                         isLoading = true;
//                       });
//
//                       // Close previous connection by loading blank page
//                       _controller.loadRequest(Uri.dataFromString(
//                         '<html></html>',
//                         mimeType: 'text/html',
//                       ));
//
//                       // Short delay to allow ESP32 to release old socket
//                       await Future.delayed(const Duration(milliseconds: 500));
//
//                       // Create new controller and start the stream
//                       final newController = WebViewController()
//                         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                         ..setNavigationDelegate(
//                           // NavigationDelegate(
//                           //   onPageStarted: (url) {
//                           //     setState(() {
//                           //       isLoading = true;
//                           //     });
//                           //   },
//                           //   onPageFinished: (url) {
//                           //     // Always show loader for at least 3 sec
//                           //     Future.delayed(const Duration(seconds: 3), () {
//                           //       if (mounted) {
//                           //         setState(() {
//                           //           isLoading = false;
//                           //         });
//                           //       }
//                           //     });
//                           //   },
//                           //   onWebResourceError: (error) {
//                           //     if (mounted) {
//                           //       setState(() {
//                           //         isLoading = false;
//                           //       });
//                           //     }
//                           //     print("Stream error: ${error.description}");
//                           //   },
//                           // ),
//                           NavigationDelegate(
//                             onPageStarted: (url) {
//                               setState(() {
//                                 isLoading = true;
//                               });
//
//                               // Manually hide loader after 2.5 seconds (arbitrary, tweak as needed)
//                               Future.delayed(const Duration(seconds: 3), () {
//                                 if (mounted) {
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                 }
//                               });
//                             },
//                             onWebResourceError: (error) {
//                               if (mounted) {
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                               }
//                               print("Stream error: ${error.description}");
//                             },
//                           ),
//                         )
//                         ..loadRequest(Uri.parse(streamUrl));
//
//                       // Assign and play
//                       setState(() {
//                         _controller = newController;
//                         isPlaying = true;
//                       });
//                     },
//
//                     child: Image.asset(
//                       'assets/icons_img/play_button.png',
//                       width: 95,
//                       height: 89,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 40),
//
//           // Refresh button
//           ElevatedButton.icon(
//             onPressed: () {
//               _controller.reload();
//             },
//             icon: Icon(Icons.refresh,color: Colors.white,),
//             label: Text("Reload Stream",style: TextStyle(color: Colors.white),),
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               textStyle: TextStyle(fontSize: 16),
//               backgroundColor: AppColorCode.secondaryColor_500,
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Load a blank page to stop stream and free ESP32 connection
//     _controller.loadRequest(Uri.dataFromString(
//       '<html></html>',
//       mimeType: 'text/html',
//     ));
//     super.dispose();
//   }
//
//
// }


///////////////////////////////dynamic link///////////////////////////////
import 'package:flutter/material.dart';
import 'package:fyp_203/screens/setting_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Model/CardelModel.dart';
import '../constants/colors_constant.dart';
import '../services/firebase_sensordata.dart';
import '../services/firebase_ipcam_service.dart'; // <- Add this
import 'option_screen.dart';

class VideoStreamScreen extends StatefulWidget {
  const VideoStreamScreen({super.key});

  @override
  State<VideoStreamScreen> createState() => _VideoStreamScreenState();
}

class _VideoStreamScreenState extends State<VideoStreamScreen> {
  late WebViewController _controller;
  bool isLoading = true;
  bool isPlaying = false;
  String? streamUrl;

  @override
  void initState() {
    super.initState();
    fetchIpcamUrlAndInit();
  }

  Future<void> fetchIpcamUrlAndInit() async {

    print("========================================");
    print("========================================");
    print("========================================");
    print("========== FETCHING CAMERA IP ==========");
    print("========================================");
    print("========================================");
    print("========================================");
    print("========================================");
    print("========================================");

    final url = await FirebaseIpcamService.getIpcamUrl();
    if (url != null) {
      print("========================================");
      print("========================================");
      print("========================================");
      print("✅ IP Camera Stream URL: $url");
      print("========================================");
      print("========================================");
      print("========================================");
      print("========================================");
      print("========================================");

      setState(() {
        streamUrl = url;
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(streamUrl!));
        isLoading = false;
      });
    } else {
      print("❌ Failed to fetch IP camera URL. It's null.");
      print("❌ Failed to fetch IP camera URL. It's null.");
      print("❌ Failed to fetch IP camera URL. It's null.");
      print("❌ Failed to fetch IP camera URL. It's null.");
      print("❌ Failed to fetch IP camera URL. It's null.");
      setState(() {
        streamUrl = null;
        isLoading = false;
      });
    }
    print("=========================================");
    print("=========================================");
    print("=========================================");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: isPlaying
                ? _buildWebView()
                : _buildPlayButton(),
          ),
          const SizedBox(height: 40),
          _buildReloadButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      decoration: const BoxDecoration(
        color: AppColorCode.primaryColor_500,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x402E5077),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Live Stream',
                  style: TextStyle(
                    color: AppColorCode.White_shade,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const OptionScreen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icons_img/gear_2_icon.png',
                    width: 25,
                    height: 23,
                  ),
                ),
              ],
            ),
            const Divider(color: AppColorCode.White_shade, thickness: 1),
            const SizedBox(height: 6),
            StreamBuilder<CradleModelData>(
              stream: CradleModelService.getCradleModel(),
              builder: (context, snapshot) {
                String modelName = '...';
                if (snapshot.hasData) {
                  modelName = snapshot.data!.model;
                } else if (snapshot.hasError) {
                  modelName = 'Error';
                }
                return Text(
                  'Cradle : $modelName',
                  style: const TextStyle(
                    color: AppColorCode.White_shade,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildWebView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 300,
            width: 350,
            child: WebViewWidget(controller: _controller),
          ),
          if (isLoading)
            Container(
              height: 300,
              width: 350,
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    return Container(
      width: 350,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF2F2E41),
        boxShadow: const [
          BoxShadow(
            color: Color(0x992F2E41),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33FFFFFF),
                spreadRadius: 4,
                blurRadius: 10,
              ),
            ],
          ),
          child: InkWell(
            onTap: () async {
              if (streamUrl == null) return;

              setState(() {
                isPlaying = false;
                isLoading = true;
              });

              _controller.loadRequest(Uri.dataFromString(
                '<html></html>',
                mimeType: 'text/html',
              ));

              await Future.delayed(const Duration(milliseconds: 500));

              final newController = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onPageStarted: (url) {
                      setState(() => isLoading = true);
                      Future.delayed(const Duration(seconds: 3), () {
                        if (mounted) setState(() => isLoading = false);
                      });
                    },
                    onWebResourceError: (error) {
                      if (mounted) setState(() => isLoading = false);
                      print("Stream error: ${error.description}");
                    },
                  ),
                )
                ..loadRequest(Uri.parse(streamUrl!));

              setState(() {
                _controller = newController;
                isPlaying = true;
              });
            },
            child: Image.asset(
              'assets/icons_img/play_button.png',
              width: 95,
              height: 89,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReloadButton() {
    return ElevatedButton.icon(
      onPressed: () {
        if (streamUrl != null) _controller.reload();
      },
      icon: const Icon(Icons.refresh, color: Colors.white),
      label: const Text("Reload Stream", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: AppColorCode.secondaryColor_500,
      ),
    );
  }

  @override
  void dispose() {
    if (streamUrl != null) {
      _controller.loadRequest(Uri.dataFromString(
        '<html></html>',
        mimeType: 'text/html',
      ));
    }
    super.dispose();
  }
}
