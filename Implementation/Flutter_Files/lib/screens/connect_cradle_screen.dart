import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ConnectCradleScreen extends StatefulWidget {
  const ConnectCradleScreen({super.key});

  @override
  State<ConnectCradleScreen> createState() => _ConnectCradleScreenState();
}

class _ConnectCradleScreenState extends State<ConnectCradleScreen> {
  final TextEditingController cradleModelController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColorCode.primaryNeutralColor_600,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Text(
                    'How to connect',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 2),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
              child: TextField(
                controller: cradleModelController,
                decoration: const InputDecoration(
                  labelText: "Enter Cradle Model",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(

              onPressed: () async {
                final model = cradleModelController.text.trim();
                debugPrint("DEBUG: Cradle model entered: '$model'");

                if (model.isEmpty) {
                  debugPrint("DEBUG: No cradle model entered");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter Cradle Model"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  debugPrint("DEBUG: FirebaseAuth user is null (not logged in)");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User not logged in"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
                debugPrint("DEBUG: Formatted date is $date");

                try {
                  final cradleRef = FirebaseDatabase.instanceFor(
                    app: Firebase.app(),
                    databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
                  ).ref("cradles/$model");

                  debugPrint("DEBUG: Writing to cradles/$model for user ${user.uid}");

                  await cradleRef.set({
                    "date": date,
                    "parentId": user.uid,
                    "model": model,
                  });

                  debugPrint("DEBUG: Cradle data successfully written to Firebase");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Cradle connected successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                } catch (e) {
                  debugPrint("ERROR: Failed to write cradle data — $e");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Failed to connect cradle. Try again."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColorCode.secondaryColor_500,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 45),
              ),
              child: const Text("Connect",style: TextStyle(color: Colors.white),),
            ),

            const SizedBox(height: 24),

            /// 👇 Instruction Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    instructionStep("🔌 Step 1: Power On the Cradle",
                        "Plug in your CareNest cradle and power it on. Wait for 10–15 seconds until it starts its internal Wi-Fi."),

                    instructionStep("📶 Step 2: Connect to Cradle Wi-Fi",
                        "Open your phone’s Wi-Fi settings. Look for a network named 'CareNest'. Tap to connect. It required no password."),

                    instructionStep("🌐 Step 3: Open the Configuration Page",
                        "Once connected, your phone may auto-open a setup page. If not, open a browser and go to http://192.168.4.1."),

                    instructionStep("📡 Step 4: Select Your Home Wi-Fi",
                        "The setup page will show a list of available Wi-Fi networks. Select your home Wi-Fi, enter your password, and tap Connect/Save."),

                    instructionStep("⏳ Step 5: Cradle Connects",
                        "The cradle will restart and connect to your home Wi-Fi. This might take around 15–30 seconds."),

                    instructionStep("✅ Step 6: Reopen the App",
                        "Go back to the CareNest app. The cradle will now start sending data and work normally."),

                    instructionStep("❓ Trouble Connecting?",
                        "Make sure you stay connected to the cradle's Wi-Fi during setup. Recheck your home Wi-Fi password. Restart the cradle if needed."),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }


  @override
  void dispose() {
    cradleModelController.dispose();
    super.dispose();
  }

  Widget instructionStep(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              fontFamily: 'Poppins',
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade300,
            thickness: 2,

          )
        ],
      ),

    );
  }


}

