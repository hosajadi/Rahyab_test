import 'package:flutter/material.dart';
import 'package:test_test/consts/view_consts.dart';
import 'package:test_test/presentation/widgets/base_button.dart';

Future<void> errorAlert({required BuildContext context, required String header, required String message}){
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colours.NEUTRAL_4.withOpacity(0.80),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colours.NEUTRAL_1,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colours.NEUTRAL_4, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          content: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                header,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colours.NEUTRAL_9,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(top:24.0),
                child: new Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colours.NEUTRAL_9,
                  ),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: EdgeInsets.only(top:48, left: 48, right: 48, bottom: 56),
          actionsPadding: EdgeInsets.only(bottom: 48),
          actions: [
            BaseOutlineButton(buttonText: "ok", width: 160, height: 48, onTap: (){
              Navigator.pop(context);
            })
          ],
        );
      }
  );
}