import 'package:bebkeler/core/word.dart';
import 'package:bebkeler/infrastructure/mvvm.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_dnd.dart';
import 'dnd_vm.dart';

class DndTest extends StatelessWidget {
  final DndViewModel vm;

  DndTest({Key? key, required List<Word> words})
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
              style: TextStyle(fontSize: 22, color: AppColors.green, fontWeight: FontWeight.bold)),
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
            builder: (context, DndViewModel vm, _) => Column(
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
                  child: DraggableCard(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.black, width: 10),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Image.network(vm.currentWord.imageUrl)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
