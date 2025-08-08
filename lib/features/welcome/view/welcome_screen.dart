import 'dart:async';

import 'package:action_slider/action_slider.dart';
import 'package:edu_tara/core/api/api_service.dart';
import 'package:edu_tara/core/utils/helper_function.dart';
import 'package:edu_tara/core/widgets/company_logo.dart';
import 'package:edu_tara/core/widgets/glassmorphism.dart';
import 'package:edu_tara/features/complaint_screen/service/comlaint_service.dart';
import 'package:edu_tara/features/complaint_screen/view/complaints_list.dart';
import 'package:edu_tara/features/language/view/language_screen.dart';
import 'package:edu_tara/features/welcome/controller/battery_controller.dart';
import 'package:edu_tara/features/welcome/controller/volume_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Timer? oneSecTimer;
  bool isSpeak = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ApiService.fetchAndUpdateBaseUrl();
      Provider.of<BatteryProvider>(
        context,
        listen: false,
      ).fetchOnlineBattery(userID);

      Provider.of<VolumeController>(context, listen: false).fetchVolume(roboId);

      var response = await ComplaintService.getSpeakingStatus();
      if (response['status'] == "success") {
        isSpeak = response['data']['is_speaking'];
        setState(() {});
      }
    });

    oneSecTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      ApiService.fetchAndUpdateBaseUrl();
    });
  }

  bool showVolumeControl = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showVolumeControl = false;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildLeftContent()),
                    const Spacer(flex: 1),
                    Expanded(flex: 3, child: _buildGlassmorphicPanel(context)),
                  ],
                ),
              ),
            ),
            if (showVolumeControl)
              Consumer<VolumeController>(
                builder: (context, controller, _) {
                  return Positioned(
                    top: MediaQuery.of(context).size.height * 0.2,
                    right: 20,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: 80,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 40,
                                    activeTrackColor: Colors.white.withOpacity(
                                      1,
                                    ),
                                    inactiveTrackColor: Colors.grey.withOpacity(
                                      0.3,
                                    ),
                                    thumbColor: Colors.grey.shade700,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12,
                                    ),
                                    overlayColor: Colors.blueAccent.withOpacity(
                                      0.2,
                                    ),
                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0,
                                    ),
                                    valueIndicatorColor: Colors.transparent,
                                  ),
                                  child: Slider(
                                    value: controller.currentVolume.toDouble(),
                                    min: 0,
                                    max: 100,
                                    divisions: 100,
                                    onChanged: (v) {
                                      controller.updateVolume(
                                        roboId,
                                        v.toInt(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              controller.currentVolume == 0
                                  ? Icons.volume_mute_rounded
                                  : controller.currentVolume > 60
                                  ? Icons.volume_up
                                  : Icons.volume_down,
                              color: Colors.white,
                            ),
                            Text(
                              "${controller.currentVolume.round()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CompnayLogo(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.09),
          Text(
            'POLICE TARA',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.sizeOf(context).height * 0.09,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Discover cutting-edge work from top robotics engineers and designers, ready to bring innovation to your next intelligent machine or automation project.',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/speak(TARA)_01.json",
                height: MediaQuery.sizeOf(context).height * 0.3,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphicPanel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: BaseGlassmorphism(
        borderRadius: 30,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _menuButton(
                      icon: "assets/Volume.svg",
                      label: "Volume",
                      onPressed: () {
                        if (showVolumeControl) {
                          setState(() {
                            showVolumeControl = false;
                          });
                        } else {
                          setState(() {
                            showVolumeControl = true;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20),

                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        var response = await ComplaintService.setSpeakingStatus(
                          !isSpeak,
                        );

                        if (response['status'] == "success") {
                          setState(() {
                            isSpeak = response['data']['is_speaking'];
                          });
                        }
                      },
                      child: ChildGlasmorphism(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isSpeak ? Icons.mic : Icons.mic_off,
                              color: Colors.white,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _menuButton(
                      icon: "assets/Home.svg",
                      label: "Menu",
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RealtimeText(),
                        //   ),
                        // );
                      },
                    ),
                  ),
                  SizedBox(width: 20),

                  Expanded(
                    flex: 5,
                    child: _menuButton(
                      icon: "assets/g_translate.svg",
                      label: "Language",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LanguageList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            _buildLetsGoButton(context),
          ],
        ),
      ),
    );
  }

  Widget _menuButton({
    required String icon,
    required String label,
    required Function onPressed,
  }) {
    return Consumer<BatteryProvider>(
      builder: (context, controller, _) {
        return ChildGlasmorphism(
          borderRadius: 10,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(69, 48, 48, 48),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onPressed: () => onPressed(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    const SizedBox(height: 8),
                    Text(label, style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLetsGoButton(BuildContext context) {
    return ChildGlasmorphism(
      borderRadius: 60,
      child: ActionSlider.standard(
        width: double.infinity,
        height: 70,
        backgroundColor: Colors.white.withOpacity(0.15),
        toggleColor: Colors.white,
        icon: const Icon(Icons.arrow_forward, color: Colors.black),
        child: Text(
          'View Complaints',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        action: (controller) async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComplaintsList()),
          );
        },
      ),
    );
  }
}
