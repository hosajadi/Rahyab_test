import 'package:flutter/material.dart';
import 'package:test_test/consts/view_consts.dart';

typedef OnFieldSubmitted  = Function();

class CustomTextInput extends StatefulWidget{
  final String? label;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget icon;
  final bool? enableError;
  final OnFieldSubmitted? onFieldSubmitted;
  final bool disable;
  final TextInputAction textInputAction;
  final FocusNode ? focusNode;
  CustomTextInput({
    this.label,
    required this.hintText,
    required this.textEditingController,
    required this.icon,
    this.onFieldSubmitted,
    this.enableError,
    this.disable = false,
    this.textInputAction = TextInputAction.done,
    this.focusNode
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _isHover = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.label != null ? new Text(
          widget.label!,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colours.NEUTRAL_9,
            fontSize: 14,
            letterSpacing: 1.5
          ),
        ) : Center(),
        new Padding(
          padding: EdgeInsets.only(top:4),
          child: Material(
            elevation: _isHover ? 2 : 0,
            shadowColor: Colours.NEUTRAL_4,
            child: new TextField(
              controller: widget.textEditingController,
              textAlign: TextAlign.start,
              focusNode: widget.focusNode,
              onSubmitted: (String text) {
                if (widget.onFieldSubmitted != null){
                  widget.onFieldSubmitted!();
                }
              },
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colours.NEUTRAL_9,
                letterSpacing: 1.5
              ),
              cursorColor: Colours.PRIMARY_8,
              decoration: InputDecoration (
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colours.NEUTRAL_6,
                  fontSize: 14,
                ),
                errorText: widget.enableError != null && widget.enableError == true ? '' : null,
                errorStyle: TextStyle(
                  fontSize: 0.1,

                ),
                errorMaxLines: 1,
                prefixIcon: widget.icon,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2,color: Colours.PRIMARY_6),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2,color: Colours.NEUTRAL_4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2,color: Colours.NEUTRAL_4),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 2, color: Colours.NEUTRAL_4)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 2,color: Colours.DANGER_6)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 2,color: Colours.DANGER_6)
                ),
                enabled: !widget.disable
              ),
            ),
          ),
        ),
      ],
    );
  }
}