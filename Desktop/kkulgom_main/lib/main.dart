import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

var AllFontColor = Color(0xff706C60);
var AllWidgetRadius = 30.0;
var AllWidgetColor = Color(0xffFCFAF5);
var AllBackgroundColor = Color(0xffEDEDE6);
var AllTonedownColor = Color(0xffE3E3D3);

var yestlist = ['잠', '유튜브', '유튜브'];
var yestTime = ['3', '2', '1'];
var yestlistIcon = ['sleep.png', 'youtube.png', 'youtube.png'];
var todayList = [false, false, false, false, false, false, false, false, false];
var todayListUp = '';
var todayListUpTime = 0;
var todayListIcon = ['youtube.png', 'instagram.png', 'facebook.png'];
var todayListName = ['유튜브', '인스타그램', '페이스북', '에브리타임', '낮잠', '늦잠', '멍때림', '딴짓', '야식'];
var todayTime = [0,0,0,0,0,0,0,0,0];
var todayListNow = false;
var addPoint = false;

var notifyMe = false;
var notifyHour = 9;
var notifyMin = 47;

var emotion = [false, false, false];

var badge = 5;
var badgeListIcon = ['badge1.png','badge2.png','badge3.png'];
var badgelist = ['첫 만남', '두 번째 꿀곰', '세 번째 꿀곰', '네 번째 꿀곰', '다섯 번째 꿀곰', '여섯 번째 꿀곰']; //badge title badgelistText = ['첫 꿀곰 기록', '챌린지 첫 경험', '처음으로 돌아본 나', '네번째', '5']; //badge 설명
var badgeHave = 2; //badge를 가지고 있는지
var mytext = '';
bool challengeHow = true;
var challengelistHowImage = ['youtube.png', 'facebook.png', 'instagram.png'];
var challengelistHow = [['descriptionddddddddddddddddddddddddddddddddddddddd', 'blabladdddddddddddddddddddddddddddddddddddddd', 'youtube'], ['description', 'water'], ['description', 'blablapal', 'gupyeo', '10gae']];
var challengelist = ['유튜브 1시간보다 적게 보기', '물 마시고 오기', '팔 굽혀 펴기 10개']; //각 챌린지 별 내용
var challengelistPoint = [10, 20, 40]; //각 챌린지 별 포인트 지급
var challengeListIcon = [Icons.tv_rounded, Icons.water_drop_rounded];
var challengeListIconColor = [Colors.red, Colors.blueAccent];
var sum = 0;
var successChallenge = []; //완료한 챌린지 인덱스
var successChallengePoint = [];
var now = Random().nextInt(2); //내가 하고 있는 챌린지의 인덱스
var answer = Random().nextInt(question.length);
bool _isChallenge = true; //챌린지 위젯을 메인에 보여줄건지?
bool _nowChallenge = false; //지금 챌린지를 하고 있는지?
bool todayChallenge = false; //오늘의 챌린지를 수행했는지?
bool completeChallenge = false; //오늘의 챌린지를 완료했는지?
var question = ['Google의 첫 CEO는?', 'Linux는 어떤 OS를 뿌리로 두고 있을까요?', 'B2B의 뜻은?', '테스트', '테스트2', '테스트3'];
var questionAnswer = ['래리 페이지', 'Unix', '비지니스 투 비지니스', '테스트', '테스트2', '테스트3'];
var questionPoint = [10, 20, 30, 20, 10, 20];

var AllTop = [false, false, false];

var CalendarBorder = [Colors.transparent, AllWidgetColor, AllFontColor];
var CalendarText = [AllFontColor, AllFontColor, AllWidgetColor];
var BackColor = [Color(0xffEDEDE6), Color(0xffEDEDE6), Colors.white, Colors.black];
var savedDate = '';
var todayEnter = 1;

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  var strToday = formatter.format(now);
  return strToday;
}

void main() {
  initializeDateFormatting().then((_) => runApp(const FirstApp()));
}


class FirstApp extends StatefulWidget {
  const FirstApp({Key? key}) : super(key: key);

  @override
  State<FirstApp> createState() => _FirstAppState();
}





class _FirstAppState extends State<FirstApp> {

  @override
  void initState() {
    super.initState();
    loadChallengeHow();
    loadNotifyMe();
    loadSavedDate();
    if (savedDate == getToday()){
      setSavedDate();
    }
    else {
      setSavedDate();
    }
  }
  @override
  setSavedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setString('savedDate', getToday());
      if (savedDate == getToday()){
        todayEnter += 1;
      }
      else {
        todayEnter = 1;
      }
      prefs.setInt('todayEnter', todayEnter);
    });
  }
  @override
  loadSavedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      savedDate = prefs.getString('savedDate') ?? getToday();
      todayEnter = prefs.getInt('todayEnter') ?? 0;
    });
  }
  @override
  loadChallengeHow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      challengeHow = prefs.getBool('challengeHow') ?? challengeHow;
      print('loadChallengeHow');
      print('loadchallengeHow: $challengeHow');
    });
  }
  @override
  loadNotifyMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      notifyMe = prefs.getBool('notifyMe') ?? notifyMe;
    });
  }
  int _currentIndex = 0;
  final List<Widget> _children = [FirstPage(), SecondPage(), ThirdPage(), AboutUs()];

  void _onTap(int index) {
    setState((){
      _currentIndex = index;
      print(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Noto_Serif_KR',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: Scaffold(
        backgroundColor: BackColor[_currentIndex],
        body: _children[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xffEFEFEF), width: 1.0),
            )
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffF2F2F2),
            selectedItemColor: Colors.black,
            unselectedItemColor: Color(0xffB1B1B1),
            selectedFontSize: 10,
            unselectedFontSize: 10,
            currentIndex: _currentIndex,
            onTap: _onTap,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.list_rounded), label: '기록'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: '레벨'),
              BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: '우리'),
            ],
          ),
        ),
      ),
    );
  }
}


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);


  @override
  State<FirstPage> createState() => _FirstPageState();
}



class _FirstPageState extends State<FirstPage> with WidgetsBindingObserver{

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _init();
    loadNotifyMe();
    loadSavedDate();
  }
  @override
  loadSavedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      savedDate = prefs.getString('savedDate') ?? getToday();
      todayEnter = prefs.getInt('todayEnter') ?? 0;
    });
  }

  @override
  loadNotifyMe () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      notifyMe = prefs.getBool('notifyMe') ?? notifyMe;
    });
  }
  setNotifyMe () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      print('setNotifyMe: $notifyMe');
      notifyMe ? notifyMe = false : notifyMe = true;
      prefs.setBool('notifyMe', notifyMe);
      print('setNotifyMe');
      print('setNotifyMe: $notifyMe');
    });
  }


  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterAppBadger.removeBadge();
    }
  }

  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> _initializeNotification() async {
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _registerMessage({
    required int hour,
    required int minutes,
    required message,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '꿀곰',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const IOSNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  @override
  setSavedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setInt('todayEnter', 1);
      todayEnter = prefs.getInt('todayEnter') ?? 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child:
      ListView(children: [
        Container(
            margin: EdgeInsets.only(bottom: 30, top: 20, left: 10),
            child: Row(
              children: [
                Image.asset('assets/logo.png', height: 30),
                Text('$todayEnter'),
              ],
            )
        ),
        Visibility(
            child: MainchallengeButton(),
            visible: todayChallenge ? false : true),

        NewButton(),
        WidgetBlock(),
        Row(children: [
          Flexible(
              child: WidgetBadge(),
              flex: 2
          ),
          Flexible(
              child: WidgetPoint(),
              flex: 2
          ),
          Flexible(
              child: WidgetAll(),
              flex: 1
          ),
        ]),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xffE3E3D3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AllWidgetRadius),
            ),
            elevation: 0.0,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          ),
          onPressed: () {
            setState((){
              setSavedDate();
            });
          },
          child: Text('날짜 재지정', style: TextStyle(color: Color(0xff4F4F46))),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
    primary: Color(0xffE3E3D3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AllWidgetRadius),
            ),
            elevation: 0.0,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
    ),
          onPressed: () {
            setState((){
              _isChallenge = true;
              _nowChallenge = false;
              todayChallenge = false;
            });
          },
          child: Text('챌린지 생성', style: TextStyle(color: Color(0xff4F4F46))),
        ),
      ]),
    );
  }
}




class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  var _selectedDay;
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child:
        ListView(children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AllFontColor.withOpacity(0.1),
                  width: 1.0,
                ),
              )
            ),
            margin: EdgeInsets.only(bottom: 30, top: 0),
            child: Column(children: [
              TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  headerMargin: EdgeInsets.only(bottom: 20),
                ),
                locale: 'ko-KR',
                  focusedDay: _focusedDay,
                  firstDay: DateTime.now().subtract(Duration(days:365*10+2)),
                  lastDay: DateTime.now().add(Duration(days: 365*10+2)),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                    setState((){
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                },
                onPageChanged: (focusedDay){
                    _focusedDay = focusedDay;
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format){
                    setState((){
                      _calendarFormat = format;
                    });
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, dateTime, _) {
                    return CalendarCellBuilder(context, dateTime, _, 0);
                  },
                  todayBuilder: (context, dateTime, _) {
                    return CalendarCellBuilder(context, dateTime, _, 1);
                  },
                  selectedBuilder: (context, dateTime, _) {
                    return CalendarCellBuilder(context, dateTime, _, 2);
                  },
                ),
              ),
            ])
          ),
    ])
    );
  }
}



Widget CalendarCellBuilder(BuildContext context, DateTime dateTime, _, int type) {
  String date = DateFormat('dd').format(dateTime);
  return Container(
    padding: EdgeInsets.all(3),
    child: Container(
      padding: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CalendarBorder[type],
      ),
      child: Center(child: Text('$date', style: TextStyle(color: CalendarText[type], fontSize: 17))),
    )
  );
}



class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, top: 50, left: 20, right: 20),
      child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 50),
                    Text(' $sum', style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)),
                  ]),
            ),
            Text('\n    포인트를 모아 뱃지를 얻을 수 있어요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\n\n   내역', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(children: [
                            if (successChallenge.length > 0)
                              for(var i = successChallenge.length - 1; i >= 0; i--)
                                Container(
                                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffF7F7F7),
                                    ),
                                    child: Row(children: [
                                      Text(successChallenge[i], style: TextStyle(color: Colors.black, fontSize: 17)),
                                      Spacer(),
                                      Icon(Icons.monetization_on_rounded, color: Colors.grey, size: 20),
                                      Text(' ' + successChallengePoint[i].toString(), style: TextStyle(color: Colors.grey, fontSize: 15)),
                                    ])
                                )
                            else
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('\n\n\n\n\n'),
                                    Icon(Icons.history_toggle_off_rounded, color: Colors.grey, size: 40),
                                    Text('\n포인트를 얻은 내역이 없어요.',style: TextStyle(color: Colors.grey, fontSize: 20)),
                                    Text('\n챌린지를 완수하여 포인트를 얻을 수 있어요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                  ],
                                ),
                              ),
                          ])
                      )
                    ])
            )
          ]),
    );
  }
}


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
            child:
            Container(
                margin: EdgeInsets.only(top: 30),
                child: ListView(children: [
                  Image.asset('assets/character.png', height: 100),
                  Container(
                    margin: EdgeInsets.only(bottom: 30, top: 20),
                    child:
                    Center(child: Image.asset('assets/aboutus/aboutus.png', height: 50)),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: Row(children:[
                            Image.asset('assets/aboutus/KangPic.png', width: 50),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/aboutus/Kang.png', height: 35),
                                  Image.asset('assets/aboutus/KangInfo.png', height: 35),
                                  Text('\n하고 싶은 말', style: TextStyle(color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ),]

                          )
                      )
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: Row(children:[
                            Image.asset('assets/youtube.png', width: 50),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/aboutus/Lee.png', height: 35),
                                  Image.asset('assets/aboutus/LeeInfo.png', height: 35),
                                  Text('\n하고 싶은 말', style: TextStyle(color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ),]

                          )
                      )
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: Row(children:[
                            Image.asset('assets/aboutus/KimPic.png', width: 50),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/aboutus/Kim.png', height: 35),
                                  Image.asset('assets/aboutus/KimInfo.png', height: 35),
                                  Text('\n하고 싶은 말', style: TextStyle(color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ),]

                          )
                      )
                  )
                ])
            )
        )
    );
  }
}
class SecondApp extends StatefulWidget {
  const SecondApp({Key? key}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: Scaffold(
          backgroundColor: AllWidgetColor,
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              backgroundColor: AllWidgetColor,
              elevation: 0.0,
              centerTitle: true,
              leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.navigate_before, color: AllFontColor, size: 40),
                  )
              )
          ),
          body: todayListNow ?
          Container(
              margin: EdgeInsets.all(25),
              child: ListView(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.timelapse_rounded, color: Colors.amber),
                    ]),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('선택한 게으름에\n시간을 매겨주세요!\n', style: TextStyle(color: AllFontColor, fontSize: 30, fontWeight: FontWeight.bold))),
                Column(children: <Widget>[
                  for(var i = 0; i < todayList.length; i++)
                    if(todayList[i] == true)
                      Container(
                          decoration: BoxDecoration(
                            color: AllBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(20),
                          child: Row(children: [
                            Text(todayListName[i], style: TextStyle(color: AllFontColor, fontSize: 20)),
                            Spacer(),
                            DropdownMenu(),
                          ])
                      )
                ]),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: AllBackgroundColor,
                      ),
                      onPressed: () {
                        setState((){
                          for(var i = 0; i < todayList.length; i++){
                            if(todayList[i] == true){
                              todayListUp = todayListName[i];
                            }
                          }
                          Navigator.pop(context);
                        });
                      },
                      child:
                      Row(children: [
                        Text(' '),
                        Spacer(),
                        Text('기록하기', style: TextStyle(color: AllFontColor, fontSize: 20)),
                        Spacer(),
                        Text(' '),
                      ]),
                    )
                )
              ]
              )
          ) :
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(25),
                  child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.spoke_rounded, color: Colors.amber),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child:
                          Text('오늘의 게을렀던\n행동을 선택해주세요.', style: TextStyle(color: AllFontColor, fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              GridView.builder(
                                itemCount: 9,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index){
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                          primary: todayList[index] ? AllFontColor : AllBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          )
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          todayList[index] ? todayList[index] = false : todayList[index] = true;
                                          print(todayList);
                                        });
                                      },
                                      child: Text(todayListName[index], style: TextStyle(color: todayList[index] ? AllWidgetColor : AllFontColor, fontSize: 17),
                                      )
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: AllBackgroundColor,
                      ),
                      onPressed: () {
                        setState((){
                          todayListNow = true;
                        });
                      },
                      child:
                      Row(children: [
                        Text(' '),
                        Spacer(),
                        Text('기록하기', style: TextStyle(color: AllFontColor, fontSize: 20)),
                        Spacer(),
                        Text(' '),
                      ]),
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
class BadgeApp extends StatelessWidget {
  const BadgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: AllWidgetColor,
            appBar: AppBar(
                backgroundColor: AllWidgetColor,
                elevation: 0.0,
                leading: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                      },
                      child: Icon(Icons.navigate_before_rounded, color: AllFontColor, size: 40),
                    )
                )
            ),
            body: Container(
                color: AllWidgetColor,
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView(children: [
                  Column(children:[
                    Text('활동 뱃지', style: TextStyle(color: AllFontColor, fontSize: 30, fontWeight: FontWeight.bold)),
                    Text('\n다양한 활동을 통해 뱃지를 얻을 수 있어요.', style: TextStyle(color: Colors.grey, fontSize: 20)),
                  ]),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(top: 60),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2/3,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: badgelist.length,
                        itemBuilder: (context, index) {
                          return Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Column(children: <Widget>[
                                if (badgeHave > index)
                                  Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: AllBackgroundColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(child: Image.asset('assets/badge/'+badgeListIcon[index], width: 40)))
                                else
                                  Container(width: 70, height: 70, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AllBackgroundColor, ),),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: [
                                        Text(badgelist[index], style: TextStyle(color: AllFontColor, fontSize: 15, fontWeight: FontWeight.bold),),
                                      ],
                                    )),

                              ])
                          );
                        }
                    ),
                  )
                ],)
            )
        )
    );
  }
}


class StrictApp extends StatefulWidget {
  const StrictApp({Key? key}) : super(key: key);

  @override
  State<StrictApp> createState() => _StrictAppState();
}

class _StrictAppState extends State<StrictApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
              backgroundColor: Colors.white,
              leading: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.navigate_before_rounded, color: AllFontColor, size: 40),
                  )
              )
          ),
          body: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListView(children: [
                Column(children:[
                  Text('시간 제한', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                  Text('\n특정 앱의 사용 시간을 제한할 수 있어요.\n\n', style: TextStyle(color: Colors.grey, fontSize: 20)),
                ]),
                for(var i = 0; i < todayList.length; i++)
                  if(todayList[i] == true)
                    Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(20),
                        child: Row(children: [
                          Text(todayListName[i], style: TextStyle(color: Colors.black, fontSize: 17)),
                          Spacer(),
                          DropdownMenu(),
                        ])
                    )
              ],)
          ),
          bottomNavigationBar:Container(
              margin: EdgeInsets.fromLTRB(40, 20, 40, 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: Color(0xffF2F2F2),
                ),
                onPressed: () {
                  setState((){
                    Navigator.pop(context);
                  });
                },
                child:
                Row(children: [
                  Text(' '),
                  Spacer(),
                  Text('제한 시작', style: TextStyle(color: Colors.black, fontSize: 20)),
                  Spacer(),
                  Text(' '),
                ]),
              )
          ),
        )
    );
  }
}
class AllApp extends StatefulWidget {
  const AllApp({Key? key}) : super(key: key);

  @override
  State<AllApp> createState() => _AllAppState();
}

class _AllAppState extends State<AllApp> with WidgetsBindingObserver{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<dynamic> notifyDialog(BuildContext context) async {

    final HourController = TextEditingController();
    final MinController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0.0,
              backgroundColor: AllBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Center(child: Text('알림 시간 설정', style: TextStyle(color: AllFontColor, fontSize: 20, fontWeight: FontWeight.bold),)),
              content: SingleChildScrollView(
                  child: notifyMe ? Column(
                      children: [
                        Text('24시간 형식으로 입력해야 해요.\n', style: TextStyle(color: AllFontColor, fontSize: 15)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AllTonedownColor,
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '시간',
                                  hintStyle: TextStyle(color: AllFontColor)
                              ),
                              controller: HourController,
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AllTonedownColor,
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '분',
                                hintStyle: TextStyle(color: AllFontColor),
                              ),
                              controller: MinController,
                            )
                        ),
                        Container(
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text('시간 바꾸기', style: TextStyle(fontSize: 20, color: AllFontColor)),
                                  Spacer(),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0.0,
                                primary: AllWidgetColor,
                              ),
                              onPressed: () async {
                                if (int.parse(HourController.text) >= 0 && int.parse(HourController.text) < 24 && int.parse(MinController.text) >= 0 && int.parse(MinController.text) <= 60){
                                  setState((){
                                    notifyHour = int.parse(HourController.text);
                                    notifyMin = int.parse(MinController.text);
                                    setNotifyTime();
                                  });
                                  await _cancelNotification();
                                  await _requestPermissions();

                                  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
                                  await _registerMessage(
                                    hour: notifyHour,
                                    minutes: notifyMin,
                                    message: '오늘의 꿀곰 챌린지가 있어요!',
                                  );

                                  print(notifyHour);
                                  print(notifyMin);
                                  Navigator.pop(context);
                                }
                                else {
                                  Fluttertoast.showToast(
                                    msg: "유효하지 않은 시간이에요.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: AllFontColor,
                                    textColor: AllWidgetColor,
                                  );
                                }
                              },
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              child: Text('알림 끄기', style: TextStyle(fontSize: 15, color: Colors.redAccent)),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0.0,
                                primary: AllBackgroundColor,
                              ),
                              onPressed: () async {
                                await _cancelNotification();
                                setNotifyMe();
                                Navigator.pop(context);
                              },
                            )
                        ),
                      ]
                  ):
                  Column(
                      children: [
                        Text('알림이 꺼져 있어요.\n', style: TextStyle(color: AllFontColor, fontSize: 20)),
                        Container(
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text('알림 켜기', style: TextStyle(fontSize: 20, color: AllFontColor)),
                                  Spacer(),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0.0,
                                primary: AllWidgetColor,
                              ),
                              onPressed: () async {
                                await _cancelNotification();
                                await _requestPermissions();

                                final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
                                await _registerMessage(
                                  hour: notifyHour,
                                  minutes: notifyMin,
                                  message: '오늘의 꿀곰 챌린지가 있어요!',
                                );
                                setNotifyMe();
                                Navigator.pop(context);
                              },
                            )
                        ),
                      ]
                  )
              )
          );
        }
    );
  }
  @override
  setNotifyMe () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      print('setNotifyMe: $notifyMe');
      notifyMe ? notifyMe = false : notifyMe = true;
      prefs.setBool('notifyMe', notifyMe);
      print('setNotifyMe');
      print('setNotifyMe: $notifyMe');
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _init();
    loadChallengeHow();
    loadNotifyTime();
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterAppBadger.removeBadge();
    }
  }

  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> _initializeNotification() async {
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _registerMessage({
    required int hour,
    required int minutes,
    required message,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '꿀곰',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const IOSNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  @override
  setChallengeHow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      challengeHow ? challengeHow = false : challengeHow = true;
      prefs.setBool('challengeHow', challengeHow);
      print('setChallengeHow');
    });
  }
  @override
  loadChallengeHow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      challengeHow = prefs.getBool('challengeHow') ?? challengeHow;
      print('loadChallengeHow');
      print(challengeHow);
    });
  }
  @override
  setNotifyTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setInt('notifyHour', notifyHour);
      prefs.setInt('notifyMin', notifyMin);
    });
  }
  @override
  loadNotifyTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      notifyHour = prefs.getInt('notifyHour') ?? notifyHour;
      notifyMin = prefs.getInt('notifyMin') ?? notifyMin;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('challengeHow: $challengeHow');
    return MaterialApp(
        home: Scaffold(
          backgroundColor: AllBackgroundColor,
          appBar: AppBar(
              backgroundColor: AllBackgroundColor,
              elevation: 0.0,
              leading: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.navigate_before_rounded, color: AllFontColor, size: 40),
                  )
              ),
              title: Text('설정', style: TextStyle(color: AllFontColor, fontSize: 20)),
          ),
          body:
          Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: ListView(
              children: [
                Text('    알림', style: TextStyle(color: AllFontColor, fontSize: 17, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AllWidgetColor,
                  ),
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: AllWidgetColor,
                            elevation: 0.0
                        ),
                        child: Row(children: [
                          Container(
                            width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                              ),
                              child: Center(child: Icon(Icons.notifications_rounded, color: Colors.white, size: 20))),
                          Text('   알림', style: TextStyle(color: Colors.black, fontSize: 20)),
                          Spacer(),
                          Text(notifyMe ? '켜짐' : '꺼짐', style: TextStyle(color: Colors.grey, fontSize: 17)),
                          Icon(Icons.navigate_next_rounded, color: AllWidgetColor),
                        ]),
                        onPressed: () {
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(left: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: AllWidgetColor,
                          elevation: 0.0
                        ),
                        child: Row(children: [
                          Container(
                            height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent,
                              ),
                              child: Center(child: Icon(Icons.watch_later_rounded, color: Colors.white, size: 20))),
                          Text('   알림 시간', style: TextStyle(color: Colors.black, fontSize: 20)),
                          Spacer(),
                          Text(notifyMe ? '${notifyHour}시 ${notifyMin}분' : '꺼져 있음', style: TextStyle(color: Colors.grey, fontSize: 17)),
                          Icon(Icons.navigate_next_rounded, color: Colors.grey),
                        ]),
                        onPressed: () {
                          notifyDialog(context);
                        },
                      ),
                    ],
                  )
                ),
                Text('    도전 과제', style: TextStyle(color: AllFontColor, fontSize: 17, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AllWidgetColor,
                  ),
                    margin: EdgeInsets.only(top: 10),
                    child: Row(children: [
                      Container(
                        height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Center(child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 20))),
                      Text('   도전 과제 형태', style: TextStyle(color: Colors.black, fontSize: 20)),
                      Spacer(),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AllTonedownColor,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                          child: Text(challengeHow ? '활동' : '문제', style: TextStyle(color: AllFontColor, fontSize: 17)),
                          onPressed: () {
                            setState((){
                              _nowChallenge = false;
                              _isChallenge = false;
                              setChallengeHow();
                              print(challengeHow);
                            });
                          },
                        )
                      )
                    ])
                )
              ]
            ),
          ),
        )
    );
  }
}







class WidgetBadge extends StatelessWidget {
  const WidgetBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 15, right: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(25),
              primary: AllWidgetColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AllWidgetRadius),
              ),
            elevation: 0.0,
          ),
          child: Column(children: [
            Row(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('현재', style: TextStyle(color: Colors.grey, fontSize: 15)),
                    Text(' ', style: TextStyle(fontSize: 6)),
                    Text('뱃지', style: TextStyle(color: AllFontColor, fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
              Spacer(),
              Text(' '),
            ]),
            Spacer(),
            Row(
              children: [
                Text(' '),
                Spacer(),
                Icon(Icons.verified_rounded, color: Colors.amber, size: 30),
              ],
            ),
          ]),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BadgeApp()),
            ),
          },
        )
    );
  }
}



class WidgetPoint extends StatelessWidget {
  const WidgetPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 15, right: 5, left: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(25),
              primary: AllWidgetColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AllWidgetRadius),
              ),
            elevation: 0.0,
          ),
          child: Column(children: [
            Row(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('앱', style: TextStyle(color: Colors.grey, fontSize: 15)),
                    Text(' ', style: TextStyle(fontSize: 6)),
                    Text('제한', style: TextStyle(color: AllFontColor, fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
              Spacer(),
              Text(' '),
            ]),
            Spacer(),
            Row(
              children: [
                Text(' '),
                Spacer(),
                Icon(Icons.access_alarm_rounded, color: Colors.blueAccent, size: 30),
              ],
            ),
          ]),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StrictApp()),
            ),
          },
        )
    );
  }
}

class WidgetAll extends StatelessWidget {
  const WidgetAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 15, left: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xffF5F3F0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AllWidgetRadius),
              ),
            elevation: 0.0,
          ),
          child: Center(child:
          Icon(Icons.navigate_next, color: Colors.grey, size: 30),
          ),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllApp()),
            ),
          },
        )
    );
  }
}



class WidgetImage extends StatelessWidget {
  const WidgetImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Image.asset('assets/rest.jpg'),
    );
  }
}



class WidgetBlock extends StatelessWidget {
  const WidgetBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AllWidgetColor,
          borderRadius: BorderRadius.circular(AllWidgetRadius),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children:[
                Text('어제', style: TextStyle(fontSize: 20, color: AllFontColor, fontWeight: FontWeight.bold)),
              ]),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(children:<Widget>[
                  if (yestlist.isNotEmpty == true)
                    for(var i = 0; i < yestlist.length; i++)
                      Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: Center(child: Image.asset('assets/'+todayListIcon[i], height: 20)),
                              decoration: BoxDecoration(
                                color: Color(0xffE3E3D3).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xffEFEFEF), width: 1)
                              ),
                            ),
                            Text('   '+todayListName[i], style: TextStyle(color: AllFontColor, fontSize: 17)),
                            Spacer(),
                            Text(todayTime[i].toString() + '시간', style: TextStyle(color: Colors.grey))
                          ],)
                      ),
                ]),
              )
            ])
    );
  }
}
class NewButton extends StatelessWidget {
  const NewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AllWidgetColor,
              elevation: 0.0,
              textStyle: TextStyle(color: Colors.black),
              padding: EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AllWidgetRadius),
              ),
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondApp()),
              ),
              todayListNow = false,
            },
            child: Row(
              children: [
                Text('기록하기', style: TextStyle(fontSize: 20, color: AllFontColor, fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.navigate_next_rounded, color: Colors.grey),
              ],)
        ));
  }
}

class MainchallengeButton extends StatefulWidget {
  const MainchallengeButton({Key? key}) : super(key: key);

  @override
  State<MainchallengeButton> createState() => _MainchallengeButtonState();
}

class _MainchallengeButtonState extends State<MainchallengeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              //shadowColor: Colors.amber,
              /*side: BorderSide(
                  width: 1,
                  color: Colors.amber.withOpacity(0.2),
                ),*/
                primary: AllWidgetColor,
                elevation: 0.0,
                textStyle: TextStyle(color: Colors.black),
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AllWidgetRadius),
                )
            ),
            onPressed: () {
              print(answer);
              setState(() {
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChallengeMode()),
              ).then((value) {
                setState((){});
              });
            },
            child: Row(children: [
              Icon(todayChallenge ? completeChallenge ? Icons.monetization_on_rounded : Icons.abc : Icons.verified_rounded, color: todayChallenge ? completeChallenge ? Colors.amber:Colors.redAccent:Colors.amber),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_nowChallenge ? todayChallenge ? completeChallenge ? '오늘의 챌린지를 완수했어요!' : '내일 다시 만나요!': '챌린지에 도전 중이에요!' : '새로운 챌린지가 왔어요!', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        Text(_nowChallenge ?
                        todayChallenge ?
                        completeChallenge ?
                        (challengeHow ? challengelistPoint[now].toString() + 'P를 받았어요.' : questionPoint[answer].toString() + 'P를 받았어요.')
                            : '오늘의 챌린지를 완수하지 못했어요...'
                            : (challengeHow ? challengelist[now] : question[answer])
                            : (challengeHow ? '챌린지 도전하고 '+challengelistPoint[now].toString()+'포인트 받기'
                            : '챌린지 도전하고 '+questionPoint[answer].toString()+'포인트 받기'),
                            style: TextStyle(color: todayChallenge ? completeChallenge ? Colors.amber : Colors.redAccent : Colors.amber, fontSize: 15, fontWeight: FontWeight.bold)),
                      ])
              ),
              Spacer(),
              Icon(Icons.navigate_next, color: Colors.grey),
            ])
        )
    );
  }
}

class ChallengeMode extends StatefulWidget {
  const ChallengeMode({Key? key}) : super(key: key);

  @override
  State<ChallengeMode> createState() => _ChallengeModeState();
}

class _ChallengeModeState extends State<ChallengeMode> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
                backgroundColor: Colors.white,
                leading: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                      },
                      child: Icon(Icons.navigate_before_rounded, color: Colors.grey, size: 40),
                    )
                )
            ),
            body: WillPopScope(
              child: challengeHow ?
              _nowChallenge ?
              todayChallenge ?
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(completeChallenge ? Icons.monetization_on_rounded : Icons.abc, color: completeChallenge ? Colors.amber : Colors.redAccent, size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(completeChallenge ? challengelistPoint[now].toString()+'P 획득!' : '포인트 획득 실패!', style: TextStyle(color: completeChallenge ? Colors.black : Colors.redAccent, fontSize: 25, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(completeChallenge ? '챌린지를 완수하여 리워드를 받았어요.' : '챌린지 문제를 틀렸어요ㅠㅠ', style: TextStyle(color: Colors.grey, fontSize: 15))),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffF2F2F2),
                                elevation: 0.0,
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                            onPressed: () {
                              print('리워드 받기');
                              Navigator.pop(context);
                            },
                            child: Row(children:[
                              Text(' '),
                              Spacer(),
                              Text('확인', style: TextStyle(color: Colors.black, fontSize: 20)),
                              Spacer(),
                              Text(' '),
                            ])
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffF2F2F2),
                                elevation: 0.0,
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                            onPressed: () {
                              print('리워드 받기');
                              Navigator.push(context,
                              MaterialPageRoute(builder: (builder) => RememberList()));
                            },
                            child: Row(children:[
                              Text(' '),
                              Spacer(),
                              Column(children: [
                                Text('기록하기', style: TextStyle(color: Colors.black, fontSize: 20)),
                                Row(children: [
                                  Icon(Icons.monetization_on_rounded, color: Colors.amber),
                                  Text('+20P', style: TextStyle(color: Colors.amber)),
                                ])
                              ]),
                              Spacer(),
                              Text(' '),
                            ])
                        )
                    ),
                  ]))
              ) :

              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(challengeListIcon[now], color: challengeListIconColor[now], size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(challengelist[now], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text('챌린지를 진행 중이에요\n', style: TextStyle(color: Colors.grey, fontSize: 20)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.monetization_on_rounded, color: Colors.amber),
                                    Text(challengelistPoint[now].toString()+' 획득이 가능해요.', style: TextStyle(color: Colors.amber, fontSize: 17)),
                                  ],
                                ),
                              ],
                            )),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Color(0xffF5EEDC),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            Text('팁 보기', style: TextStyle(color: Color(0xff918156), fontSize: 20)),
                            Spacer(),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChallengeTip()));
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    ),
                    Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: Color(0xffF2F2F2),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              Text('완료했어요', style: TextStyle(color: Colors.black, fontSize: 20)),
                              Spacer(),
                            ],
                          ),
                          onPressed: () {
                            setState((){
                              _nowChallenge = true;
                              _isChallenge = false;
                              todayChallenge = true;
                              completeChallenge = true;
                              successChallenge.add(challengelist[now]);
                              successChallengePoint.add(challengelistPoint[now]);
                              sum += challengelistPoint[now];
                              addPoint = false;
                            });
                          },
                        ),
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffFFFFFF),
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              print('포기하기');
                              setState((){
                                _nowChallenge = false;
                                _isChallenge = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('포기하기', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                        )
                    )
                  ]))
              ):
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(challengeListIcon[now], color: challengeListIconColor[now], size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(challengelist[now], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(challengelistPoint[now].toString()+'P 획득이 가능해요.', style: TextStyle(color: Colors.grey, fontSize: 20))),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Color(0xffF2F2F2),
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                            onPressed: () {
                              print('도전하기');
                              setState((){
                                _nowChallenge = true;
                              });
                              print(_nowChallenge);
                              print(todayChallenge);
                            },
                            child: Row(children:[
                              Text(' '),
                              Spacer(),
                              Text('도전하기', style: TextStyle(color: Colors.black, fontSize: 20)),
                              Spacer(),
                              Text(' '),
                            ])
                        )
                    ),
                  ]))
              ):
              _nowChallenge ?
              todayChallenge ?
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(completeChallenge ? Icons.monetization_on_rounded : Icons.abc, color: completeChallenge ? Colors.amber : Colors.redAccent, size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(completeChallenge ? questionPoint[answer].toString()+'P 획득!' : '포인트 획득 실패!', style: TextStyle(color: completeChallenge ? Colors.black : Colors.redAccent, fontSize: 25, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(completeChallenge ? '챌린지를 완수하여 리워드를 받았어요.' : '챌린지 문제를 틀렸어요ㅠㅠ', style: TextStyle(color: Colors.grey, fontSize: 15))),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                                primary: Color(0xffF2F2F2),
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                            onPressed: () {
                              print('리워드 받기');
                              Navigator.pop(context);
                            },
                            child: Row(children:[
                              Text(' '),
                              Spacer(),
                              Text('확인', style: TextStyle(color: Colors.black, fontSize: 20)),
                              Spacer(),
                              Text(' '),
                            ])
                        )
                    ),
                  ]))
              ) :

              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(challengeListIcon[now], color: challengeListIconColor[now], size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(question[answer], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text('챌린지를 진행 중이에요\n', style: TextStyle(color: Colors.grey, fontSize: 20)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.monetization_on_rounded, color: Colors.amber),
                                    Text(questionPoint[answer].toString()+' 획득이 가능해요.', style: TextStyle(color: Colors.amber, fontSize: 17)),
                                  ],
                                ),
                              ],
                            )),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                      child: GridView.builder(
                        itemCount: 4,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 2 / 1,
                        ),
                        itemBuilder: (context, index){
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffF2F2F2),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                              onPressed: () {
                                setState(() {
                                  if (answer == index) {
                                    print('answer');
                                    _nowChallenge = true;
                                    _isChallenge = false;
                                    todayChallenge = true;
                                    completeChallenge = true;
                                    successChallenge.add(question[answer]);
                                    successChallengePoint.add(questionPoint[answer]);
                                    sum += questionPoint[answer];
                                  }
                                  else {
                                    print('not answer');
                                    _nowChallenge = true;
                                    _isChallenge = false;
                                    todayChallenge = true;
                                    completeChallenge = false;
                                    print(answer);
                                  }
                                });
                              },
                              child: Text(questionAnswer[index], style: TextStyle(color: Colors.black, fontSize: 17),
                              )
                          );
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffFFFFFF),
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              print('포기하기');
                              setState((){
                                _nowChallenge = false;
                                _isChallenge = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('포기하기', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                        )
                    )
                  ]))
              ):
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(challengeListIcon[now], color: challengeListIconColor[now], size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(question[answer], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(questionPoint[answer].toString()+'포인트 획득이 가능해요.', style: TextStyle(color: Colors.grey, fontSize: 20))),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                                primary: Color(0xffF2F2F2),
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                            onPressed: () {
                              print('도전하기');
                              setState((){
                                _nowChallenge = true;
                              });
                              print(_nowChallenge);
                              print(todayChallenge);
                            },
                            child: Row(children:[
                              Text(' '),
                              Spacer(),
                              Text('도전하기', style: TextStyle(color: Colors.black, fontSize: 20)),
                              Spacer(),
                              Text(' '),
                            ])
                        )
                    ),
                  ]))
              ),

              onWillPop: () {
                print('나갈수 없어!');
                return Future(()=>false);
              },
            )
        )
    );
  }
}
CalendarFormat _calendarFormat = CalendarFormat.month;

class RememberList extends StatefulWidget {
  const RememberList({Key? key}) : super(key: key);

  @override
  State<RememberList> createState() => _RememberListState();
}

class _RememberListState extends State<RememberList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: AllBackgroundColor,
          appBar: AppBar(
              backgroundColor: AllWidgetColor,
              elevation: 0.0,
              leading: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.navigate_before_rounded, color: AllFontColor, size: 40),
                  )
              )
          ),
          body:
          Container(
            child: ListView(
                children: [
                  Center(
                    child: Column(children: [
                      Container(
                        color: AllWidgetColor,
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                        child: Column(children: [
                          Icon(challengeListIcon[now], color: challengeListIconColor[now], size: 50),
                          Text('', style: TextStyle(fontSize: 20)),
                          Text(challengelist[now], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                          Text('', style: TextStyle(fontSize: 10)),
                          Text(challengelistHow[now][0], style: TextStyle(color: Colors.grey, fontSize: 20)),
                          Text('', style: TextStyle(fontSize: 20)),
                        ])
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Text('기분이 어떤가요?', style: TextStyle(color: AllFontColor, fontSize: 25, fontWeight: FontWeight.bold)),
                            Text('', style: TextStyle(fontSize: 20)),
                            Row(children: [
                              Spacer(),
                              Spacer(),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: emotion[0] ? AllTonedownColor : AllBackgroundColor,
                                ),
                                child:
                                Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: ElevatedButton(
                                      child: Text(''),
                                      onPressed: () {
                                        setState((){
                                          emotion[0] = true;
                                          emotion[1] = false;
                                          emotion[2] = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        primary: Colors.redAccent,
                                        elevation: 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: emotion[1] ? AllTonedownColor : AllBackgroundColor,
                                ),
                                child:
                                Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: ElevatedButton(
                                      child: Text(''),
                                      onPressed: () {
                                        setState((){
                                          emotion[0] = false;
                                          emotion[1] = true;
                                          emotion[2] = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        primary: Colors.amber,
                                        elevation: 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: emotion[2] ? AllTonedownColor : AllBackgroundColor,
                                ),
                                child:
                                Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: ElevatedButton(
                                      child: Text(''),
                                      onPressed: () {
                                        setState((){
                                          emotion[0] = false;
                                          emotion[1] = false;
                                          emotion[2] = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        primary: Colors.green,
                                        elevation: 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                            ]),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                              margin: EdgeInsets.only(top: 30),
                              child: Center(
                                child: Column(children: [
                                  Text('도전 과제가 도움이 되었나요?', style: TextStyle(color: AllFontColor, fontSize: 25, fontWeight: FontWeight.bold)),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AllTonedownColor,
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '도움이 되었나요?',
                                          hintStyle: TextStyle(color: AllFontColor)
                                      ),
                                      maxLines: null,
                                    )
                                  )
                                ])
                              )
                            )
                          ],
                        )
                      )
                    ])
                  )
                ]
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 50),
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: AllWidgetColor,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  elevation: 0.0,
                ),
                child: Text('저장하기', style: TextStyle(color: AllFontColor, fontSize: 25)),
                onPressed: () {
                  Navigator.pop(context);
                  if (addPoint == false){
                    successChallenge.add('기록하기');
                    successChallengePoint.add(20);
                    sum += 20;
                    addPoint = true;
                  }
                },
              )
            )
          ),
        )
    );
  }
}


class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('az');
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day){
            switch(day.weekday){
              case 6:
                return Center(child: Text('토', style: TextStyle(color: Colors.blue)),);
              case 7:
                return Center(child: Text('일', style: TextStyle(color: Colors.red),),);
            }
          }
      ),
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),

        ),
        todayTextStyle: TextStyle(color: Colors.black),
        defaultTextStyle: TextStyle(color: Colors.white),
        selectedTextStyle: TextStyle(color: Colors.black),
      ),
      locale: 'ko-KR',
      daysOfWeekHeight: 30,
      headerStyle: HeaderStyle(
        headerMargin: EdgeInsets.only(left:40, top: 10, right: 40, bottom: 10),
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState((){
          _calendarFormat = format;
        });
      },
      eventLoader: (day){
        return [];
      },
    );
  }
}

class ChallengeTip extends StatefulWidget {
  const ChallengeTip({Key? key}) : super(key: key);

  @override
  State<ChallengeTip> createState() => _ChallengeTipState();
}

class _ChallengeTipState extends State<ChallengeTip> {
  @override
  Widget build(BuildContext context) {
    var i = 1;
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xff1F1F1F),
          appBar: AppBar(
              backgroundColor: Color(0xff1F1F1F),
              elevation: 0.0,
              leading: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.navigate_before_rounded, color: AllFontColor, size: 40),
                  )
              )
          ),
          body:
          Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/'+challengelistHowImage[now], width: 50),
                  Text(' ', style: TextStyle(fontSize: 40)),
                  Text(challengelist[now], style: TextStyle(color: AllWidgetColor, fontSize: 30, fontWeight: FontWeight.bold)),
                  Text(' ', style: TextStyle(fontSize: 30),),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child:
                    Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          strutStyle: StrutStyle(fontSize: 20),
                          text: TextSpan(text: challengelistHow[now][0], style: TextStyle(color: AllFontColor, fontSize: 20)),
                        )
                    )
                  ),
                  Container(
                    child: Column(children: [
                      for(var i = 2; i <= challengelistHow[now].length; i++)
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Center(child: Text('${i-1}', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))),
                              decoration: BoxDecoration(
                                color: AllFontColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 30,
                              height: 30,
                            ),
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                strutStyle: StrutStyle(fontSize: 20),
                                text: TextSpan(text: challengelistHow[now][i - 1], style: TextStyle(color: AllWidgetColor, fontSize: 20)),

                              )
                            )
                          ])
                        )
                    ]),
                  ),
                  Spacer(),
                  Container(
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Text(''),
                          Spacer(),
                          Text('확인', style: TextStyle(color: AllWidgetColor, fontSize: 20),),
                          Spacer(),
                          Text(''),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3F3F3F),
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  )
            ])
          ),
        )
    );
  }
}




class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key? key}) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  final List<String> items = [
    '30분',
    '1시간',
    '2시간',
    '3시간',
    '4시간',
    '5시간 이상',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  '-',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) =>
              DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.grey,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
          buttonWidth: 130,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xffE1E1E1),
          ),
          buttonElevation: 0,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 100,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xffF2F2F2),
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(0, 0),
        ),
      ),
    );
  }
}