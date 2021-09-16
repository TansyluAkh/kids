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
                          .copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                  IconButton(icon: Icon(FontAwesomeIcons.volumeUp, color: AppColors.darkBlue), onPressed: () async {
                    await player.setUrl('https://firebasestorage.googleapis.com/v0/b/bebkeler-89a5e.appspot.com/o/pronunciation_tt_%D1%80%D3%99%D1%85%D0%BC%D3%99%D1%82.mp3?alt=media&token=1fa2d250-afc6-4b27-be6e-e5660021531a');
                    player.play();
                    },)]),
                  SizedBox(height: widget.height * 0.03),
                  Text(widget.item.definition, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center),
                  SizedBox(height: widget.height * 0.01),
                  Expanded(child:Align( alignment: Alignment.topCenter, child: Image.network(widget.item.imageUrl,
                      fit: BoxFit.contain)),
                  )])));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);


}
