import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertWidget{

  // Alert for sign-in/registration fail
  generateAlert({ @required context, @required title, @required description}){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            /*
            * popping the context 2 times
            * first pops the dialog
            * second pops the loading screen and returns back to the sign-in/reg screen
            */
            Navigator.pop(context);
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );
  }

  generateContinueWatchingAlert({ @required context, @required title, @required description}){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Okay!",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );
  }

  generateUploadVideoDialog({ @required context, @required title, @required description}){
    return Alert(
      context: context,
      type: AlertType.none,
      title: title,
      desc: description,
      /*content: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.connected_tv),
          labelText: 'http://',
        ),
      ),*/
      content: Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 42,
                      color: kPurpleColor,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    // border: Border.all(
                    //   color: kPurpleColor
                    // )
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Icon(
                      Icons.video_call,
                      size: 42,
                      color: kPurpleColor,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    // border: Border.all(
                    //   color: kPurpleColor
                    // )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color: kPurpleColor,
          child: Text(
            "Upload",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );
  }

}
