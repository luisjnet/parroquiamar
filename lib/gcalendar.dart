
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'dart:core';

var calendar;
var calEvents;
var oneHour = new Duration(hours : 1);
DateTime timingSpain;
final spanishFormat = new DateFormat('HH:mm dd-MM-yyyy');
String stringTiming;

final accountCredentials = new ServiceAccountCredentials.fromJson({
  "private_key_id": "b337d9e4e5f3678b0ca8b9af925d948e16c777d1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDVykvdLQYhfcMU\niEdOTK1FDAwyTYEG2rGlqbrnwz1GQzT0I+JCAROTur+/KCxX7g8qKSbHB8lxOTEY\nKk/ZMTfbtCvarwHM1NoAfglFxzmp0a9sSCexpqSbLl/9A0iZ32TPS21+ZMuLJ82d\necI5V2XPS2oWNUexMuok+dXFyUDlhuzTMW3MXrgaaTn7RG+sPWX3OxqyS7gQwG7X\nUHS+45rmUGOKSOVztkkyVDK+ay54kw+sVRhhmStDZ/i2QbMAwzLkdMTAHwha2p8h\n2rP+NmqBQwiRaa/wcfGa7EkhMfaWxQBUB59CbFwSj9HAvk7lvAR1nGcjCcoAK6QS\nnywscIjLAgMBAAECggEAH/cyZqyfuQw7yesidkOiuKs3e6H5A9RZMYLyTkrz83iD\nB2oCH4pXqgQHPYa9MpyGqfAjOykf5oz9mTZiYAAq8O+8iuMV6tF8kwxFSKikJ48R\noqgbP0XCYO2LLqJ6DX/Ia/JEOdzKTlEyPjSBZN97eoY1I4Lt6EHLnqG4Y+1Whbrj\n3xnQq3cfeHERwZS50Xe850358jKW4UTMSTd9XmYs+SAFTxnSehpZsLTgODm9VWhj\neNqkHlPDXqmleRz1feyUabhLP2PvFIC1wqnA9JxgUIB47xXxWY7f56SealkuhFRP\ntcKNBLy074HnVnmIxyi3iQ24eA23dBpffnnHljSkgQKBgQDulL1SihsHR0LtCRJB\nfpKaQrMrVsFIpxGmDNS5ReMbGl2XLob8pbbl7pDhtJPiHq9E7CX+ZzIRoxgIUD7E\nx6zA+J9vlug8hdU75crE2fKrmSHqWQztUiB6IEh66e7Qe4bESxIuoViPkjsO8kDj\nTLM2c6oJN9ytwUUd5cYHQLjoiwKBgQDlZjKx96Fghw8mB17yyntREqMFKuG+Scra\ntl9zG+dozHiZirob6EizQiDfXYwEZhJFjvzJBGloMw59+g0aghRR765u5wjNwQPC\n0RED5s9IK9nqbPSWiENEyGaRFX44pFN5I8hNMi7zjYCaWuO+6zYJB71lyciRUSqd\n3+cROQqowQKBgQCX6fnLDsk7DzMcP4RyU6gBtarkU69rFYZ1VwI0nr2HSniBhUzK\nnrIhIpD6RsNLXgJ4Pm3K2ebVuCXbVU1Ce2oSzbynj019DDLEmwNL6QNOJIml8OH8\nUyj+2oOMUFySP7WGU87WBkKf2JrmX3bVxMbwSyHgEMPhl4jtCpvXjmyvFQKBgGr1\nbLu4B0F3l6OWmjnAGSFi/Cmjpd/QjknN8NE9+HbPp4eHvGDYvFUAh00+U9OVN/3A\nvrKHYRJZg+9PEJ8Eea7+fylshZlR3owOaM2V553x/EgmhyBM5niCq/gHunN0gwsf\nmPwNYwDiQE04Bap2BxrMxg1YuTCwVJuJ0zYfj43BAoGAQCHi0DFUb3jvfehTtfom\nmtl2uCaC4phiCjzAS7JPHaaepQapH3jsFfO8XYfl+wXU9v12sR3UqU6yftEJJW1V\nK5vS5P9/KemQdBKIcu9dYfhz7a5KaJrz+gTNLiW5T4k6rFDGx4ZttTTCSyfEhQLm\nEsSC+hs6h3h8vSVHO1nr8MA=\n-----END PRIVATE KEY-----\n",
  "client_email": "gcalendar-api-parroquiamar@prefab-imagery-95922.iam.gserviceaccount.com",
  "client_id": "115751335696941906609",
  "type": "service_account"
});

var _scopes = [CalendarApi.CalendarScope]; //defines the scopes for the calendar api

void getCalendarEvents(DateTime startEvents, Map<DateTime, List> _eventsGcal)
{ 
    clientViaServiceAccount(accountCredentials, _scopes).then((client) {
      int contador=0;
      DateTime dateTimeTemp;
      var weekDayTemp=DateTime.now().weekday;
      
      calendar = new CalendarApi(client);
      calEvents = calendar.events.list(
        "parroquiamar@gmail.com",
        timeMin: startEvents,
        maxResults: 60,
        singleEvents: true,
        orderBy: "startTime"
      );
      List <dynamic> temporal= [];
      
      contador=0;
      calEvents.then((Events events) {
/*        dateTimeTemp =events.items[0].start.dateTime;
        timingSpain=events.items[0].start.dateTime.add(oneHour);

        stringTiming= spanishFormat.format(timingSpain);

        temporal.insert(contador,events.items[0].summary + "   " + stringTiming);
        weekDayTemp=events.items[0].start.dateTime.weekday;
        print("EVENTO PRIMERO Título= "+ events.items[0].summary +
                          " -INI"+ events.items[0].start.dateTime.toString()+
                          " -ALAMACENADA"+ events.items[0].summary + "   " + stringTiming+
                          " EN "+ contador.toString()
                    );


//        temporalTimes.insert(contador,events.items[contador].start.dateTime);
        contador++;
*/        events.items.forEach((event) {
          if(weekDayTemp !=event.start.dateTime.weekday)
            {              
              print("CAMBIO DE DIA " + dateTimeTemp.toString());
              print("LISTAS: " + temporal.toString());
              
            _eventsGcal.putIfAbsent(dateTimeTemp,  () => List.from(temporal));
            contador=0;
            temporal.clear();
            timingSpain=event.start.dateTime.add(oneHour);
            stringTiming= spanishFormat.format(timingSpain);
            temporal.insert(contador,event.summary + "   " + stringTiming);

                    print("EVENTO Título= "+ event.summary +
                          " -INI"+ event.start.dateTime.toString()+
                          " -ALAMACENADA"+ event.summary + "   " + stringTiming+
                          " EN "+ contador.toString()
                    );


            contador++;
            weekDayTemp=event.start.dateTime.weekday;

                   

            }
          else
            {
            timingSpain=event.start.dateTime.add(oneHour);
            stringTiming= spanishFormat.format(timingSpain);

            temporal.insert(contador,event.summary + "   " + stringTiming);

            print("_evento Título= "+ event.summary +
                          " -ini"+ event.start.dateTime.toString()+
                          " -almacenada"+ event.summary + "   " + stringTiming+
                          " en "+ contador.toString()
                    );

            contador++;
            }
          
//          _eventsGcal.putIfAbsent(event.start.dateTime,  () => List.from(temporal));
          dateTimeTemp=event.start.dateTime;
/*
          print("EVENTO Título= "+ event.summary +
                " -Descripción= "+ event.description+
                " -INI"+ event.start.dateTime.toString()+
                " -END"+ event.end.dateTime.toString()+
//                " -UPD"+ event.updated.toString()+
          "FECHA"+ startEvents.toString()+
          "LOC"+ event.location+
          "CR"+ event.created.toString()
          
          +
          "R_a:"+ event.recurrence[0]+
          "R_b:"+ event.recurrence[1]+
          "R_c:"+ event.recurrence[2]+
          "R_d:"+ event.recurrence[3]+
          "RECUR_ID:"+ event.recurringEventId+
          "N" + event.sequence.toString()+
          "ST" + event.source.title+
          "OST"+ event.originalStartTime.dateTime.toString()*/
//          );          

//         recurrenceRule=GrecMinimal.fromTexts(event.recurrence);
//          print("RECURR = " + recurrenceRule.toString());


          });
          



      });
    });

}
