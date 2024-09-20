import 'package:flutter/material.dart';
import 'package:get_speed/db_speed/speed_entity.dart';
import 'package:get_speed/main.dart';
import 'package:styled_widget/styled_widget.dart';

class SpeedItem extends StatelessWidget {
  const SpeedItem(this.entity,{Key? key}) : super(key: key);

  final SpeedEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: <Widget>[
        <Widget>[
          Image.asset(
            'assets/image${entity.type}.webp',
            width: 32,
            height: 32,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: <Widget>[
            Text(
              customTitles[entity.type],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              entity.time,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            )
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${entity.speed} M/s',
            style: TextStyle(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          )
        ].toRow(),
        Divider(
          height: 15,
          color: Colors.grey.withOpacity(0.3),
        )
      ].toColumn(),
    );
  }
}
