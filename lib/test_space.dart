import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar.dart';
import 'package:super_medic/widgets/mainPage_widgets/medication_time.dart';
import 'package:super_medic/widgets/mainPage_widgets/note.dart';
import 'package:super_medic/widgets/mainPage_widgets/symptom.dart';

class MultiBoardListExample extends StatefulWidget {
  const MultiBoardListExample({Key? key}) : super(key: key);

  @override
  State<MultiBoardListExample> createState() => _MultiBoardListExampleState();
}

class _MultiBoardListExampleState extends State<MultiBoardListExample> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    boardController = AppFlowyBoardScrollController();
    final group1 = AppFlowyGroupData(id: "To Do", name: "To Do", items: [
      TextItem("MedicationTime"),
      TextItem("BloodSugar"),
      TextItem("BloodPressure"),
      TextItem("Symptom"),
      TextItem("Note"),
    ]);

    controller.addGroup(group1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const config = AppFlowyBoardConfig(
        // groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
        // stretchGroupHeight: false,
        );
    return AppFlowyBoard(
        controller: controller,
        cardBuilder: (context, group, groupItem) {
          Widget? choise;
          print(groupItem);
          if (groupItem == "MedicationTime") {
            choise = const MedicationTime();
          } else if (groupItem == "BloodSugar") {
            choise = const BloodSugar();
          } else if (groupItem == "BloodPressure") {
            choise = const BloodPressure();
          } else if (groupItem == "Symptom") {
            choise = const Symptom();
          } else if (groupItem == "Note") {
            choise = const Note();
          }
          return Container(
            key: ValueKey(groupItem.id),
            child: _buildCard(groupItem),
          );
        },
        boardScrollController: boardController,
        footerBuilder: (context, columnData) {
          return AppFlowyGroupFooter(
            icon: const Icon(Icons.add, size: 20),
            title: const Text('New'),
            height: 50,
            margin: const AppFlowyBoardConfig().groupItemPadding,
            onAddButtonClick: () {
              boardController.scrollToBottom(columnData.id);
            },
          );
        },
        groupConstraints:
            const BoxConstraints.tightFor(width: 240, height: 500),
        config: config);
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(item.s),
        ),
      );
    }

    throw UnimplementedError();
  }
}

// class RichTextCard extends StatefulWidget {
//   final RichTextItem item;
//   const RichTextCard({
//     required this.item,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<RichTextCard> createState() => _RichTextCardState();
// }

// class _RichTextCardState extends State<RichTextCard> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.item.title,
//               style: const TextStyle(fontSize: 14),
//               textAlign: TextAlign.left,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               widget.item.subtitle,
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}
