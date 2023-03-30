import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_app/controller/image_controller.dart';
import 'package:image_app/helper/app_colors.dart';
import 'package:image_app/widgets/custom_button.dart';
import 'package:image_app/widgets/field_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({
    Key? key,
    required this.folder,
    required this.controller,
  }) : super(key: key);
  final DocumentSnapshot<Object?> folder;
  final ImageController controller;

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  File? file;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 150,
          leading: Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            child: const Text(
              "Photos Gallery",
              style: TextStyle(
                color: AppColor.green,
                fontSize: 15,
              ),
            ),
          ),
          elevation: 1,
          actions: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/profile.jpg",
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Sanem",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "1001",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      XFile? xFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (xFile == null) return;
                      file = File(xFile.path);
                      setState(() {});
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: DottedBorder(
                        strokeWidth: 3,
                        dashPattern: const [
                          10,
                          10,
                          10,
                        ],
                        color: Colors.grey,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: file != null
                            ? Stack(
                                children: [
                                  Image.file(
                                    file!,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        file = null;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 180,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: DottedBorder(
                                      dashPattern: const [
                                        8,
                                        8,
                                        8,
                                      ],
                                      strokeWidth: 3,
                                      color: AppColor.skyBlue,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(60),
                                      child: const SizedBox(
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            "Browse",
                                            style: TextStyle(
                                              color: AppColor.skyBlue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FieldWidget(
                    hint: "Title",
                    controller: titleController,
                    filledColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.6,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FieldWidget(
                    hint: "Description",
                    controller: descriptionController,
                    maxLines: 6,
                    filledColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.6,
                        )),
                  ),
                  const Spacer(),
                  widget.controller.isAddingImage
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Button(
                          onTap: () async {
                            if (file == null) return;
                            widget.controller.isAddingImage = true;
                            setState(() {});
                            await widget.controller.addImage(
                              file!,
                              widget.folder,
                              titleController.text,
                              descriptionController.text,
                            );
                            if (!mounted) return;
                            Navigator.pop(context);
                          },
                          height: 40,
                          width: 120,
                          color: Colors.green,
                          name: "Save",
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
