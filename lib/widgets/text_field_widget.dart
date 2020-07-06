import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:keyboard_actions/keyboard_actions.dart';

import 'package:flutter_best_practice/constant/constant.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final void Function(String) onSubmitted;
  final bool isInputPwd;
  final KeyboardActionsConfig config;

  TextFieldWidget({
    Key key,
    @required this.controller,
    this.maxLength = 16,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.hintText = "",
    this.focusNode,
    this.onSubmitted,
    this.isInputPwd = false,
    this.config
  }) : super(key: key);

  @override 
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _isShowDelete;

  @override
  void initState() {
    super.initState();
    _isShowDelete = widget.controller.text.isNotEmpty;
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override 
  void dispose() {
    widget.controller?.removeListener(() {});
    widget.controller?.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(highlightColor: Colors.transparent, splashColor: Colors.transparent),
        child: TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          autofocus: widget.autoFocus,
          onSubmitted: widget.onSubmitted,
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType,
          inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
              [WhitelistingTextInputFormatter(RegExp("[0-9]"))] : [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))],
          style: TextStyle(color: Color(0xff333333), fontSize: 14),
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            contentPadding: EdgeInsets.only(left: 0.0, top: 14.0, bottom: 14.0),
            hintStyle: TextStyle(color: Color(0xff8c8c8c), fontSize: 14),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffdadada))
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffdadada))
            ),
            fillColor: Colors.transparent,
            filled: true,
            suffixIcon: _isShowDelete
              ? Container(
                  width: 14.0,
                  height: 14.0,
                  child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    iconSize: 14.0,
                    icon: Image.asset(
                      Constant.ASSETS_IMG + 'icon_et_delete.png',
                      width: 14.0,
                      height: 14.0,
                    ),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.text = '');
                    },
                  ),
                )
              : Text('')
          ),
          maxLines: 1,
          obscureText: widget.isInputPwd ? true : false,
        ),
      ),
    );
  }
}