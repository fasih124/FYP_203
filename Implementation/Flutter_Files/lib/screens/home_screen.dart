import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/Model/CradleSensorModel.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/connect_cradle_screen.dart';
import 'package:fyp_203/screens/option_screen.dart';
import 'package:fyp_203/screens/setting_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/services/firebase_sensordata.dart';

import '../Model/BabyPresenceModel.dart';
import '../Model/CardelModel.dart';
import '../Model/SoundSensorModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? cradleModel;
  bool isLoading = true;
  String? modelName;

  @override
  void initState() {
    super.initState();
    loadCradleModel();
  }

  Future<void> loadCradleModel() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final modelKey = await CradleService.getCradleModelForUser(userId);
      if (modelKey != null) {
        final fetchedModelName =
            await CradleService.getModelNameForCradle(modelKey);
        setState(() {
          cradleModel = modelKey;
          modelName = fetchedModelName;
          isLoading = false;
        });
        return;
      }
    }

    // If no user or cradle found
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (cradleModel == null) {
      // return const Scaffold(
      //       //   body: Center(child: Text("No cradle model found")),
      //       // );
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              decoration: const BoxDecoration(
                color: AppColorCode.neutralColor_500,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25), // Rounded bottom-left corner
                  bottomRight: Radius.circular(25), // Rounded bottom-right corner
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x402E5077), // Shadow color
                    blurRadius: 10, // Softness of the shadow
                    spreadRadius: 2, // Spread of the shadow
                    offset: Offset(0, 4), // Shadow offset (horizontal, vertical)
                  ),
                ],
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'HOME',
                          style: TextStyle(
                            color: AppColorCode.primaryColor_500,
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
                            'assets/icons_img/gear_icon.png',
                            width: 25,
                            height: 23,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                        color: AppColorCode.secondaryColor_500, // Line color
                        thickness: 1, // Line thickness
                        indent: 0, // Start padding
                        endIndent: 0 // End padding
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Cradle : ',
                            style: TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: modelName ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await  Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const ConnectCradleScreen();
                            }));

                        setState(() {
                          isLoading = true;
                        });
                        await loadCradleModel();
                      },
                      icon: const Icon(Icons.arrow_forward,
                          color: Colors.white, size: 18),
                      label: const Text(
                        'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorCode.secondaryColor_500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),const SizedBox(
              height: 40,
            ),
            Center(child: Text("No cradle model found"),),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            decoration: const BoxDecoration(
              color: AppColorCode.neutralColor_500,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25), // Rounded bottom-left corner
                bottomRight: Radius.circular(25), // Rounded bottom-right corner
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x402E5077), // Shadow color
                  blurRadius: 10, // Softness of the shadow
                  spreadRadius: 2, // Spread of the shadow
                  offset: Offset(0, 4), // Shadow offset (horizontal, vertical)
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'HOME',
                        style: TextStyle(
                          color: AppColorCode.primaryColor_500,
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
                          'assets/icons_img/gear_icon.png',
                          width: 25,
                          height: 23,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                      color: AppColorCode.secondaryColor_500, // Line color
                      thickness: 1, // Line thickness
                      indent: 0, // Start padding
                      endIndent: 0 // End padding
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Cradle : ',
                          style: TextStyle(
                            color: AppColorCode.primaryColor_500,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: modelName ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await  Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ConnectCradleScreen();
                      }));

                      setState(() {
                        isLoading = true;
                      });
                      await loadCradleModel();
                    },
                    icon: const Icon(Icons.arrow_forward,
                        color: Colors.white, size: 18),
                    label: const Text(
                      'Connect',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  StreamBuilder<BabyPresenceSensorData>(
                    stream: BabyPresenceSensorService.getBabyPresenceSensorData(
                        cradleModel!),
                    builder: (context, snapshot) {
                      String status = 'Loading...';
                      Color statusColor = Colors.grey;

                      if (snapshot.hasData) {
                        final presence = snapshot.data!;
                        status = presence.isPresent ? 'PRESENT' : 'NOT PRESENT';
                        statusColor = presence.isPresent
                            ? AppColorCode.secondaryColor_500
                            : Colors.redAccent;
                      } else if (snapshot.hasError) {
                        status = 'Cradle not found  ';
                        statusColor = Colors.red;
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColorCode.primaryColor_500,
                            width: 4,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Baby Presence :',
                              style: TextStyle(
                                color: AppColorCode.Black_shade,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // temperature
                StreamBuilder<CradleSensorData>(
                  stream: TemperatureSensorService.getTemperatureSensorData(
                      cradleModel!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      if (!data.enable) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color: AppColorCode
                                .primaryColor_600, //Colors.blue[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                'Enable it in setting',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Baby body temperature',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing:
                                  Image.asset('assets/icons_img/temp_Icon.png'),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "${double.tryParse(data.value)?.toStringAsFixed(1) ?? data.value} °F",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby body temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/temp_Icon.png')),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Cradle not found/Error in Loading",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby body temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/temp_Icon.png'),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Loading Data',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby body temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/temp_Icon.png'),
                          ),
                        ),
                      );
                    }
                  },
                ),

                // _buildCard('Moisture', 'DRY', 'assets/icons_img/Droplet.png'),
                StreamBuilder<CradleSensorData>(
                  stream:
                      MoistureSensorService.getMoistureSensorData(cradleModel!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;

                      if (!data.enable) {
                        // Sensor is turned off
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color: AppColorCode.primaryColor_600,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                'Enable it in setting',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Baby Diaper Moisture',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing:
                                  Image.asset('assets/icons_img/Droplet.png'),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              data.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby Diaper Moisture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/Droplet.png')),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color: AppColorCode.primaryColor_600,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Cradle not found/Error in Loading',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby Diaper Moisture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/Droplet.png'),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color: AppColorCode.primaryColor_600,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Loading Data',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby Diaper Moisture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/Droplet.png'),
                          ),
                        ),
                      );
                    }
                  },
                ),

                // _buildCard('Air Quality', '200 AQI','assets/icons_img/aqi_icon.png' ),
                // AQI
                StreamBuilder<CradleSensorData>(
                  stream: AQISensorService.getAQISensorData(cradleModel!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;

                      if (!data.enable) {
                        // Sensor is turned off

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color: AppColorCode
                                .primaryColor_600, //Colors.blue[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                "Enable it in Setting",
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Air Quality',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing:
                                  Image.asset('assets/icons_img/aqi_icon.png'),
                            ),
                          ),
                        );
                      }
                      // Sensor is enabled, show value

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              data.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Air Quality',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/aqi_icon.png')),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Cradle not found/Error in Loading",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Air Quality',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/aqi_icon.png'),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Loading Data",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Air Quality',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/aqi_icon.png'),
                          ),
                        ),
                      );
                    }
                  },
                ),

                // _buildCard('Sound', '500 DB','assets/icons_img/sound_icon.png' ),
                // sound
                StreamBuilder<SoundSensorData>(
                  stream: SoundSensorService.getSoundSensorData(cradleModel!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;

                      if (!data.enable) {
                        // Sensor is turned off
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color: AppColorCode
                                .primaryColor_600, //Colors.blue[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                "Enable it in setting",
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Baby is crying or not',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing: Image.asset(
                                  'assets/icons_img/sound_icon.png'),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              (data.value.toLowerCase() == "true"
                                  ? "Crying"
                                  : "Calm"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby is crying or not',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/sound_icon.png')),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Cradle not found/Error in Loading",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby is crying or not',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/sound_icon.png'),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Loading Data",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby is crying or not',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/sound_icon.png'),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
