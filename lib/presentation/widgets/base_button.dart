import 'package:flutter/material.dart';
import 'package:test_test/consts/view_consts.dart';

typedef BaseButtonOnTap  = Function();

class BaseButton extends StatelessWidget{
  final String buttonText;
  final double width;
  final double height;
  final bool loading;
  final BaseButtonOnTap onTap;
  final Color color;
  BaseButton({
    required this.buttonText,
    required this.width,
    required this.height,
    this.loading = false,
    required this.onTap,
    this.color = Colours.PRIMARY_8
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: new Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Center(
          child: !loading ? new Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button,
          ) : Padding(
            padding: const EdgeInsets.only(top:12.0, bottom: 12),
            child: Container(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colours.NEUTRAL_1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BaseOutlineButton extends StatelessWidget{
  final String buttonText;
  final double height;
  final bool loading;
  final BaseButtonOnTap onTap;
  final Color color;
  BaseOutlineButton({
    required this.buttonText,
    required this.height,
    this.loading = false,
    required this.onTap,
    this.color = Colours.PRIMARY_8,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: (){
              onTap();
            },
            child: new Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color, width: 2),
              ),
              child: Center(
                child: !loading ? new Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.button!.copyWith(color: color),
                ) : Padding(
                  padding: EdgeInsets.only(top:12, bottom: 12),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colours.NEUTRAL_1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}