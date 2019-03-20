import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<PopupMenuItem<int>> _popupMenuItems;

  bool _areCommentsVisible;

  final _commentFormKey = GlobalKey<FormState>();

  _PostPageState() {
    makePopupMenuItems();

    _areCommentsVisible = true;
  }

  _changeCommentsVisibility() {
    setState(() {
      _areCommentsVisible = !_areCommentsVisible;
    });
  }

  makePostComment(imageUrl, name, date, votes, comment) {
    return Card(
      elevation: 0.0,
      color: Colors.white12,
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(50)
                  )
                ),
              ),
              title: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                date,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              trailing: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    tooltip: 'Гласај',
                  ),
                  Text(
                    votes,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  comment,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  makePopupMenuItems() {
    _popupMenuItems = [
      PopupMenuItem(
        value: 0,
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(
                right: 10.0,
              ),
            ),
            Text(
                'Сподели'
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.open_in_browser,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(
                right: 10.0,
              ),
            ),
            Text(
                'Извор'
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.help_outline,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(
                right: 10.0,
              ),
            ),
            Text(
                'Решение'
            )
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Text(
              'Натпревар',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.blueGrey,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              textTheme: TextTheme(
                  body1: TextStyle(
                    color: Colors.white,
                  )
              ),
            ),
            child: PopupMenuButton(
              tooltip: 'Прикажи мени',
              itemBuilder: (context) {
                return _popupMenuItems;
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.0),
              child: CarouselSlider(
                enlargeCenterPage: true,
                height: 200.0,
                items: [
                  'http://images6.fanpop.com/image/photos/40400000/Sheep-sheep-40487480-2560-1600.png',
                  'https://i.pinimg.com/originals/da/23/ef/da23ef5b4dad13a238d466d16dee4d01.png',
                  'https://i.imgur.com/FZwh6nb.jpg'
                ].map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                  top: 6.0,
                  bottom: 6.0,
                ),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 20,
                  lineHeight: 7.0,
                  percent: 0.5,
                  progressColor: Colors.yellow,
                  backgroundColor: Colors.white12,
                ),
              ),
            ),
            Container(
              child: Card(
                elevation: 0.0,
                color: Colors.white12,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://icons-for-free.com/free-icons/png/512/2754575.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        )
                      ),
                    ),
                    title: Text(
                      'Борјан Ѓоровски',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      '21:30 14.03.2019',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    trailing: IconButton(
                      tooltip: 'Повратна информација',
                      icon: Icon(
                        Icons.feedback,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 6.0,
                right: 6.0,
              ),
              child: Center(
                child: Card(
                  elevation: 0.0,
                  color: Colors.white12,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            'Натпревар',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Text(
                          'Арно сторил тој што ти го зел клопчето, ќерко, ѝ рекла, оти од узур ќе ми везеш црна кошула, сосила ќе ми се правиш ти вдовица; Силјан ни е на аџилак со дуовникот, а пак ти сосила сакаш да умре и да не дојде; гревота е, а ќерко, ова ти што го правиш; моли Бога за Господ да ни го донесе, не туку плачеш и жалиш. Ете некни ѓерданчето на Босилка ѝ загина; не е човечка глава да, човек умира и никому ништо, а ќерко, а не ти оти едно клопче ти загинало и да плачеш.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 6.0,
                right: 6.0,
              ),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 0.0,
                    color: Colors.white12,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                tooltip: 'Прикажи/сокри одговори',
                                icon: Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _changeCommentsVisibility();
                                },
                              ),
                            ],
                          ),
                          title: Text(
                            'Одговори',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            '523',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0.0,
                          color: Colors.black.withOpacity(0.0),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: 10.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: Form(
                              key: _commentFormKey,
                              child: TextFormField(
                                validator: (input) {
                                  return input.isEmpty ? 'Празен одговор нема да се прифати' : null;
                                },
                                textInputAction: TextInputAction.send,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onFieldSubmitted: (input) {
                                  if (_commentFormKey.currentState.validate()) {}
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  labelText: 'Внесете одговор',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              child: Container(
                margin: EdgeInsets.only(
                  top: 0.0,
                  bottom: 6.0,
                  left: 6.0,
                  right: 6.0,
                ),
                  child: Column(
                    children: <Widget>[
                      makePostComment('https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png', 'Мирослав Мисузо', '21:34 14.03.2019', '233', 'Ова е рандом комент текст којшто треба да биде огромен. Ако не расте повеќе од нормалата ќе биде јајце на велигден.'),
                      makePostComment('https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/4_avatar-512.png', 'Меланија Кокс', '22:47 14.03.2019', '23', 'Без разлика на класификацијата информациите се исти. Тоа како ти ќе си ги наредиш во главата е твоја работа. Не ме мешај мене и моиве.'),
                      makePostComment('https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/2_avatar-512.png', 'Игор Мишуковски', '16:27 15.03.2019', '11', 'Очигледно е дека ова е првиот пат. Незаинтересираност, непослушност, незнаење се само дел од карактеристиките кои ги карактеризираат нив.'),
                    ],
                  ),
                ),
              visible: _areCommentsVisible,
            )
          ],
        ),
      ),
    );
  }
}