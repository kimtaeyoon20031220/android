import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
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

import './model.dart';
import './db_test.dart';
import 'package:flutter_bounce/flutter_bounce.dart';


var AllFontColor = Color(0xff565445);
//var AllFontColor = Color(0xff706C60);
var AllWidgetRadius = 30.0;
var AllWidgetColor = Color(0xffFFFFF7);
//var AllWidgetColor = Color(0xffFCFAF5);
var AllBackgroundColor = Color(0xffF1F1E9);
//var AllBackgroundColor = Color(0xffEDEDE6);
var AllTonedownColor = Color(0xffE3E3D3);
var backgroundColor = Colors.amber;


var dayList;
var dayListToday;
var dayListAll;

var todayListCheck = false;

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

var time = 0;

var dayWeek = 0;

var todayMemo = [false, false, false];
var emotion = [false, false, false];
var nowemotion = 2;
var todaySame = false;

var badge = 5;
var badgeListIcon = ['badge1.png','badge2.png','badge3.png'];
var badgelist = ['첫 만남', '두 번째 꿀곰', '세 번째 꿀곰', '네 번째 꿀곰', '다섯 번째 꿀곰', '여섯 번째 꿀곰']; //badge title badgelistText = ['첫 꿀곰 기록', '챌린지 첫 경험', '처음으로 돌아본 나', '네번째', '5']; //badge 설명
var badgeHave = 2; //badge를 가지고 있는지
var mytext = '';
bool challengeHow = true;
var challengelistHowImage = ['youtube.png', 'facebook.png', 'instagram.png', 'youtube.png', 'instagram.png'];
var challengelistHow = [['descriptionddddddddddddddddddddddddddddddddddddddd', 'blabladdddddddddddddddddddddddddddddddddddddd', 'youtube'], ['description', 'water'], ['description', 'blablapal', 'gupyeo', '10gae'], ['des', 'blak'], ['kdkdd','dkdkdkd']];
var challengelist = ['유튜브 1시간보다 적게 보기', '물 마시고 오기', '팔 굽혀 펴기 10개', '나이스', '성원']; //각 챌린지 별 내용
var challengelistPoint = [10, 20, 40, 30, 50]; //각 챌린지 별 포인트 지급
var challengeListIcon = [Icons.tv_rounded, Icons.water_drop_rounded, Icons.abc, Icons.abc, Icons.abc];
var challengeListIconColor = [Colors.red, Colors.blueAccent, Colors.black, Colors.black, Colors.black];
var sum = 0;
var successChallenge = []; //완료한 챌린지 인덱스
var successChallengePoint = [];
var now = Random().nextInt(2); //내가 하고 있는 챌린지의 인덱스
var answer = Random().nextInt(4);
bool _isChallenge = true; //챌린지 위젯을 메인에 보여줄건지?
bool _nowChallenge = false; //지금 챌린지를 하고 있는지?
bool todayChallenge = false; //오늘의 챌린지를 수행했는지?
bool completeChallenge = false; //오늘의 챌린지를 완료했는지?
var question = ['Google의 첫 CEO는?', 'Linux는 어떤 OS를 뿌리로 두고 있을까요?', 'B2B의 뜻은?', '테스트', '테스트2', '테스트3'];
var questionAnswer = ['래리 페이지', 'Unix', '비지니스 투 비지니스', '테스트', '테스트2', '테스트3'];
var questionChooser = [['아아아', '이이이', 'dkdkdk', '우우우'],['아아아', '이이이', 'dkdkdk', 'shshsh'],['아아아', '이이이', 'wkjfkwj', '우우우'],['아아아', '이이이', 'wkjefle', '우우우'],['아아아', 'fajf', 'ajklfjdl', '우우우'],['sfkalf', '이이이', 'kajljf', '우우우']];
var questionPoint = [10, 20, 30, 20, 10, 20];

var AllTop = [false, false, false];

var CalendarBorder = [Colors.transparent, Color(0xffEFEFEF), AllFontColor];
var CalendarText = [AllFontColor, AllFontColor, AllWidgetColor];
var CalendarFontWeight = [FontWeight.normal, FontWeight.normal, FontWeight.bold];
var BackColor = [Color(0xffF2F2F2), Color(0xffF2F2F2), Colors.white, Colors.white];
var savedDate = '';
var todayEnter = 1;

var nowHour = 0;

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  var strToday = formatter.format(now);
  return strToday;
}
String getTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('HH:mm');
  var strTime = formatter.format(now);
  return strTime;
}

var year = int.parse(getToday().split('-')[0]);
var month = int.parse(getToday().split('-')[1]);
var day = int.parse(getToday().split('-')[2]);

var challengeNumber = [];
var challengeLen;

var hour = 0;
var timeBlock = 3;
var timeBlockEnter = 0;
var savedTimeBlock = 0;

var timeTitle = [['오늘도 반가워요!\n상쾌한 아침이에요.'], ['새로운 마음으로 도전과제를 해볼까요?'], ['피곤하지는 않나요?\n건강한 하루을 보내보아요.'], ['피곤할 때는 도전과제 한 판!'], ['좋은 저녁이에요.\n좋은 하루 보내셨나요?'], ['하루를 마무리하며 도전해봅시다!'], ['오늘 하루는 어떤가요?\n꿀곰 첫 방문 멘트'], ['도전 과제 한 판 해볼래요?']];


Future<void> main() async {
  bool data = await fetchData();
  print(data);

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstApp(),
    );
  }
}


Future<bool> fetchData() async {
  bool data = false;
  // Change to API call
  await Future.delayed(Duration(seconds: 2), () {
    data = true;
  });

  return data;
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
    checkTime();
    loadTime();
    loadChallengeHow();
    loadNotifyMe();
    loadSavedDate();
    loadIsChallenge();
    if (savedDate == getToday()){ //날짜가 같다면
      setSavedDate();
      print('setSavedDate with if');
      todaySame = true;
    }
    else { //날짜가 다르다면
      setSavedDate();
      print('setSavedDate with else');
      todaySame = false;
    }
    if(hour >= 6 && hour < 12)
      timeBlock = 0;
    else if(hour >= 12 && hour < 17)
      timeBlock = 1;
    else
      timeBlock = 2;
    Duration duration = new Duration(seconds: 2);
    Future.delayed(duration, () {
      print('Challenge savedDate: $savedDate');
      if (savedDate == getToday()){ //동일자에 다시 접속한다면
        setChallenge();
        print('Challenge if');
      }
      else { //다른 날에 처음 접속한다면
        setChallenge();
        print('Challenge else');
        time = 0;
      }
      challengeLen = challengeNumber;
      if(hour >= 6 && hour < 12){
        if (savedTimeBlock == timeBlock) { //시간이 같다면
          if(savedDate != getToday()){ //날짜가 바뀐다면
            _isChallenge = true;
            setIsChallenge();
            timeBlockEnter = 0;
            print('time0 날짜 바뀜');
          }
          timeBlockEnter += 1;
          print('time0 if');
        }
        else { //시간이 다르다면
          timeBlockEnter = 1;
          _isChallenge = true;
          setIsChallenge();
          print('time0 else');
        }
      }
      else if(hour >= 12 && hour < 17) {
        if (savedTimeBlock == timeBlock) {
          if(savedDate != getToday()){ //날짜가 바뀐다면
            _isChallenge = true;
            setIsChallenge();
            timeBlockEnter = 0;
            print('time1 날짜 바뀜');
          }
          timeBlockEnter += 1;
          print('time1 if: $timeBlockEnter');
        } else { //날짜가 안바뀐다면
          timeBlockEnter = 1;
          _isChallenge = true;
          setIsChallenge();
          print('time1 else');
        }
      }
      else {
        if (savedTimeBlock == timeBlock) {
          if(savedDate != getToday()){ //날짜가 바뀐다면
            _isChallenge = true;
            setIsChallenge();
            timeBlockEnter = 0;
            print('time2 날짜 바뀜');
          }
          timeBlockEnter += 1;
          print('time2 if');
        } else {
          _isChallenge = true;
          setIsChallenge();
          timeBlockEnter = 1;
          print('time2 else');
        }
      }
      setTimeBlock();
      setTimeBlockEnter();
      loadIsChallenge();
    });
  }
  @override
  loadIsChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      _isChallenge = prefs.getBool('isChallenge') ?? _isChallenge;
    });
    print('loadIsChallenge: ${_isChallenge}');
  }
  @override
  loadTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    time = prefs.getInt('time') ?? time;
  }
  @override
  checkTime() {
    hour = int.parse(getTime().split(':')[0]);
    print('hour: $hour');
    loadTimeBlock();
    loadTimeBlockEnter();
  }
  @override
  setIsChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setBool('isChallenge', _isChallenge);
      print('setIsChallenge: $_isChallenge');
    });
  }
  @override
  loadTimeBlockEnter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      timeBlockEnter = prefs.getInt('timeBlockEnter') ?? timeBlockEnter;
      print('loadTimeBlockEnter: $timeBlockEnter');
    });
  }
  setTimeBlockEnter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setInt('timeBlockEnter', timeBlockEnter);
      print('setTimeBlockEnter: $timeBlockEnter');
    });
  }
  @override
  loadTimeBlock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      savedTimeBlock = prefs.getInt('timeBlock') ?? timeBlock;
      print('loadTimeBlock: $savedTimeBlock');
    });
  }
  @override
  setTimeBlock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setInt('timeBlock', timeBlock);
      print('setTimeBlock: $timeBlock');
    });
  }
  @override
  setChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      print('setChallenge Execute');
      print('setChallenge: $savedDate');
      if (todayEnter > 1) {
        print('setChallenge if');
        for (var i = 0; i < 3; i++) {
          challengeNumber.add(prefs.getInt('challengeNumber$i'));
          print('setChallenge challengeNumber: ${challengeNumber}');
        }
      }
      else {
        print('setChallenge else');

          while (true) {
            // 랜덤으로 번호를 생성해준다.
            var rnd = Random().nextInt(challengelist.length);

            // 만약 리스트에 생성된 번호가 없다면
            if (!challengeNumber.contains(rnd)) {
              challengeNumber.add(rnd);
            }

            // 리스트의 길이가 6이면 while문을 종료한다.
            if (challengeNumber.length == 3) break;
        }
        for(var j = 0; j < 3; j++){
          prefs.setInt('challengeNumber$j', challengeNumber[j]);
        }
        print('setChallenge: ${challengeNumber}');
        print('setChallenge: ${prefs.getInt('challengeNumber1')}');
      }
    });
  }
  @override
  loadChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      for(var i = 0; i < 3; i++){
        challengeNumber[i] = prefs.getInt('challengeNumber$i');
      }
    });
  }
  @override
  setSavedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setString('savedDate', getToday());
      if (savedDate == getToday()){
        todayEnter += 1;
        print('setSavedDate with if: $savedDate');
      }
      else if (savedDate == false){
        todayEnter = 1;
      }
      else {
        todayEnter = 1;
        print('setSavedDate with else: $savedDate');
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
      print('loadSavedDate: $savedDate');
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
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: '단계'),
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


class _FirstPageState extends State<FirstPage> with WidgetsBindingObserver {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _init();
    loadNotifyMe();
    loadSavedDate();
    loadIsChallenge();
  }
  @override
  setIsChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setBool('isChallenge', _isChallenge);
    });
  }
  @override
  loadIsChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      _isChallenge = prefs.getBool('isChallenge') ?? _isChallenge;
    });
  }

  @override
  loadSavedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedDate = prefs.getString('savedDate') ?? getToday();
      todayEnter = prefs.getInt('todayEnter') ?? 0;
    });
  }

  @override
  loadNotifyMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notifyMe = prefs.getBool('notifyMe') ?? notifyMe;
    });
  }

  setNotifyMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
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
    setState(() {
      prefs.setInt('todayEnter', 1);
      todayEnter = prefs.getInt('todayEnter') ?? 1;
    });
  }
  Future _future() async {
    await Future.delayed(Duration(milliseconds: 1700)); // 5초를 강제적으로 딜레이 시킨다.
    return '짜잔!'; // 5초 후 '짜잔!' 리턴
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: ListView(children: [
        Container(
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          backgroundColor.withOpacity(0),
                          backgroundColor.withOpacity(0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                  ),
                  height: 300,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset('assets/character.png', height: 130),
                          Spacer(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${timeTitle[timeBlock*2][0]}', style: TextStyle(
                                            color: Colors.black, fontSize: 27)),
                                    Text('', style: TextStyle(fontSize: 6)),
                                    Text('${timeTitle[timeBlock*2+1][0]}',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15)),
                                    Text('', style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ]
                          )
                        ]),
                  )
              )
            ])
        ),
        FutureBuilder(
            future: _future(),
            builder: (BuildContext context, AsyncSnapshot challengeLen) {
              if (challengeLen.hasData == false) {
                return Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XFF000066).withOpacity(0.03),
                          blurRadius: 15,
                          spreadRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                        BoxShadow(
                          color: Color(0XFF000066).withOpacity(0.0165),
                          blurRadius: 7.5,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Color(0XFF000066).withOpacity(0.0095),
                          blurRadius: 5,
                          spreadRadius: 2.5,
                          offset: const Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(margin:EdgeInsets.only(top: 20, left: 20),child: Text('오늘의 도전 과제', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AllFontColor))),
                          Container(
                              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Row(children: [
                                Container(height: 15, width: 200, color: Color(0xffF2F2F2)),
                                Spacer(),
                              ])
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                              child: Row(children: [
                                Container(height: 15, width: 200, color: Color(0xffF2F2F2)),
                                Spacer(),
                              ])
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
                              child: Row(children: [
                                Container(height: 15, width: 200, color: Color(0xffF2F2F2)),
                                Spacer(),
                              ])
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                color: AllTonedownColor,
                              ),
                              child: Bounce(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(children: [
                                      Text('준비 중이에요.', style: TextStyle(fontSize: 15, color: AllFontColor, fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      Icon(Icons.navigate_next_rounded, color: Colors.black.withOpacity(0.3)),
                                    ])
                                ),
                                onPressed: () {

                                },
                              )
                          )
                        ])
                );
              }
              else if (challengeLen.hasError) {
                return Text('에러');
              }
              else {
                return WidgetChallenge();
              }
            }
        ),
        Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(children: [
              Container(
                  child: Bounce(
                    duration: Duration(milliseconds: 100),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0XFF000066).withOpacity(0.03),
                              blurRadius: 15,
                              spreadRadius: 10,
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: Color(0XFF000066).withOpacity(0.0165),
                              blurRadius: 7.5,
                              spreadRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Color(0XFF000066).withOpacity(0.0095),
                              blurRadius: 5,
                              spreadRadius: 2.5,
                              offset: const Offset(0, 2.5),
                            ),
                          ],
                        ),
                        child: Row(children: [
                          Text('기록하기', style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Icon(Icons.navigate_next_rounded, color: Colors.grey),
                        ])
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondApp()),
                      );
                      todayListNow = false;
                    },
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(children: [
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
              ),
            ])
        ),

        Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AllFontColor, width: 1)),
    color: AllBackgroundColor,
    ),
          child: Column(
            children: [
              Text('테스트 화면\n', style: TextStyle(fontSize: 40, color: AllFontColor, fontWeight: FontWeight.bold),),
              Bounce(
                duration: Duration(milliseconds: 100),
                child: Container(
                  color: AllTonedownColor,
                    padding: EdgeInsets.all(20),
                    child: Row(
                  children: [
                    Spacer(),
                    Text('today'),
                    Spacer(),
                  ],
                )),
                onPressed: () {
                  setState((){
                    todayEnter = 2;
                  });
                },
              ),
              Bounce(
                duration: Duration(milliseconds: 100),
                child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.all(20),
                    color: AllTonedownColor,
                    child: Row(
                      children: [
                        Spacer(),
                        Text('시간 당 Enter 초기화'),
                        Spacer(),
                      ],
                    )),
                onPressed: () {
                  setState((){
                    todayEnter = 1;
                  });
                },
              ),
              Bounce(
                duration: Duration(milliseconds: 100),
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: AllTonedownColor,
                  child: Row(
                    children: [
                      Spacer(),
                      Text('todayMemo'),
                      Spacer(),
                    ],
                  ),
                ),
                onPressed: () {
                  setState((){
                    todayMemo[timeBlock] = false;
                  });
                },
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 30, top: 20, left: 10),
                  child: Row(
                    children: [
                      Image.asset('assets/logo.png', height: 30),
                      Text('$todayEnter'),
                      Spacer(),
                      Text('시간 당 Enter:$timeBlockEnter, '),
                      Text('savedTimeBlock:$savedTimeBlock ?= '),
                      Text('$timeBlock'),
                      Spacer(),
                      Text('time: $time  '),
                    ],
                  )
              ),
              Bounce(
                  duration: Duration(milliseconds: 100),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AllWidgetColor,
                      ),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Center(
                          child: Text('날짜 재지정', style: TextStyle(fontSize: 20)))
                  ),
                  onPressed: () {
                    setState(() {
                      setSavedDate();
                    });
                  }
              ),
              Bounce(
                  duration: Duration(milliseconds: 100),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AllWidgetColor,
                      ),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Center(
                          child: Text('챌린지 생성', style: TextStyle(fontSize: 20)))
                  ),
                  onPressed: () {
                    setState(() {
                      _isChallenge = true;
                      _nowChallenge = false;
                      todayChallenge = false;
                      setIsChallenge();
                    });
                  }
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class WidgetChallenge extends StatefulWidget {
  const WidgetChallenge({Key? key}) : super(key: key);

  @override
  State<WidgetChallenge> createState() => _WidgetChallengeState();
}

class _WidgetChallengeState extends State<WidgetChallenge> {

  @override
  Widget build(BuildContext context) {
            return Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(0.03),
                      blurRadius: 15,
                      spreadRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(0.0165),
                      blurRadius: 7.5,
                      spreadRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(0.0095),
                      blurRadius: 5,
                      spreadRadius: 2.5,
                      offset: const Offset(0, 2.5),
                    ),
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(margin:EdgeInsets.only(top: 20, left: 20),child: Text('오늘의 도전 과제', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AllFontColor))),
                      Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Row(children: [
                            Icon(Icons.wb_twilight_rounded, size: 20, color: Colors.deepOrange),
                            SizedBox(width: 200, child: Text(challengeHow ? '   '+ '${challengelist[challengeNumber[0]]}' : '   '+ '${question[challengeNumber[0]]}', style: TextStyle(fontSize: 15, color: Colors.black), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                            Spacer(),
                            Text('06:00~12:00', style: TextStyle(fontSize: 15, color: Colors.grey)),
                          ])
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                          child: Row(children: [
                            Icon(Icons.light_mode_rounded, size: 20, color: Colors.amber),
                            SizedBox(width: 200, child: Text(challengeHow ? '   '+ '${challengelist[challengeNumber[1]]}' : '   '+ '${question[challengeNumber[1]]}', style: TextStyle(fontSize: 15, color: Colors.black), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                            Spacer(),
                            Text('12:00~17:00', style: TextStyle(fontSize: 15, color: Colors.grey)),
                          ])
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
                          child: Row(children: [
                            Icon(Icons.dark_mode_rounded, size: 20, color: Colors.indigo),
                            SizedBox(width: 200, child: Text(challengeHow ? '   '+ '${challengelist[challengeNumber[2]]}' : '   '+ '${question[challengeNumber[2]]}', style: TextStyle(fontSize: 15, color: Colors.black), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                            Spacer(),
                            Text('17:00~06:00', style: TextStyle(fontSize: 15, color: Colors.grey,)),
                          ])
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                            color: AllTonedownColor,
                            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                          ),
                          child: Bounce(
                            duration: Duration(milliseconds: 100),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                ),
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Row(children: [
                                  Text('지금 도전하기', style: TextStyle(fontSize: 15, color: AllFontColor, fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  Icon(Icons.navigate_next_rounded, color: Colors.black.withOpacity(0.3)),
                                ])
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
                          )
                      )
                    ])
            );
          }
        }




class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void initState() {
    super.initState();
    dayListToday = [];
    dayList = [];
    dayListAll = [];
    printMe();
    printMeToday();
  }
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
  }
  Future<void>printMe() async {
    dayList = await DBHelper().getMemoDate(getToday());
    print("printMe");
    print('daylist: $dayList');
    print(_selectedDay);
  }
  Future<void>printMeToday() async {
    print('printMeToday');
    dayListToday = await DBTMHelper().getMemoDate(getToday());
    print(await 'daylistToday: $dayListToday');
    dayListAll = await DBTHelper().getMemoDate(getToday());
    print(await 'daylistall: $dayListAll');
  }
  Future<void>printMeNext() async {
    dayList = await DBHelper().getMemoDate(_selectedDay);
    print("printMeNext");
  }


  var _selectedDay;
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;
  var dayLen;
  var dayTLen;
  var dayALen;



  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
        child:
            Column(children: [
              Container(
                  padding: EdgeInsets.only(bottom: 20, right: 30, left: 30, top: 60),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border(
                      bottom: BorderSide(
                        color: AllFontColor.withOpacity(0.2),
                        width: 1.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 0),
                  child: Column(children: [
                    TableCalendar(
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        headerMargin: EdgeInsets.only(bottom: 30),
                      ),
                      locale: 'ko-KR',
                      focusedDay: _focusedDay,
                      firstDay: DateTime.now().subtract(Duration(days:365*10+2)),
                      lastDay: DateTime.now().add(Duration(days: 365*10+2)),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        setState(() async {
                          dayList = await DBHelper().getMemoDate(_selectedDay.toString().split(' ')[0]);
                          dayListToday = await DBTMHelper().getMemoDate(_selectedDay.toString().split(' ')[0]);
                          dayListAll = await DBTHelper().getMemoDate(_selectedDay.toString().split(' ')[0]);
                          dayLen = dayList;
                          dayTLen = dayListToday;
                          dayALen = dayListAll;
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: _future(),
                          builder: (BuildContext context, AsyncSnapshot dayLen) {
                            if (dayLen.hasData == false || dayTLen == null || dayALen == null || dayListToday.length == 0 && dayLen.hasData == false) {
                              return Container(
                                  margin: EdgeInsets.only(top: 70),
                                  padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(children: [
                                    Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(75),
                                          color: Color(0xffFFF2AE),
                                          border: Border.all(width: 15, color: Colors.white.withOpacity(0.8)),
                                        ),
                                        child: Center(child: Icon(Icons.calendar_today_rounded, size: 50, color: Colors.brown))),
                                    Text(' ', style: TextStyle(fontSize: 30)),
                                    Text('날짜를 선택해주세요', style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
                                  ])
                              );
                            }
                            else if (dayLen.hasError) {
                              return Text('에러');
                            }
                            else {
                              return Container(
                                  child: Column(children: [
                                    if(dayListToday.length != 0)
                                      Container(
                                        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.doorbell_rounded, color: Colors.amber, size: 20),
                                                Text(' 오늘 기록', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15)),
                                                Spacer(),
                                              ],
                                            ),
                                            Text('', style: TextStyle(fontSize: 15)),
                                            Text(dayListToday[0].memo, style: TextStyle(fontSize: 17, letterSpacing:1.2, wordSpacing: 1.2)),
                                            Container(
                                              margin: EdgeInsets.only(top: 20),
                                              child: Wrap(
                                                children: [
                                                  if(dayListAll.length != 0)
                                                    for(var i = dayListAll[0].memo.toString().length - 1; i > 0; i--)
                                                      Container(
                                                        padding: EdgeInsets.all(5),
                                                        margin: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(7),
                                                          color: Color(0xffF2F2F2),
                                                        ),
                                                        child: Text('# ' + todayListName[int.parse(dayListAll[0].memo.toString().substring(i-1, i))], style: TextStyle(color: Colors.grey, fontSize: 14)),
                                                      )
                                                ]
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                    if(dayList.length != 0)
                                      for(var i = 0; i < dayList.length; i++)
                                        if (dayList[i].memo != null)
                                          Container(
                                              margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: dayList[i].emotion == 0 ? Colors.redAccent : dayList[i].emotion == 1 ? Colors.amber : dayList[i].emotion == 2 ? Colors.green : Colors.grey,
                                                        )
                                                    ),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width*0.5,
                                                        child: Text('  '+dayList[i].title + ' ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))),
                                                    Spacer(),
                                                    Text(' ' + '${dayList[i].time}', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                                  ]),
                                                  Container(
                                                      margin: EdgeInsets.only(top: 20),
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('소감', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                                            Text('', style: TextStyle(fontSize: 5)),
                                                            Text('${dayList[i].memo}', style: TextStyle(color: Colors.black, fontSize: 17)),
                                                          ])
                                                  )
                                                ],
                                              ))
                                        else
                                          Container(
                                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                              margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(children: [
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Container(
                                                    width: MediaQuery.of(context).size.width*0.5,
                                                    child: Text('  '+dayList[i].title + ' ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))),                                    Spacer(),
                                                Text(' ' + '${dayList[i].time}', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                              ]))
                                    else
                                      Container(
                                          margin: EdgeInsets.only(top: 70),
                                          padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.transparent,
                                          ),
                                          child: Column(children: [
                                            Container(
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(75),
                                                  color: Color(0xffFFF2AE),
                                                  border: Border.all(width: 15, color: Color(0xffDFDFDF)),
                                                ),
                                                child: Center(child: Image.asset('assets/character.png', height: 80))),
                                            Text(' ', style: TextStyle(fontSize: 30)),
                                            Text('한 도전과제가 없어요', style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
                                          ])
                                      )
                                  ])
                              );
                            }
                          }
                      ),
                    ]
                  )
                )
              )
            ])
    );
  }
  Future _future() async {
    await Future.delayed(Duration(milliseconds: 70));
    return "짜잔!";
  }
}


class printChallengeWidget extends StatefulWidget {
  const printChallengeWidget({Key? key}) : super(key: key);

  @override
  State<printChallengeWidget> createState() => _printChallengeWidgetState();
}

class _printChallengeWidgetState extends State<printChallengeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dayList.length > 0)
          for(var i = 0; i < dayList.length; i++)
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffF7F7F7),
                ),
                child: Row(children: [
                  Text(dayList[i].title, style: TextStyle(color: Colors.black, fontSize: 17)),
                  Spacer(),
                  Icon(Icons.monetization_on_rounded, color: Colors.grey, size: 20),
                  Text(' ' + '${dayList[i].point}P', style: TextStyle(color: Colors.grey, fontSize: 15)),
                ]))
      ]
    );
  }
}




Widget CalendarCellBuilder(BuildContext context, DateTime dateTime, _, int type) {
  String date = DateFormat('dd').format(dateTime);
  return Container(
    padding: EdgeInsets.all(10),
    child: Container(
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CalendarBorder[type],
      ),
      child: Center(child: Text('$date', style: TextStyle(color: CalendarText[type], fontSize: 17, fontWeight: CalendarFontWeight[type]))),
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
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 40),
            child: Column(
              children: [
                Text('${0+1}일차', style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold)),
                Text('\n모든 도전과제', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            )
          ),
          Container(
            child: Column(
              children: [
                for(var i = 0; i < challengelist.length; i++)
                  Bounce(
                    duration: Duration(milliseconds: 100),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (i+1)%2 == 0 ? Colors.white : Color(0xffF2F2F2),
                      ),
                      child: Row(
                        children: [
                          Icon(dayWeek >= i ? Icons.lock_open : Icons.lock, color: dayWeek >= i ? Colors.blueAccent : Colors.grey, size: 20),
                          Text('   '),
                          Container(
                            width: 25,
                              height: 25,
                              decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: dayWeek >= i ? dayWeek == i ? Colors.blueAccent : Colors.black : Color(0xffDFDFDF),
    ),
                              child: Center(child: Icon(challengeListIcon[i], color: dayWeek >= i ? dayWeek == i ? Colors.white : Colors.white : Colors.grey, size: 15))),
                          Text('  '+challengelist[i], style: TextStyle(color: dayWeek >= i ? dayWeek == i ? Colors.blueAccent : Colors.black : Colors.grey, fontSize: 15, fontWeight: dayWeek == i ? FontWeight.bold : FontWeight.normal)),
                          Spacer(),
                          Text('${i+1}일차', style: TextStyle(color: dayWeek >= i ? dayWeek == i ? Colors.blueAccent : Colors.black : Colors.grey, fontSize: 13)),
                        ]
                      )
                    ),
                    onPressed: () {},
                  )
              ]
            )
          )
        ]
      )
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
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Center(
              child:
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: ListView(children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('', style: TextStyle(fontSize: 30)),
                        Text('    \u{1F36F} about 꿀곰', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                          margin: EdgeInsets.only(top: 70, right: 40, left: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('꿀곰의 시작', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                Text('', style: TextStyle(fontSize: 6)),
                                Text('kdfjkajgkajgkgljagjlkdgjkalgjkljgkjgklfgjaklgjfklgjafkglfjgklfajgkljgklajgklaf', style: TextStyle(fontSize: 15, height: 1.7, letterSpacing: 1.2, wordSpacing: 1.2)),
                              ],
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50, right: 40, left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('꿀곰에 관하여', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              Text('', style: TextStyle(fontSize: 6)),
                              Text('kdfjkajgkajgkgljagjlkdgjkalgjkljgkjgklfgjaklgjfklgjafkglfjgklfajgkljgklajgklaf', style: TextStyle(fontSize: 15, height: 1.7, letterSpacing: 1.2, wordSpacing: 1.2)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50, right: 40, left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('꿀곰을 통하여', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              Text('', style: TextStyle(fontSize: 6)),
                              Text('kdfjkajgkajgkgljagjlkdgjkalgjkljgkjgklfgjaklgjfklgjafkglfjgklfajgkljgklajgklaf', style: TextStyle(fontSize: 15, height: 1.7, letterSpacing: 1.2, wordSpacing: 1.2)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 30, right: 30, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('  팀원', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              Text('', style: TextStyle(fontSize: 6)),
                              Bounce(
                                duration: Duration(milliseconds: 100),
                                onPressed: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                    BoxShadow(
                                      color: Color(0XFF000066).withOpacity(0.03),
                                      blurRadius: 15,
                                      spreadRadius: 10,
                                      offset: const Offset(0, 10),
                                    ),
                                    BoxShadow(
                                      color: Color(0XFF000066).withOpacity(0.0165),
                                      blurRadius: 7.5,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                    BoxShadow(
                                      color: Color(0XFF000066).withOpacity(0.0095),
                                      blurRadius: 5,
                                      spreadRadius: 2.5,
                                      offset: const Offset(0, 2.5),
                                    ),
                                  ],
                                  ),
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              children: [
                                                Text('\u{1F4E2}', style: TextStyle(fontSize: 30)),
                                                Text('', style: TextStyle(fontSize: 10)),
                                                Text('강원중', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                                                Text('', style: TextStyle(fontSize: 10)),
                                                Text('가천대학교\n경영18', style: TextStyle(fontSize: 15)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.25,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('PM, 기획, 마케팅', style: TextStyle(fontSize: 20)),
                                                  Text('_____\n', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                                  Text('기획', style: TextStyle(fontSize: 17))
                                                ]
                                            )
                                          )
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.start,
                                      )
                                    ]
                                  )
                                ),
                              ),
                              Bounce(
                                duration: Duration(milliseconds: 100),
                                onPressed: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0XFF000066).withOpacity(0.03),
                                          blurRadius: 15,
                                          spreadRadius: 10,
                                          offset: const Offset(0, 10),
                                        ),
                                        BoxShadow(
                                          color: Color(0XFF000066).withOpacity(0.0165),
                                          blurRadius: 7.5,
                                          spreadRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                        BoxShadow(
                                          color: Color(0XFF000066).withOpacity(0.0095),
                                          blurRadius: 5,
                                          spreadRadius: 2.5,
                                          offset: const Offset(0, 2.5),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: Column(
                                                  children: [
                                                    Text('\u{1F4DD}', style: TextStyle(fontSize: 30)),
                                                    Text('', style: TextStyle(fontSize: 10)),
                                                    Text('이기용', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                                                    Text('', style: TextStyle(fontSize: 10)),
                                                    Text('가천대학교\n경영20', style: TextStyle(fontSize: 15)),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context).size.width*0.25,
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.5,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('기획, 마케팅', style: TextStyle(fontSize: 20)),
                                                        Text('_____\n', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                                        Text('기획', style: TextStyle(fontSize: 17))
                                                      ]
                                                  )
                                              )
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.start,
                                          )
                                        ]
                                    )
                                ),
                              ),
                              Bounce(
                                duration: Duration(milliseconds: 100),
                                onPressed: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0XFF000066).withOpacity(0.03),
                                          blurRadius: 15,
                                          spreadRadius: 10,
                                          offset: const Offset(0, 10),
                                        ),
                                        BoxShadow(
                                          color: Color(0XFF000066).withOpacity(0.0165),
                                          blurRadius: 7.5,
                                          spreadRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                        BoxShadow(
                                          color: Color(0XFF000066).withOpacity(0.0095),
                                          blurRadius: 5,
                                          spreadRadius: 2.5,
                                          offset: const Offset(0, 2.5),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: Column(
                                                  children: [
                                                    Text('\u{1F528}', style: TextStyle(fontSize: 30)),
                                                    Text('', style: TextStyle(fontSize: 10)),
                                                    Text('김태윤', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                                                    Text('', style: TextStyle(fontSize: 10)),
                                                    Text('가천대학교\n컴공22', style: TextStyle(fontSize: 15)),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context).size.width*0.25,
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.5,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('개발', style: TextStyle(fontSize: 20)),
                                                        Text('_____\n', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                                        Text('기획', style: TextStyle(fontSize: 17))
                                                      ]
                                                  )
                                              )
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.start,
                                          )
                                        ]
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                            Container(
                              margin: EdgeInsets.only(top: 50, right: 40, left: 40, bottom: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('팀 블로그', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      Bounce(
                                        duration: Duration(milliseconds: 100),
                                        onPressed: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color(0xffF2F2F2),
                                          ),
                                          child: Row(
                                            children: [
                                              Text('팀 블로그 구경가기', style: TextStyle(color: Colors.black, fontSize: 15)),
                                              Icon(Icons.navigate_next_rounded, color: Colors.grey, size: 20),
                                            ],
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                  Text('', style: TextStyle(fontSize: 6)),
                                  Text('꿀곰 프로젝트의 팀 블로그예요. 꿀곰이 만들어지는 과정과 꿀곰에 들어간 생각이 궁금하시다면 한번 방문해봐요.', style: TextStyle(fontSize: 15, height: 1.7, letterSpacing: 1.1, wordSpacing: 1.2)),
                                ],
                              ),
                            ),
                            Center(
                              child: Column(children: [
                                Text('꿀곰 프로젝트', style: TextStyle(color: Colors.grey, fontSize: 20)),
                                Text('', style: TextStyle(fontSize: 10)),
                                Text('가천대학교 TMI 프로젝트 2022', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                Text('', style: TextStyle(fontSize: 60)),
                              ])
                            )
                      ])
                    ),
                  ])
              )
          )
      ),
    );
  }
}
class SecondApp extends StatefulWidget {
  const SecondApp({Key? key}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final memoController = TextEditingController();

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
              backgroundColor: Colors.white,
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
          body:
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
                          Text('오늘의 게을렀던\n행동을 선택해주세요.', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
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
                                  return Bounce(
                                      duration: Duration(milliseconds: 100),
                                      onPressed: () {
                                        setState(() {
                                          todayList[index] ? todayList[index] = false : todayList[index] = true;
                                          print(todayList);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: todayList[index] ? AllFontColor : AllBackgroundColor,
                                        ),
                                        child: Center(
                                          child: Text(todayListName[index], style: TextStyle(color: todayList[index] ? AllWidgetColor : AllFontColor, fontSize: 17),
                                      ),
                                        )
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
                    margin: EdgeInsets.fromLTRB(60, 0, 60, 60),
                    child: Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: () {
                        setState((){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RememberToday()));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AllFontColor,
                        ),
                        padding: EdgeInsets.all(20),
                        child: Row(children:[
                          Text(''),
                          Spacer(),
                          Text('기록하기', style: TextStyle(color: Colors.white, fontSize: 20)),
                          Spacer(),
                          Text(''),
                        ]),
                      )
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}

class RememberToday extends StatefulWidget {
  const RememberToday({Key? key}) : super(key: key);

  @override
  State<RememberToday> createState() => _RememberTodayState();
}

class _RememberTodayState extends State<RememberToday> {
  final memoController = TextEditingController();
  var nowCheck = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.navigate_before, color: AllFontColor, size: 20),
                  )
              )
          ),
          body:
          ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: Container(
                padding: EdgeInsets.all(25),
                child: ListView(children: [
                  Container(
                      margin: EdgeInsets.only(top: 20, bottom: 40, left: 10),
                      child: Text('오늘 하루는 어땠나요?', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold))),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 20, left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '오늘 하루를 기록해주세요.',
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      maxLines: null,
                      controller: memoController,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Wrap(
                          children: <Widget>[
                            for(var i = 0; i < todayList.length; i++)
                              if(todayList[i] == true)
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                                    padding: EdgeInsets.all(10),
                                    child: Text('# ' +todayListName[i], style: TextStyle(color: Colors.grey, fontSize: 15))
                                )
                          ]),
                    ),
                  ),
                ])
            ),
          ),
          bottomNavigationBar: Container(
              margin: const EdgeInsets.fromLTRB(50, 0, 50, 50),
              child: Bounce(
                  duration: const Duration(milliseconds: 100),
                  onPressed: () async {
                    var nowTodayList = 0;
                    if(nowCheck == true) {
                        var j = 0;
                        if(memoController.text.length > 0) {
                          for (var i = 0; i < todayList.length; i++) {
                            var equation = 10;
                            if (todayList[i] == true) {
                                for(var t = 0; t < j; t++){
                                  equation *= 10;
                                  print(equation);
                                }
                                nowTodayList += equation*(i);
                                print(nowTodayList);
                                j++;
                                var getTodays = await DBTHelper().getMemoDate(getToday());
                                print(getTodays);
                            }
                          }
                          DBTHelper().insertToday(Today(
                              id: year * 1000000 +
                                  month * 10000 +
                                  day * 100,
                              memo: nowTodayList,
                              createTime: getToday()));
                          print(await DBTHelper().todays());
                          j = 0;
                          DBTMHelper().insertTodayMemo(TodayMemo(
                            id: year * 1000000 + month * 10000 + day * 100 + j,
                            memo: memoController.text,
                            createTime: getToday(),
                          ));
                          Navigator.popUntil(context, ModalRoute.withName('/'));}
                        else {
                          Duration duration = new Duration(seconds: 3);
                          nowCheck = false;
                          Future.delayed(duration, (){
                            setState((){
                              nowCheck = true;
                            });
                          });
                        }
                        }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: nowCheck ? Colors.blueAccent : Color(0xffF2F2F2),
                    ),
                    child: Row(children: [
                      Text(' '),
                      Spacer(),
                      Text(nowCheck ? '기록하기' : '기록해 주세요', style: TextStyle(color: nowCheck ? Colors.white : Colors.grey, fontSize: 17)),
                      Spacer(),
                      Text(' '),
                    ]),
                  )
              )
          )
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
            body: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: Container(
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
              ),
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
                    child: Row(
                      children: [
                        Icon(Icons.navigate_before_rounded, color: AllFontColor, size: 40),
                      ],
                    ),
                  )
              )
          ),
          body: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: Container(
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
          ),
          bottomNavigationBar:Container(
              margin: EdgeInsets.fromLTRB(40, 20, 40, 50),
              child: Bounce(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                  setState((){
                  });
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffF2F2F2),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(children: [
                    Text(' '),
                    Spacer(),
                    Text('제한 시작', style: TextStyle(color: Colors.grey, fontSize: 20)),
                    Spacer(),
                    Text(' '),
                  ]),
                )
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
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Center(child: Text('알림 시간 설정', style: TextStyle(color: AllFontColor, fontSize: 25, fontWeight: FontWeight.bold),)),
              content: SingleChildScrollView(
                  child: notifyMe ? Column(
                      children: [
                        Text('24시간 형식으로 입력해야 해요.\n', style: TextStyle(color: AllFontColor, fontSize: 15)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF7F7F7),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '시간',
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                              controller: HourController,
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF7F7F7),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '분',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              controller: MinController,
                            )
                        ),
                        Container(
                            child: Bounce(
                              duration: Duration(milliseconds: 100),
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
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(children: [
                                  Spacer(),
                                  Text('알림 켜기'),
                                  Spacer(),
                                ])
                              )
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                            child: Bounce(
                              duration: Duration(milliseconds: 100),
                              onPressed: () async {
                                await _cancelNotification();
                                setNotifyMe();
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Text('알림 끄기', style: TextStyle(fontSize: 15, color: Colors.redAccent)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(10),
                              )
                            )
                        ),
                      ]
                  ):
                  Column(
                      children: [
                        Text('알림이 꺼져 있어요.\n', style: TextStyle(color: AllFontColor, fontSize: 15)),
                        Container(
                            child: Bounce(
                              duration: Duration(milliseconds: 100),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffF2F2F2),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text('알림 켜기', style: TextStyle(fontSize: 20, color: AllFontColor)),
                                      Spacer(),
                                    ],
                                  ),
                                ),
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
          backgroundColor: Color(0xffF2F2F2),
          appBar: AppBar(
              backgroundColor: Color(0xffF2F2F2),
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
          ),
          body:
          ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ListView(
                children: [
                  Text('   설정', style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold)),
                  Text('', style: TextStyle(fontSize: 20)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: 1, color: Colors.black.withOpacity(0.1)), bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                          ),
                          child: Bounce(
                            duration: Duration(milliseconds: 100),
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(children: [
                                Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.amber,
                                    ),
                                    child: Center(child: Icon(Icons.notifications_rounded, color: Colors.white, size: 20))),
                                Text('   알림', style: TextStyle(color: Colors.black, fontSize: 18)),
                                Spacer(),
                                Text(notifyMe ? '켜짐' : '꺼짐', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                Icon(Icons.navigate_next_rounded, color: AllWidgetColor),
                              ]),
                            ),
                            onPressed: () {}
                          ),
                        ),
                        Bounce(
                            duration: Duration(milliseconds: 100),
                            child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.blueAccent,
                                    ),
                                    child: Center(child: Icon(Icons.watch_later_rounded, color: Colors.white, size: 20))),
                                Text('   알림 시간', style: TextStyle(color: Colors.black, fontSize: 18)),
                                Spacer(),
                                Text(notifyMe ? '${notifyHour}시 ${notifyMin}분' : '꺼져 있음', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                Icon(Icons.navigate_next_rounded, color: Colors.grey),
                              ]),
                            ),
                          onPressed: () {
                            notifyDialog(context);
                          },
                        ),
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1)), top: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                      color: Colors.white,
                    ),
                      margin: EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.green,
                                ),
                                child: Center(child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 20))),
                            Text('   도전과제 형태', style: TextStyle(color: Colors.black, fontSize: 18)),
                            Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  Bounce(
                                    duration: Duration(milliseconds: 100),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: challengeHow ? Color(0xffDFDFDF) : Colors.transparent,
                                      ),
                                      child: Text('활동', style: TextStyle(color: challengeHow ? Colors.black : Colors.grey, fontSize: 15)),
                                    ),
                                    onPressed: () {
                                      if (challengeHow == false) {
                                setState(() {
                                  _nowChallenge = false;
                                  setChallengeHow();
                                  print(challengeHow);
                                });
                              }
                            },
                                  ),
                                  Bounce(
                                    duration: Duration(milliseconds: 100),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: challengeHow ? Colors.transparent : Color(0xffDFDFDF),
                                      ),
                                      child: Text('문제', style: TextStyle(color: challengeHow ? Colors.grey : Colors.black, fontSize: 15)),
                                    ),
                                    onPressed: () {
                                      if (challengeHow == true) {
                                setState(() {
                                  _nowChallenge = false;
                                  setChallengeHow();
                                  print(challengeHow);
                                });
                              }
                            },
                                  ),
                                ],
                              )
                            )
                          ]),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 20, bottom: 5),
                    child: Text('꿀곰 프로젝트 팀', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1)), top: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Bounce(
                            duration: Duration(milliseconds: 100),
                            child: Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                                ),
                                child: Column(children: [
                                  Container(
                                      child: Row(children: [
                                        Text('\u{1F4E2}  강원중', style: TextStyle(fontSize: 17)),
                                        Spacer(),
                                        Text('연결', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                        Icon(Icons.navigate_next_rounded, color: Colors.grey),
                                      ])
                                  )
                                ])
                            ),
                            onPressed: () {},
                          ),
                          Bounce(
                            duration: Duration(milliseconds: 100),
                            child: Container(
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                                ),
                                child: Column(children: [
                                  Container(
                                      child: Row(children: [
                                        Text('\u{1F4DD}  이기용', style: TextStyle(fontSize: 17)),
                                        Spacer(),
                                        Text('연결', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                        Icon(Icons.navigate_next_rounded, color: Colors.grey),
                                      ])
                                  )
                                ])
                            ),
                            onPressed: () {},
                          ),
                          Bounce(
                            duration: Duration(milliseconds: 100),
                            child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                ),
                                child: Column(children: [
                                  Container(
                                      child: Row(children: [
                                        Text('\u{1F528}  kim__tune', style: TextStyle(fontSize: 17)),
                                        Spacer(),
                                        Text('인스타그램', style: TextStyle(color: Colors.grey, fontSize: 15)),
                                        Icon(Icons.navigate_next_rounded, color: Colors.grey),
                                      ])
                                  )
                                ])
                            ),
                            onPressed: () {},
                          )
                        ],
                      )
                  )
                ]
              ),
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
        child: Bounce(
            duration: Duration(milliseconds: 100),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(0.03),
                      blurRadius: 15,
                      spreadRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(0.0165),
                      blurRadius: 7.5,
                      spreadRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(0.0095),
                      blurRadius: 5,
                      spreadRadius: 2.5,
                      offset: const Offset(0, 2.5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(25),
                child: Column(children: [
                  Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('현재', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          Text(' ', style: TextStyle(fontSize: 6)),
                          Text('뱃지', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
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
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BadgeApp()),);
            }
        ),
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
        child: Bounce(
            duration: Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFF000066).withOpacity(0.03),
                    blurRadius: 15,
                    spreadRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0XFF000066).withOpacity(0.0165),
                    blurRadius: 7.5,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Color(0XFF000066).withOpacity(0.0095),
                    blurRadius: 5,
                    spreadRadius: 2.5,
                    offset: const Offset(0, 2.5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(25),
              child: Column(children: [
                Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('앱', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        Text(' ', style: TextStyle(fontSize: 6)),
                        Text('제한', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
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
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StrictApp()),);
            }
        ),
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
        child: Bounce(
          duration: Duration(milliseconds: 100),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllApp()),
            ),
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Center(child:
            Icon(Icons.navigate_next, color: AllFontColor, size: 30),
          )
        )
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
        child: Bounce(
            duration: Duration(milliseconds: 100),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AllWidgetColor,
                ),
                padding: EdgeInsets.all(25),
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
                            (challengeHow ? challengelistPoint[challengeNumber[timeBlock]].toString() + 'P를 받았어요.' : questionPoint[challengeNumber[timeBlock]].toString() + 'P를 받았어요.')
                                : '오늘의 챌린지를 완수하지 못했어요...'
                                : (challengeHow ? challengelist[challengeNumber[timeBlock]] : question[challengeNumber[timeBlock]])
                                : (challengeHow ? '챌린지 도전하고 '+challengelistPoint[challengeNumber[timeBlock]].toString()+'포인트 받기'
                                : '챌린지 도전하고 '+questionPoint[challengeNumber[timeBlock]].toString()+'포인트 받기'),
                                style: TextStyle(color: todayChallenge ? completeChallenge ? Colors.amber : Colors.redAccent : Colors.amber, fontSize: 15, fontWeight: FontWeight.bold)),
                          ])
                  ),
                  Spacer(),
                  Icon(Icons.navigate_next, color: Colors.grey),
                ])
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
              todayMemo[timeBlock] = false;
            },

        ),
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
  setIsChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setBool('isChallenge', _isChallenge);
    });
    print('setIsChallenge: ${prefs.getBool('isChallenge') ?? null}');
  }
  var really = false;
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
              child: _isChallenge ?
              challengeHow ?
              _nowChallenge ?
              todayChallenge ?
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Icon(completeChallenge ? Icons.check_circle_rounded : Icons.abc, color: completeChallenge ? Colors.blueAccent : Colors.redAccent, size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(completeChallenge ? '도전과제를 완료했어요' : '포인트 획득 실패!', style: TextStyle(color: completeChallenge ? Colors.black : Colors.redAccent, fontSize: 25, fontWeight: FontWeight.bold)),
                        if(completeChallenge == true)
                          Container(
                              margin: EdgeInsets.only(top: 60),
                              child: Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
                                ),
                                width: MediaQuery.of(context).size.width*0.8,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(challengelist[challengeNumber[timeBlock]], style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Text('', style: TextStyle(fontSize: 10)),
                                    Text(challengelistHow[challengeNumber[timeBlock]][0], style: TextStyle(color: Colors.grey, fontSize: 15)),
                                  ],
                                ),
                              )),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 20, left: 40, right: 40),
                        child:Bounce(
                          duration: Duration(milliseconds: 100),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: todayMemo[timeBlock] ? Colors.blueAccent : Color(0xffF2F2F2),
                            ),
                            child: Row(children: [
                              Spacer(),
                              Text('확인', style: TextStyle(fontSize: 17, color: todayMemo[timeBlock] ? Colors.white : Colors.black, fontWeight: todayMemo[timeBlock] ? FontWeight.bold : FontWeight.normal)),
                              Spacer(),
                            ]),
                          ),
                          onPressed: () async {
                            print('리워드 받기');
                            Navigator.pop(context);
                            if (todayMemo[timeBlock] == false) {
                              time += 1;
                              setTime();
                              DBHelper().insertMemo(Memo(id: year * 1000000 + month * 10000 + day * 100 + time, title: challengelist[challengeNumber[timeBlock]], point: challengelistPoint[challengeNumber[timeBlock]], createTime: getToday(), time: getTime()));
                              print(await DBHelper().memos());
                              todayMemo[timeBlock] = true;
                              print(todayMemo);
                            }
                            _isChallenge = false;
                            setIsChallenge();
                          },
                        ),
                    ),
                    Bounce(
                      duration: Duration(milliseconds: 100),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(40, 0, 40, 50),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: todayMemo[timeBlock] ? Color(0xffF2F2F2) : Colors.blueAccent,
                        ),
                          child: Row(children:[
                            Text(' '),
                            Spacer(),
                            Column(children: [
                              Text(todayMemo[timeBlock] ? '수정하기' : '기록 하기', style: TextStyle(color: todayMemo[timeBlock] ? Colors.grey : Colors.white, fontSize: 17, fontWeight: todayMemo[timeBlock] ? FontWeight.normal : FontWeight.bold,)),
                              Row(children: [
                                Text(todayMemo[timeBlock] ? '' : '\n추가 경험치를 얻을 수 있어요', style: TextStyle(color: todayMemo[timeBlock] ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.6), fontSize: todayMemo[timeBlock] ? 0 : 13)),
                              ])
                            ]),
                            Spacer(),
                            Text(' '),
                          ])
                      ),
                      onPressed: () {
                        print('리워드 받기');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => RememberList()));
                      },
                    )
                  ]))
              ) :

              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      color: Color(0xffF2F2F2),
                    ),
                          margin: EdgeInsets.only(bottom: 40),
                          width: 100,
                          height: 100,
                          child: Icon(challengeListIcon[challengeNumber[timeBlock]], color: challengeListIconColor[challengeNumber[timeBlock]], size: 50)),
                      Text('활동 도전 과제 진행 중', style: TextStyle(color: Colors.grey, fontSize: 15)),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(challengelist[challengeNumber[timeBlock]], style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20, right: 40, left: 40),
                            child: Column(
                              children: [
                                Text(challengelistHow[challengeNumber[timeBlock]][0], style: TextStyle(color: Colors.grey, fontSize: 17)),
                              ],
                            )),
                      ]
                      )
                      ),

                    ])),
                    Bounce(
                        duration: Duration(milliseconds: 100),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ChallengeTip()));
                        },
                        child: Container(
                          child:
                              Icon(Icons.lightbulb_rounded, color: Colors.orange, size: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange.withOpacity(0.1),
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 40),
                        )
                    ),
                    Spacer(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Bounce(
                          duration: Duration(milliseconds: 100),
                          onPressed: () {
                            print('포기하기');
                            if (really == true) {
                              setState((){
                                _nowChallenge = false;
                                _isChallenge = false;
                                setIsChallenge();
                                Navigator.pop(context);
                              });
                            }
                            else {
                              setState((){
                                Duration duration = new Duration(seconds: 3);
                                really = true;
                                Future.delayed(duration, (){
                                  setState((){
                                    really = false;
                                  });
                                });
                              });
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.redAccent.withOpacity(really ? 1 : 0.07),
                              ),
                              padding: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width*0.35,
                              margin: EdgeInsets.only(bottom: 50),
                              child: Center(child: Text(really ? '정말 포기하기':'포기하기', style: TextStyle(color: really ? Colors.white : Colors.redAccent, fontSize: 15)))),
                        ),
                        Bounce(
                          duration: Duration(milliseconds: 100),
                          onPressed: () {
                            setState((){
                              _nowChallenge = true;
                              todayChallenge = true;
                              completeChallenge = true;
                              successChallenge.add(challengelist[challengeNumber[timeBlock]]);
                              successChallengePoint.add(challengelistPoint[challengeNumber[timeBlock]]);
                              sum += challengelistPoint[challengeNumber[timeBlock]];
                              addPoint = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.35,
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, 0, 0, 50),
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent,
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Text('완료했어요', style: TextStyle(color: Colors.white, fontSize: 15)),
                                Spacer(),
                              ]
                            )
                          )
                        ),
                      ],
                    ),
                  ]))
              ):
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(child: Column(children:[
                    Center(child: Text('')),
                    Spacer(),
                    SizedBox(child: Column(children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Color(0xffEFEFEF),
                        ),
                        child: Center(child: Icon(challengeListIcon[challengeNumber[timeBlock]], color: challengeListIconColor[challengeNumber[timeBlock]], size: 70)),
                      ),
                      Container(margin: EdgeInsets.only(top: 30, left: 20, right: 20), child: Column(children: [
                        Text('활동', style: TextStyle(color: Colors.grey, fontSize: 20)),
                        Text('', style: TextStyle(fontSize: 20)),
                        Text(challengelist[challengeNumber[timeBlock]], style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                        Text('', style: TextStyle(fontSize: 6)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(challengelistHow[challengeNumber[timeBlock]][0], style: TextStyle(color: Colors.grey, fontSize: 20))),
                      ]
                      )
                      ),
                    ])),
                    Spacer(),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        child: Bounce(
                          duration: Duration(milliseconds: 100),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 50),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent,
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Text('도전하기', style: TextStyle(color: Colors.white, fontSize: 17)),
                                Spacer(),
                              ]
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
                        Text(completeChallenge ? questionPoint[challengeNumber[timeBlock]].toString()+'P 획득!' : '포인트 획득 실패!', style: TextStyle(color: completeChallenge ? Colors.black : Colors.redAccent, fontSize: 25, fontWeight: FontWeight.bold)),
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
                            onPressed: () async {
                              print('리워드 받기');
                              Navigator.pop(context);
                              if (todayMemo[timeBlock] == false) {
                                time += 1;
                                setTime();
                                DBHelper().insertMemo(Memo(id: year * 1000000 + month * 10000 + day * 100 + time, title: question[challengeNumber[timeBlock]], point: questionPoint[challengeNumber[timeBlock]], createTime: getToday(), time: getTime()));
                                print(await DBHelper().memos());
                                todayMemo[timeBlock] = true;
                              }
                              _isChallenge = false;
                              setIsChallenge();
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
                      Icon(challengeListIcon[challengeNumber[timeBlock]], color: challengeListIconColor[challengeNumber[timeBlock]], size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(question[challengeNumber[timeBlock]], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text('챌린지를 진행 중이에요\n', style: TextStyle(color: Colors.grey, fontSize: 20)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.monetization_on_rounded, color: Colors.amber),
                                    Text(questionPoint[challengeNumber[timeBlock]].toString()+' 획득이 가능해요.', style: TextStyle(color: Colors.amber, fontSize: 17)),
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
                                    todayChallenge = true;
                                    completeChallenge = true;
                                    successChallenge.add(question[challengeNumber[timeBlock]]);
                                    successChallengePoint.add(questionPoint[challengeNumber[timeBlock]]);
                                    sum += questionPoint[challengeNumber[timeBlock]];
                                  }
                                  else {
                                    print('not answer');
                                    _nowChallenge = true;
                                    todayChallenge = true;
                                    completeChallenge = false;
                                    print(answer);
                                  }
                                });
                              },
                              child: Text(answer == index ? questionAnswer[challengeNumber[timeBlock]] : questionChooser[challengeNumber[timeBlock]][index], style: TextStyle(color: Colors.black, fontSize: 17),
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
                                setIsChallenge();
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
                      Icon(challengeListIcon[challengeNumber[timeBlock]], color: challengeListIconColor[challengeNumber[timeBlock]], size: 70),
                      Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                        Text(question[challengeNumber[timeBlock]], style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(questionPoint[challengeNumber[timeBlock]].toString()+'포인트 획득이 가능해요.', style: TextStyle(color: Colors.grey, fontSize: 20))),
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
              ) : Center(
                child: Column(
                    children: [
                  Spacer(),
                  Spacer(),
                  Image.asset('assets/CharacterTime.png', height: 200),
                  Spacer(),
                  Text('다음 도전과제를 기다려 주세요!', style: TextStyle(fontSize: 23)),
                  Text('', style: TextStyle(fontSize: 6)),
                  Text('조금 있다가 다시 만나요.', style: TextStyle(color: Colors.grey, fontSize: 17)),
                  Spacer(),
                  Spacer(),
                  Bounce(
                    duration: Duration(milliseconds: 100),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50, right: 40, left: 40),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF2F2F2),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Text('확인', style: TextStyle(color: Colors.black, fontSize: 20)),
                          Spacer(),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ])
              ),

              onWillPop: () {
                print('나갈수 없어!');
                return Future(()=>false);
              },
            )
        )
    );
  }
  @override
  setTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('time', time);
  }
}
CalendarFormat _calendarFormat = CalendarFormat.month;



class RememberList extends StatefulWidget {
  const RememberList({Key? key}) : super(key: key);

  @override
  State<RememberList> createState() => _RememberListState();
}

class _RememberListState extends State<RememberList> {
  final memoController = TextEditingController();
  var memoSave = true;

  @override
  setIsChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isChallenge', _isChallenge);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          appBar: AppBar(
              backgroundColor: Colors.white,
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
          ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: Column(
                children: [
                  Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.1))),
                      ),
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xffF2F2F2),
                                      ),
                                      child: Center(child: Icon(challengeListIcon[challengeNumber[timeBlock]], color: challengeListIconColor[challengeNumber[timeBlock]], size: 30))),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.6,
                                      child: Text('  '+challengelist[challengeNumber[timeBlock]], style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))),
                                ],
                              ),
                              Text('', style: TextStyle(fontSize: 10)),
                              Text(challengelistHow[challengeNumber[timeBlock]][0], style: TextStyle(color: Colors.grey, fontSize: 15)),
                              Text('', style: TextStyle(fontSize: 20)),
                            ]),
                          ),
                          Spacer(),
                        ],
                      )
                    ),]),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Text('종합 평가', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text('\n방금 활동은 어땠나요?', style: TextStyle(color: Colors.grey, fontSize: 13)),
                              Text('', style: TextStyle(fontSize: 20)),
                              Row(children: [
                                Spacer(),
                                Spacer(),
                                Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: emotion[0] ? Color(0xffDFDFDF) : Color(0xffF2F2F2),
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
                                                nowemotion = 0;
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
                                      margin: EdgeInsets.only(bottom: 10),
                                    ),
                                    Text('좋지 않음', style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: emotion[1] ? Color(0xffDFDFDF) : Color(0xffF2F2F2),
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
                                                nowemotion = 1;
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
                                      margin: EdgeInsets.only(bottom: 10),
                                    ),
                                    Text('보통', style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: emotion[2] ? Color(0xffDFDFDF) : Color(0xffF2F2F2),
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
                                                nowemotion = 2;
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
                                      margin: EdgeInsets.only(bottom: 10),
                                    ),
                                    Text('좋음', style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                Spacer(),
                                Spacer(),
                              ]),
                              Container(
                                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                                margin: EdgeInsets.only(top: 30),
                                child: Center(
                                  child: Column(children: [
                                    Text('느낀 점', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                    Text('\n느낀 점은 나중에 \'기록\'에서 다시 볼 수 있어요.\n', style: TextStyle(color: Colors.grey, fontSize: 13)),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '도움이 되었나요?',
                                            hintStyle: TextStyle(color: Colors.grey)
                                        ),
                                        maxLines: null,
                                        controller: memoController,
                                      )
                                    )
                                  ])
                                )
                              ),
                            ],
                          )
                        ),
                      ),
                    )
                ]
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 50),
            child: Bounce(
              duration: Duration(milliseconds: 100),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                decoration: BoxDecoration(
                  color: memoSave ? Colors.blueAccent : Color(0xffDFDFDF),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(memoSave ? 0.03 : 0),
                      blurRadius: 15,
                      spreadRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(memoSave ? 0.0165 : 0),
                      blurRadius: 7.5,
                      spreadRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color(0XFF000066).withOpacity(memoSave ? 0.0095 : 0),
                      blurRadius: 5,
                      spreadRadius: 2.5,
                      offset: const Offset(0, 2.5),
                    ),
                  ]
                ),
                child: Row(children: [
                  Spacer(),
                  Text(memoSave ? '저장하기': '느낀 점을 입력해주세요.', style: TextStyle(color: memoSave ? Colors.white : Colors.grey, fontSize: 17)),
                  Spacer(),
                ]),
              ),
              onPressed: () async {
                if(memoSave == true){
                  if(memoController.text.length > 0){
                    if (addPoint == false) {
                      successChallenge.add('기록하기');
                      successChallengePoint.add(20);
                      sum += 20;
                      addPoint = true;
                      print('time: $time');
                      if (todayMemo[timeBlock] == false) {
                        time += 1;
                        setTime();
                        DBHelper().insertMemo(Memo(
                            id: year * 1000000 + month * 10000 + day * 100 + time,
                            title: challengelist[challengeNumber[timeBlock]],
                            point: challengelistPoint[challengeNumber[timeBlock]],
                            emotion: nowemotion,
                            memo: memoController.text,
                            createTime: getToday(),
                            time: getTime()));
                        print(await DBHelper().memos());
                        setState((){
                          todayMemo[timeBlock] = true;
                        });
                      }
                      _isChallenge = false;
                      setIsChallenge();
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }
                    else {
                      DBHelper().updateMemo(Memo(
                          id: year * 1000000 + month * 10000 + day * 100 + time,
                          title: challengelist[challengeNumber[timeBlock]],
                          point: challengelistPoint[challengeNumber[timeBlock]],
                          emotion: nowemotion,
                          memo: memoController.text,
                          createTime: getToday(),
                          time: getTime()));
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }
                  }
                else {
                  setState((){
                    Duration duration = new Duration(seconds: 3);
                    memoSave = false;
                    Future.delayed(duration, (){
                      setState((){
                        memoSave = true;
                      });
                      print('memoSave = true');
                    });
                  });
                }}
                else {
                }
              }
            ),
          ),
        )
    );
  }
  @override
  setTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('time', time);
  }
}


class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
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
                  Image.asset('assets/'+challengelistHowImage[challengeNumber[timeBlock]], width: 50),
                  Text(' ', style: TextStyle(fontSize: 40)),
                  Text(challengelist[challengeNumber[timeBlock]], style: TextStyle(color: AllWidgetColor, fontSize: 30, fontWeight: FontWeight.bold)),
                  Text(' ', style: TextStyle(fontSize: 30),),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child:
                    Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          strutStyle: StrutStyle(fontSize: 20),
                          text: TextSpan(text: challengelistHow[challengeNumber[timeBlock]][0], style: TextStyle(color: AllFontColor, fontSize: 20)),
                        )
                    )
                  ),
                  Container(
                    child: Column(children: [
                      for(var i = 2; i <= challengelistHow[challengeNumber[timeBlock]].length; i++)
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
                                text: TextSpan(text: challengelistHow[challengeNumber[timeBlock]][i - 1], style: TextStyle(color: AllWidgetColor, fontSize: 20)),

                              )
                            )
                          ])
                        )
                    ]),
                  ),
                  Spacer(),
                  Bounce(
                    duration: Duration(milliseconds: 100),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff3F3F3F),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Text('확인', style: TextStyle(color: AllWidgetColor, fontSize: 20)),
                          Spacer(),
                        ]
                      )
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