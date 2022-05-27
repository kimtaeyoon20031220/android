import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const FirstApp());
}


class FirstApp extends StatefulWidget {
  const FirstApp({Key? key}) : super(key: key);

  @override
  State<FirstApp> createState() => _FirstAppState();
}



class _FirstAppState extends State<FirstApp> {

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
      home: Scaffold(
        backgroundColor: Colors.black,


        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff111111),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xffc2bdd5).withOpacity(0.3),
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
    );
  }
}



class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);



  @override
  State<FirstPage> createState() => _FirstPageState();
}


class _FirstPageState extends State<FirstPage> {



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
              ],
            )
        ),
        Visibility(
          child: MainchallengeButton(),
          visible: todayChallenge ? false : true),

        NewButton(),
        WidgetBlock(),
        WidgetBadge(),
        ElevatedButton(
          onPressed: () {
            setState((){
              _isChallenge = true;
              _nowChallenge = false;
              todayChallenge = false;
            });
          },
          child: Text('챌린지 생성'),
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

  var watchtoday = 4;
  var watchmonth = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
        Container(
            margin: EdgeInsets.only(bottom: 30, top: 20, left: 10),
            child: CalendarWidget(),
        )
      ])
    );
  }
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
        margin: EdgeInsets.only(bottom: 30, top: 30, left: 20, right: 20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 50),
                Text(' $sum', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
          ]),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\n\n내역', style: TextStyle(color: Colors.white, fontSize: 20)),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(children: [
                      if (successChallenge.length > 0)
                        for(var i = 0; i < successChallenge.length; i++)
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff111111),
                            ),
                            child: Row(children: [
                              Text(challengelist[successChallenge[i]], style: TextStyle(color: Colors.white, fontSize: 15)),
                              Spacer(),
                              Icon(Icons.monetization_on_rounded, color: Colors.grey, size: 20),
                              Text(' ' + challengelistPoint[successChallenge[i]].toString(), style: TextStyle(color: Colors.grey, fontSize: 15)),
                            ])
                          )
                      else
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('\n\n\n\n\n포인트를 얻은 내역이 없어요.',style: TextStyle(color: Colors.grey, fontSize: 15)),
                              Text('챌린지를 완수하여 포인트를 얻을 수 있어요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
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
                  Center(child: Image.asset('assets/aboutus.png', height: 50)),
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
                        Image.asset('assets/KangPic.png', width: 50),
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/Kang.png', height: 35),
                              Image.asset('assets/KangInfo.png', height: 35),
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
                              Image.asset('assets/Lee.png', height: 35),
                              Image.asset('assets/LeeInfo.png', height: 35),
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
                        Image.asset('assets/KimPic.png', width: 50),
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/Kim.png', height: 35),
                              Image.asset('assets/KimInfo.png', height: 35),
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




class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key}) : super(key: key);


  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            elevation: 0.0,
            centerTitle: true,

        ),
        body: WillPopScope(
          child: _nowChallenge ?
          todayChallenge ?
          Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Center(child: Column(children:[
                Center(child: Text('')),
                Spacer(),
                SizedBox(child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 50),
                      Text(challengelistPoint[now].toString(), style: TextStyle(color: Colors.amber, fontSize: 50, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                    Text(challengelistPoint[now].toString()+'포인트 획득!', style: TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text('챌린지를 완수하여 리워드를 받았어요.', style: TextStyle(color: Colors.grey, fontSize: 15))),
                  ]
                  )
                  ),
                ])),
                Spacer(),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff2F2F2F),
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
                          Text('확인', style: TextStyle(color: Colors.white)),
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
                  Icon(Icons.pending_rounded, color: Colors.amber, size: 70),
                  Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                    Text(challengelist[now], style: TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text('챌린지를 진행 중이에요\n', style: TextStyle(color: Colors.white, fontSize: 17)),
                            Text(challengelistPoint[now].toString()+'포인트 획득이 가능해요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        )),
                  ]
                  )
                  ),
                ])),
                Spacer(),
                Spacer(),
                Container(

                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                        ),
                        onPressed: () {
                          print('리워드 받기');
                          setState((){
                            _nowChallenge = true;
                            _isChallenge = false;
                            todayChallenge = true;
                            successChallenge.add(now);
                          });
                          print(successChallenge);
                          print(_nowChallenge);
                          print(todayChallenge);
                        },
                        child: Row(children:[
                          Text(' '),
                          Spacer(),
                          Text('리워드 받기', style: TextStyle(color: Colors.black)),
                          Spacer(),
                          Text(' '),
                        ])
                    )
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          print('포기하기');
                          setState((){
                            _nowChallenge = false;
                            _isChallenge = false;
                            Navigator.pop(context);
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text('포기하기', style: TextStyle(color: Colors.grey)),
                            ])
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
                  Icon(Icons.monetization_on, color: Colors.amber, size: 70),
                  Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                    Text(challengelist[now], style: TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                        child: Text(challengelistPoint[now].toString()+'포인트 획득이 가능해요.', style: TextStyle(color: Colors.grey, fontSize: 15))),
                  ]
                  )
                  ),
                ])),
                Spacer(),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
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
                      Text('도전하기', style: TextStyle(color: Colors.black)),
                      Spacer(),
                      Text(' '),
                    ])
                  )
                )
              ]))
              ),
          onWillPop: () {
            return Future(() => false);
          },
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          elevation: 0.0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {
                Navigator.pop(context),
              },
              child: Icon(Icons.navigate_before),
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
                      child: Text('게으름에 시간을 매겨주세요!\n', style: TextStyle(color: Colors.white, fontSize: 25))),
                  Column(children: <Widget>[
                    for(var i = 0; i < todayList.length; i++)
                      if(todayList[i] == true)
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(20),
                          child: Row(children: [
                            Text(todayListName[i], style: TextStyle(color: Colors.white, fontSize: 17)),
                            Spacer(),
                            Text('시간 조정', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ])
                        )
                  ])
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
                      Text('오늘의 게으름을 선택해주세요.', style: TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
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
                                    primary: todayList[index] ? Colors.amber : Color(0xff1F1F1F),
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
                                  child: Text(todayListName[index], style: TextStyle(color: todayList[index] ? Colors.black : Colors.white),
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
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: Colors.amber,
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
                    Text('기록하기', style: TextStyle(color: Colors.black, fontSize: 15)),
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
class StfulTodaylist extends StatefulWidget {
  const StfulTodaylist({Key? key}) : super(key: key);

  @override
  State<StfulTodaylist> createState() => _StfulTodaylistState();
}

class _StfulTodaylistState extends State<StfulTodaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}





class BadgeApp extends StatelessWidget {
  const BadgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {
                Navigator.pop(context),
              },
              child: Icon(Icons.navigate_before_rounded),
            )
          )
        ),
        body: Container(
          color: Colors.black,
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Column(children:[
              Text('활동 뱃지', style: TextStyle(color: Colors.white, fontSize: 25)),
              Text('\n다양한 활동을 통해 뱃지를 얻을 수 있어요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
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
                    child: Column(children: [
                      badgeHave[index] ? Image.asset('assets/youtube.png', width: 60) : Icon(Icons.abc, color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(badgelist[index], style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
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


class ListApp extends StatefulWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  State<ListApp> createState() => _ListAppState();
}

class _ListAppState extends State<ListApp> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}










class WidgetBadge extends StatelessWidget {
  const WidgetBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(25),
          primary: Color(0xff111111),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
        child: Row(children: [
          Text("모은 뱃지", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          Text('3개', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal)),
          Icon(Icons.navigate_next, color: Colors.grey),
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
        color: Color(0xff111111),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children:[
              Text('어제', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            ]),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(children:<Widget>[
            if (yestlist.isNotEmpty == true)
              for(var i = 0; i < yestlist.length; i++)
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(children: [
                    Icon(Icons.abc, color: Colors.white, size: 20),
                    Text('  '+todayListName[i], style: TextStyle(color: Colors.white, fontSize: 17)),
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

var yestlist = ['잠', '유튜브', '유튜브'];
var yestTime = ['3', '2', '1'];
var yestlistIcon = ['sleep.png', 'youtube.png', 'youtube.png'];
var todayList = [false, false, false, false, false, false, false, false, false];
var todayListName = ['유튜브', '인스타그램', '페이스북', '에브리타임', '낮잠', '늦잠', '멍때림', '딴짓', '야식'];
var todayTime = [0,0,0,0,0,0,0,0,0];
var todayListNow = false;

var badge = 5;
var badgeS = '$badge';
var badgelist = ['첫 꿀곰', '두 번째 꿀곰', '세 번째 꿀곰', '네 번째 꿀곰', '다섯 번째 꿀곰']; //badge title
var badgelistText = ['첫 꿀곰 기록', '챌린지 첫 경험', '처음으로 돌아본 나', '네번째', '5']; //badge 설명
var badgeHave = [true, true, true, false, false]; //badge를 가지고 있는지
var badgeHaveN = 0; //가지고 있는 badge 개수
var mytext = '';

var challengelist = ['유튜브 1시간보다 적게 보기', '물 마시고 오기']; //각 챌린지 별 내용
var challengelistPoint = [10, 20]; //각 챌린지 별 포인트 지급
var sum = 0;
var successChallenge = []; //완료한 챌린지 인덱스
var now = Random().nextInt(2); //내가 하고 있는 챌린지의 인덱스
bool _isChallenge = true; //챌린지 위젯을 메인에 보여줄건지?
bool _nowChallenge = false; //지금 챌린지를 하고 있는지?
bool todayChallenge = false; //오늘의 챌린지를 수행했는지?
bool completeChallenge = false; //오늘의 챌린지를 완료했는지?
var answer = 0; //answer
var question = ['Google의 첫 CEO는?', 'Linux는 어떤 OS를 뿌리로 두고 있을까요?', 'B2B의 뜻은?', '테스트', '테스트2', '테스트3'];
var questionAnswer = ['래리 페이지', 'Unix', '비지니스 투 비지니스', '테스트', '테스트2', '테스트3'];

class NewButton extends StatelessWidget {
  const NewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child:
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xff111111),
            textStyle: TextStyle(color: Colors.black),
            padding: EdgeInsets.all(25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
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
              Text('기록하기', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
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
                primary: Color(0xff111111),
                textStyle: TextStyle(color: Colors.black),
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
            onPressed: () {
              answer = Random().nextInt(4);
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
                        Text(_nowChallenge ? todayChallenge ? completeChallenge ? challengelistPoint[now].toString() + 'P를 받았어요.' : '오늘의 챌린지를 완수하지 못했어요...': challengelist[now] : '챌린지 도전하고 '+challengelistPoint[now].toString()+'포인트 받기', style: TextStyle(color: todayChallenge ? completeChallenge ? Colors.amber : Colors.redAccent : Colors.amber, fontSize: 15, fontWeight: FontWeight.bold)),
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
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  child: Icon(Icons.navigate_before_rounded),
                )
            )
        ),
        body: WillPopScope(
          child: todayChallenge ?
          Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Center(child: Column(children:[
                Center(child: Text('')),
                Spacer(),
                SizedBox(child: Column(children: [
                  Icon(completeChallenge ? Icons.monetization_on_rounded : Icons.abc, color: completeChallenge ? Colors.amber : Colors.redAccent, size: 70),
                  Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                    Text(completeChallenge ? challengelistPoint[now].toString()+'포인트 획득!' : '포인트 획득 실패!', style: TextStyle(color: completeChallenge ? Colors.amber : Colors.redAccent, fontSize: 25, fontWeight: FontWeight.bold)),
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
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff2F2F2F),
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
                          Text('확인', style: TextStyle(color: Colors.white)),
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
                  Icon(Icons.pending_rounded, color: Colors.amber, size: 70),
                  Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                    Text(challengelist[now], style: TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text('챌린지를 진행 중이에요\n', style: TextStyle(color: Colors.white, fontSize: 17)),
                            Text(challengelistPoint[now].toString()+'포인트 획득이 가능해요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
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
                              primary: Color(0xff1F1F1F),
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
                                successChallenge.add(now);
                                sum += challengelistPoint[now];
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
                          child: Text(questionAnswer[index], style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                      );
                    },
                  ),
                    margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                        ),
                        onPressed: () {
                          print('포기하기');
                          setState((){
                            _nowChallenge = false;
                            _isChallenge = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FirstApp())).then((value) {
                            setState((){});
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                          Text('포기하기', style: TextStyle(color: Colors.grey)),
                        ])
                    )
                )
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

/*Widget QuestionText(index) {
  if (index == answer) {
    return Text(questionAnswer[answer], style: TextStyle(color: todayList[index] ? Colors.black : Colors.white);
  }
  else {
    return Text(questionAnswer[Random().nextInt(5)], style: TextStyle(color: todayList[index] ? Colors.black : Colors.white);
  }
}*/

class NowReward extends StatefulWidget {
  const NowReward({Key? key}) : super(key: key);

  @override
  State<NowReward> createState() => _NowRewardState();
}

class _NowRewardState extends State<NowReward> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                  backgroundColor: Colors.black,
                  leading: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => {
                        },
                        child: Icon(Icons.navigate_before_rounded),
                      )
                  )
              ),
              body: WillPopScope(
                child: Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Center(child: Column(children:[
                      Center(child: Text('')),
                      Spacer(),
                      SizedBox(child: Column(children: [
                        Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 70),
                        Container(margin: EdgeInsets.only(top: 30), child: Column(children: [
                          Text(challengelistPoint[now].toString()+'포인트 획득!', style: TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text('챌린지를 완수하여 리워드를 받았어요.', style: TextStyle(color: Colors.grey, fontSize: 15))),
                        ]
                        )
                        ),
                      ])),
                      Spacer(),
                      Spacer(),
                    ]))
                ),
                onWillPop: () {
                  return Future(() => false);
                },
              )
          )
      ),
      onWillPop: () {
        return Future(() => false);
      },
    );
  }
}

CalendarFormat _calendarFormat = CalendarFormat.month;

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
            case 1:
              return Center(child: Text('월', style: TextStyle(color: Colors.white)),);
            case 2:
              return Center(child: Text('화', style: TextStyle(color: Colors.white)),);
            case 3:
              return Center(child: Text('수', style: TextStyle(color: Colors.white)),);
            case 4:
              return Center(child: Text('목', style: TextStyle(color: Colors.white)),);
            case 5:
              return Center(child: Text('금', style: TextStyle(color: Colors.white)),);
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
      ),
      locale: 'ko-KR',
      daysOfWeekHeight: 30,
      headerStyle: HeaderStyle(
        headerMargin: EdgeInsets.only(left:40, top: 10, right: 40, bottom: 10),
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      eventLoader: (day){
        if (day.day%2==0){
          return ['hi'];
        }
        return [];
      },
    );
  }
}

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}



void startWrite() {
  print('기록하기를 눌렀습니다.');
}