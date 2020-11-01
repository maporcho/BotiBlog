import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'network_image_widget.dart';

class PostItem extends StatelessWidget {
  final String autor;
  final DateTime criadoEm;
  final String texto;
  final String urlAvatarUsuario;
  final bool editavel;
  final VoidCallback onPressed;

  const PostItem({
    this.autor,
    this.criadoEm,
    this.texto,
    this.urlAvatarUsuario,
    this.editavel = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _avatar(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _autorData(),
                              if (editavel) _iconeEditavel(),
                            ],
                          ),
                        ),
                        _texto(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  _avatar() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetIt.instance.get<NetworkImageWidget>()
          ..imageUrl = urlAvatarUsuario
          ..errorWidget = Image.asset(
            'assets/images/logo.png',
            height: 50.0,
          )
          ..placeholder = (context, url) => CircularProgressIndicator(),
      );

  _autorData() => Expanded(
        child: Container(
            child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: autor,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
            TextSpan(
                text: " - ${_formatarDataCriacao(criadoEm)}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ))
          ]),
          overflow: TextOverflow.ellipsis,
        )),
        flex: 5,
      );

  _iconeEditavel() => Padding(
        padding: const EdgeInsets.only(
          right: 4.0,
        ),
        child: Icon(
          FontAwesomeIcons.edit,
          color: Colors.grey,
        ),
      );

  _texto() => Padding(
        padding: const EdgeInsets.fromLTRB(
          0.0,
          4.0,
          8.0,
          4.0,
        ),
        child: Text(
          texto ?? '',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
      );

  String _formatarDataCriacao(DateTime dateTime) {
    if (dateTime == null || DateTime.now().toLocal().isBefore(dateTime)) {
      return '';
    }
    String msg = '';

    var duration = DateTime.now().toLocal().difference(dateTime);
    if (duration.inDays > 0) {
      return duration.inDays == 1
          ? 'ontem'
          : DateFormat(
              "dd MMM",
              Platform.localeName,
            ).format(dateTime);
    } else if (duration.inHours > 0) {
      msg = '${duration.inHours} h';
    } else if (duration.inMinutes > 0) {
      msg = '${duration.inMinutes} m';
    } else if (duration.inSeconds > 0) {
      msg = '${duration.inSeconds} s';
    } else {
      msg = 'agora';
    }
    return msg;
  }
}
