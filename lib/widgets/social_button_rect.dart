import 'package:flutter/material.dart';

class SocialButtonRect {
  static Widget socialButtonRect(title, color, icon, {Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: color, borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget socialButtonCircle(icon, {iconColor, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(

          padding: const EdgeInsets.all(20.0),
          //I used some padding without fixed width and height
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            //borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Image.asset(
            icon,
            width: 50.0,
            height: 50.0,
          ) // You can add a Icon instead of text also, like below.
          //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
          ), //
    );
  }
}
