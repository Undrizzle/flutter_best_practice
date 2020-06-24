import 'package:flutter/material.dart';

import 'package:flutter_best_practice/constant/constant.dart';

typedef void ITextFieldCallBack(String content);

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isInputPwd;
  final ITextFieldCallBack contentStrCallback;

  TextFieldWidget({
    Key key,
    @required this.controller,
    this.isInputPwd = false,
    this.contentStrCallback
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
          controller: widget.controller,
          style: TextStyle(color: Color(0xff333333), fontSize: 14),
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.isInputPwd ? "请输入登录密码" : "手机号或邮箱",
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
                      setState(() {
                        widget.controller.text = '';
                        widget.contentStrCallback(widget.controller.text);
                      });
                    },
                  ),
                )
              : Text('')  
          ),
          onChanged: (str) {
            setState(() {
              widget.controller.text = str;
              widget.contentStrCallback(widget.controller.text);
            });
          },
          keyboardType: TextInputType.text,
          maxLength: 20,
          maxLines: 1,
          obscureText: widget.isInputPwd ? true : false,
        ),
      ),
    );
  }
}