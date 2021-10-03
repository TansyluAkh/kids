import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

class DetailsScreen extends StatefulWidget {
  final item;
  final width;
  final height;
  const DetailsScreen({Key key, this.item, this.height, this.width}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    Text(capitalize(widget.item.tatarWord),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: AppColors.orange, fontWeight: FontWeight.bold)),
                  IconButton(icon: Icon(FontAwesomeIcons.volumeUp, color: AppColors.orange), onPressed: () async {
                    await player.setUrl(widget.item.tatarAudio);
                    print(widget.item.tatarAudio);
                    player.play();
                    },)]),
                  SizedBox(height: widget.height * 0.03),
                  Text(widget.item.definition, style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.darkBlue), textAlign: TextAlign.center),
                  SizedBox(height: widget.height * 0.01),
                  Expanded(child:Align( alignment: Alignment.topCenter, child: Image.network(widget.item.imageUrl,
                      fit: BoxFit.contain)),
                  )])));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);


}
