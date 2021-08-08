import 'package:flutter/material.dart';
import 'package:play_app/utilities/constants.dart';

class InfoTile extends StatelessWidget {
  final String? name;
  final String? data;

  InfoTile({
    this.name,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'CM Sans Serif'
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            data!,
            style: TextStyle(
              color: kPurpleColor,
              fontSize: 16.0,
              //fontWeight: FontWeight.w400,
              fontFamily: 'Nunito'
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
