import 'dart:async';
import 'package:flutter/material.dart';

import 'package:grec_minimal/grec_minimal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:parroquiamar/gcalendar.dart';

import 'dart:core';

var calendar;
var calEvents;
bool eventsAreLoaded=false;

var contadorItems=0;

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class Calendar extends StatefulWidget {
   ListView menuLateral;
    Calendar({this.menuLateral});

  @override
  _CalendarState createState() => new _CalendarState();
 }
class _CalendarState extends State<Calendar>  with TickerProviderStateMixin{
  
List <RecurrenceRule> recurrenceRule;
  AnimationController _animationController;
  CalendarController _calendarController;
  Map<DateTime, List> _events={};
  Map<DateTime, List> _timings={};
  List _selectedEvents;
  DateTime _daySelected;
  final _selectedDay = DateTime.now();
  Timer timerGcalendar;
  
  
 @override
  void initState() {
    super.initState();
      eventsAreLoaded=false;
      String dateNow = new DateTime.now().toUtc().toIso8601String();
            getCalendarEvents(DateTime.parse(dateNow),_events);
            timerGcalendar = Timer.periodic(Duration(seconds: 2), (Timer t) => checkIfEventsLoaded());



  
      _selectedEvents = _events[_selectedDay] ?? [];


    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    
    super.dispose();
  }

  void checkIfEventsLoaded() {
    if(_events.isEmpty)
      {
      print("Events Not Loaded");

      }
    else
      {
      print("Events Loaded");
              setState(() {
          eventsAreLoaded=true;
        });
      timerGcalendar.cancel();
      }
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      
      _selectedEvents = events;
      _daySelected=day;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

 @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    if (eventsAreLoaded==true)
      {
            return Scaffold(
              appBar: new AppBar(
                title: new Text("Parroquia Ntra. Señora del Mar",
                                style: new TextStyle(fontSize: 18.0),),            
                centerTitle: true,
                backgroundColor: Colors.blueAccent,  
                 actions: <Widget>[
                        IconButton(
                          icon: new Image.asset("assets/images/no_image.png"),
                          onPressed: () {
                            // do something
                          },
                        )
                      ],
                ),

              drawer: new Drawer(
                      child: widget.menuLateral,              
              ),
              body:
                Container(
                    child:          
                      Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // Switch out 2 lines below to play with TableCalendar's settings
                        //-----------------------
                        _buildTableCalendar(),
                                                                  // _buildTableCalendarWithBuilders(),
                        const SizedBox(height: 8.0),
                        _buildButtons(),
                        const SizedBox(height: 8.0),
                        Expanded(child: _buildEventList()),
                      ],
                    ),
                  
                ),
            );
          
            }
          else
            {
            return Scaffold(
              appBar: new AppBar(
                title: new Text("Parroquia Nuestra Señora del Mar"),
                centerTitle: true,
                backgroundColor: Colors.blueAccent,
                  ),
              drawer: widget.menuLateral,
              body: Center(
                        child: CircularProgressIndicator(),
                      ),
            );
            }
        
  
  }


  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

// More advanced TableCalendar configuration (using Builders & Styles)
  /*
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }


  Widget _buildEventsMarker (DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
*/
  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Mes'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 Semanas'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Semana'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
/*        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      */
      ],
    );
  }

  Widget _buildEventList() {


    
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
 
    );
 
  }
}

  
