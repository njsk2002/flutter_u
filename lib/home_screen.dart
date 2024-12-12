import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() =>_HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>{
  DateTime firstDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child:Column(
          //위아래 끝에 위젯배치
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              //하트를 눌렸을때 실행할 함수 전달하기
              onHeartPressed : onHeartPressed,
              firstDay : firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  void onHeartPressed(){
    // 상태변경시 setState() 함수 호출
    // setState(() {
    //   firstDay = firstDay.subtract(Duration(days: 1));
    //  });
    showCupertinoDialog( // 쿠퍼티노 다이얼로그 실행
        context: context,  // 보여줄 다이얼로그 빌드
        builder: (BuildContext context) {
          //날짜를 선택하는 다이얼로그
          return Align(
            alignment: Alignment.bottomCenter, //아래 중간에 정렬
            child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                // 시간제외하고 날짜만 선택하기
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    firstDay = date;
                  });
                },
            ),
            ),
          );
        },
      barrierDismissible: true, // 외부에서 탭할 경우 다이얼로그 닫기
    );
      print('처음날자 : ${firstDay}');
  }
}


class _DDay extends StatelessWidget{
  // 하트 눌렸을때 실행할 함수
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay; // 태어난날
  
  _DDay({
    required this.onHeartPressed, // 상위에서 함수 입력받기
    required this.firstDay, //날짜변수 입력받기
});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now(); //현재날짜시간
    return Column(
      children: [
        const SizedBox(height: 10.0,),
        Text(//최상단 U&I 글자
          'You & I',
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 10.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        Text(
            // '2012.04.10',
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
           style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 10.0,),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed, // 아이콘 눌렸을때 함수 실행
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
            ),
        ),
        const SizedBox(height: 10.0,),
        Text(
          // 'D+365',
          // D-Day 계산하기
          'D+${DateTime(now.year,now.month,now.day).difference(firstDay).inDays + 1}',
          style: textTheme.headlineMedium,

        ),
      ],
    );
  }

}

class _CoupleImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
      child: Image.asset(
        'assets/img/seojin_with_me.jpg',
            // 화면을 반만큼 높이 구현
        height: MediaQuery.of(context).size.height/2,
      ),
      ),
    );
  }

}