import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/time_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key, required this.userEmail}) : super(key: key);
  final String userEmail;
  @override
  State<AddMedicinePage> createState() => _AddMedicinePage();
}

class _AddMedicinePage extends State<AddMedicinePage> {
  double _inputHeight = 50;
  FocusNode textFocus = FocusNode();
  List<Item> items = List.empty(growable: true);
  List<Time> times = List.empty(growable: true);
  XFile? _pickedFile;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_checkInputHeight);
    items.add(Item(data: "월", isChecked: false));
    items.add(Item(data: "화", isChecked: false));
    items.add(Item(data: "수", isChecked: false));
    items.add(Item(data: "목", isChecked: false));
    items.add(Item(data: "금", isChecked: false));
    items.add(Item(data: "토", isChecked: false));
    items.add(Item(data: "일", isChecked: false));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = _textEditingController.text.split('\n').length;
    var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
    setState(() {
      _inputHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25.0,
        ),
        const Center(
          child: NanumTitleText(
            text: '약 등록',
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: const NanumTitleText(
                  text: '약 이름을 입력해주세요',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
                child: TextFormField(
                  controller: _textEditingController,
                  textInputAction: TextInputAction.done,
                  focusNode: textFocus,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: '약1, 약2, 약3 ...',
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.only(left: 10, top: 10),
                    prefixIcon: _pickedFile == null
                        ? null
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: imageSize,
                              height: imageSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                    image: FileImage(File(_pickedFile!.path)),
                                    fit: BoxFit.cover),
                              ),
                            )),
                    suffixIcon: GestureDetector(
                      child: const Icon(
                        Icons.camera_alt_outlined,
                      ),
                      onTap: () {
                        textFocus.unfocus();
                        _showBottomSheet();
                      },
                    ),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? Colors.green
                            : Colors.grey),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: const NanumTitleText(
                  text: '복용 요일을 선택하세요',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < items.length; i++)
                      GFCheckbox(
                        size: 40,
                        value: items[i].isChecked,
                        type: GFCheckboxType.circle,
                        onChanged: (value) {
                          textFocus.unfocus();
                          setState(() {
                            items[i].isChecked = value;
                          });
                        },
                        activeBgColor: Colors.green,
                        inactiveBorderColor: Colors.grey,
                        inactiveIcon: Align(
                          alignment: Alignment.center,
                          child: NanumBodyText(
                            text: items[i].data,
                            fontSize: 17,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        activeIcon: Align(
                          alignment: Alignment.center,
                          child: NanumBodyText(
                            text: items[i].data,
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const NanumTitleText(
                      text: '복용 시간을 추가하세요',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        textFocus.unfocus();
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                                height: 250,
                                decoration: const BoxDecoration(
                                  color: Colors.white, // 모달 배경색
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: TimePickerPage());
                          },
                        ).then((value) {
                          setState(() {
                            if (value != null) {
                              times.add(
                                Time(
                                    time: value,
                                    medicine: _textEditingController.text),
                              );
                            }
                          });
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    // return MedicineTime(times: times, index: index);
                    return Dismissible(
                      // 삭제 버튼 및 기능 추가
                      key: Key(times[index].time),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: NanumBodyText(
                                          text:
                                              times[index].time.substring(5) ==
                                                      'AM'
                                                  ? '오전'
                                                  : '오후'),
                                    ),
                                    NanumTitleText(
                                      text: times[index].time.substring(0, 5),
                                      fontSize: 30,
                                    )
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      times.removeAt(index);
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 15))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                if (checkValidate() == false) {
                  null;
                } else {
                  await postRequest();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: checkValidate() ? Colors.green : Colors.grey,
                minimumSize: Size(MediaQuery.of(context).size.width - 80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const NanumTitleText(
                text: '다음',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
        )
      ],
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10,
              right: 10),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: const Center(
                  child: NanumTitleText(
                    text: '사진업로드',
                    fontSize: 25,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      _getCameraImage();
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.13,
                          height: MediaQuery.of(context).size.width * 0.13,
                          child: Image.asset('assets/images/camera.png'),
                        ),
                        Container(
                          child: const NanumBodyText(text: '카메라'),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _getPhotoLibraryImage();

                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.13,
                          height: MediaQuery.of(context).size.width * 0.13,
                          child: Image.asset('assets/images/gallery.png'),
                        ),
                        Container(
                          // padding: EdgeInsets.only(top: 5),
                          child: const NanumBodyText(text: '앨범'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }

  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      print('이미지 선택안함');
    }
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      print('이미지 선택안함');
    }
  }

  postRequest() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mypd.kr:5000/medicine/upload'));
    if (_pickedFile != null) {
      http.MultipartFile image =
          await http.MultipartFile.fromPath('image', _pickedFile!.path);

      request.files.add(image);
    }
    request.fields['email'] = widget.userEmail;
    request.fields['medicine'] = _textEditingController.text;
    request.fields['day'] = jsonEncode(getTrueDay());
    request.fields['times'] = jsonEncode(getTruetime());
    http.Response response =
        await http.Response.fromStream(await request.send());
  }

  List getTrueDay() {
    List<String> trueList = List.empty(growable: true);
    for (var item in items) {
      if (item.isChecked) {
        trueList.add(item.data);
      }
    }
    return trueList;
  }

  List getTruetime() {
    List<String> trueList = List.empty(growable: true);
    for (var time in times) {
      trueList.add(time.time);
    }
    return trueList;
  }

  bool checkValidate() {
    if (times.isEmpty) return false;
    if (getTrueDay().isEmpty) return false;
    if ('$_textEditingController'.isEmpty) return false;
    return true;
  }
}
