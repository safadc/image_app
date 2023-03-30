import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_app/controller/image_controller.dart';
import 'package:image_app/helper/app_colors.dart';
import 'package:image_app/pages/gallery_page.dart';
import 'package:image_app/widgets/custom_button.dart';
import 'package:image_app/widgets/field_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ImageController();
  final folderNameController = TextEditingController();

  @override
  void dispose() {
    folderNameController.dispose();
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
                  "safad",
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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: StreamBuilder(
              stream: controller.folderStream,
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshots.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }
                List<DocumentSnapshot> data = (snapshots.data! as QuerySnapshot).docs;
                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (c, i) {
                    final folder = data[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return GalleryPage(
                            folder: folder,
                            controller: controller,
                          );
                        }));
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.folder,
                            color: AppColor.folder,
                            size: 80,
                          ),
                          Text(
                            folder['name'],
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${folder['images'].length} Files",
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (c) {
                return Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Add new folder",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 45,
                          child: FieldWidget(
                            controller: folderNameController,
                            filledColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.5,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Button(
                          onTap: () async {
                            Map<String, dynamic> map = {
                              "name": folderNameController.text,
                              "images": <String>[],
                              "datetime": DateTime.now().toIso8601String(),
                            };
                            controller.isAddingFolder = true;
                            setState(() {});
                            await controller.createFolder(map);
                            setState(() {});
                            if (!mounted) return;
                            folderNameController.clear();
                            Navigator.pop(context);
                          },
                          isLoading: controller.isAddingFolder,
                          height: 40,
                          width: 90,
                          color: Colors.green,
                          name: "Save",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: AppColor.green,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
