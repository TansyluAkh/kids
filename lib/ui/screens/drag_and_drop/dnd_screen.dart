import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/infrastructure/mvvm/view.dart';
import 'package:bebkeler/ui/screens/drag_and_drop/dnd_vm.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DndTest extends StatelessWidget {
  final DndViewModel vm;

  DndTest({Key key, List<Word> words})
      : vm = DndViewModel(words),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.orange, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          centerTitle: true,
          title: Text('Тест',
              style:
                  TextStyle(fontSize: 22, color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Container(
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
            ),
          ),
          child: ViewBuilder(
            viewModel: vm,
            builder: (context, vm, _) => Column(
              children: [
                Container(
                  height: height * 0.8,
                  child: GridView.builder(
                    itemCount: vm.wordMatches.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      final pair = vm.wordMatches[index];
                      final filterColor =
                          pair.match == Match.none ? AppColors.gray : Colors.transparent;
                      final boxColor = pair.match == Match.correct
                          ? AppColors.green
                          : pair.match == Match.wrong
                              ? AppColors.red
                              : AppColors.white;

                      return DragTarget<Word>(
                        onAccept: (word) => vm.makeMatch(pair.word, word),
                        builder: (_, __, ___) => ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              filterColor,
                              BlendMode.saturation,
                            ),
                            child: Container(
                                color: boxColor, child: Image.network(pair.word.imageUrl))),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Draggable<Word>(
                    data: vm.currentWord,
                    feedback: Image.network(
                      vm.currentWord.imageUrl,
                      height: 250,
                    ),
                    childWhenDragging: Image.network(vm.currentWord.imageUrl),
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Image.network(vm.currentWord.imageUrl)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
