import 'package:bounce/bounce.dart';
import 'package:calory/src/common/channels/dart_to_java_channels/water_view_channel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../common_widgets/wave_view.dart';

class WaterView extends StatefulWidget {
  final String email;
  const WaterView(
      {super.key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      required this.email});

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}


class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  late double waterPercentage = 0.0;
  late double waterMLiter = 0.0;
  late String formattedTime = '--';
  late String currentDate;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final Map<dynamic, dynamic>? userInfo =
    await WaterViewDataChannel.getWaterUserInfo(widget.email, currentDate);
    if(userInfo != null){
      final double waterLvl = userInfo['water_level'];
      final double waterPrc = userInfo['water_percentage'];
      final String waterTym = userInfo['water_time'];

      setState(() {
        waterMLiter = waterLvl;
        waterPercentage = waterPrc;
        formattedTime = waterTym;
        print(waterMLiter);
        print(waterPercentage);
        print(formattedTime);
      });
    }else{
      print('Failed to retrieve user data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 3),
                                      child: Text(
                                        '$waterMLiter',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 32,
                                          color: Color(0xFF2633C5),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        'ml',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: Color(0xFF2633C5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 4, top: 2, bottom: 14),
                                  child: Text(
                                    'of daily goal 4.0L',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: Color(0xFF17262A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF2F3F8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.access_time,
                                          color: Colors.grey.withOpacity(0.5),
                                          size: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Last drink $formattedTime',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              'assets/images/bell.png'),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Your bottle is empty, refill it!.',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: waterPercentage == 0.0
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 34,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Bounce(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAFAFA),
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: const Color(0xFF2633C5)
                                            .withOpacity(0.4),
                                        offset: const Offset(4.0, 4.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        DateTime currentTime = DateTime.now();
                                        formattedTime = DateFormat('h:mm a')
                                            .format(
                                                currentTime); //for showing time
                                        waterPercentage += 0.25 *
                                            25; // Increment by 0.25 liters
                                        waterMLiter +=
                                            250; // for showing consumed water in ml
                                        if (waterPercentage > 100.0) {
                                          waterPercentage =
                                              100.0; // Cap at 100%
                                          waterMLiter = 4000;
                                        }
                                        WaterViewDataChannel.setWaterInfo(widget.email, currentDate,waterMLiter,waterPercentage,formattedTime);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Color(0xFF2633C5),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Bounce(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAFAFA),
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: const Color(0xFF2633C5)
                                            .withOpacity(0.4),
                                        offset: const Offset(4.0, 4.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        waterPercentage -=
                                            0.25 * 25; // dec by 0.25 liters
                                        waterMLiter -= 250;
                                        if (waterPercentage < 0.0) {
                                          waterPercentage = 0.0; // Cap at 0%
                                          waterMLiter = 0;
                                        }
                                        WaterViewDataChannel.setWaterInfo(widget.email, currentDate,waterMLiter,waterPercentage,formattedTime);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Color(0xFF2633C5),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 8, top: 16),
                        child: Container(
                          width: 60,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EDFE),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(80.0),
                                bottomLeft: Radius.circular(80.0),
                                bottomRight: Radius.circular(80.0),
                                topRight: Radius.circular(80.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4),
                            ],
                          ),
                          child: WaveViewWater(
                            percentageValue: waterPercentage,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
