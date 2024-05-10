import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/models/story/upload_story_request_model.dart';
import 'package:story_app/presentation/bloc/story/upload/upload_story_bloc.dart';
import 'package:story_app/presentation/bloc/story/upload/upload_story_state.dart';
import 'package:story_app/presentation/widgets/button_global_widget.dart';
import 'package:story_app/utils/constant/color_constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/image_picker_constant.dart';
import '../../../../utils/constant/name_routes.dart';
import '../../../bloc/story/upload/upload_story_event.dart';
import '../../../widgets/show_dialog_widget.dart';

class UploadStoryScreen extends StatefulWidget {
  const UploadStoryScreen({super.key});

  @override
  State<UploadStoryScreen> createState() => _UploadStoryScreenState();
}

class _UploadStoryScreenState extends State<UploadStoryScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  var checkValue = false;
  XFile? xFile;
  double? lat;
  double? lon;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void _handleCheckboxValueChanged(bool? value) async {
    if (value != null) {
      setState(() {
        checkValue = value;
      });

      if (value) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ShowDialogWidget.showErrorDialog(
            context: context.mounted ? context : context,
            title: 'Location Permission Denied',
            message: 'Please enable location permission to use this feature.',
          );
        } else {
          try {
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            setState(() {
              lat = position.latitude;
              lon = position.longitude;
            });
          } catch (e) {
            ShowDialogWidget.showErrorDialog(
              context: context.mounted ? context : context,
              title: 'Location Retrieval Error',
              message: 'Failed to retrieve location. Please try again later.',
            );
          }
        }
      } else {
        setState(() {
          lat = null;
          lon = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Story',
          style: TextStyle(fontFamily: 'BriemHand'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pushReplacementNamed(
              context, NameRoutes.navigationPageRoute),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.black,
                child: Align(
                  alignment: Alignment.center,
                  child: xFile?.path != null
                      ? Image.file(
                          File(xFile?.path ?? ""),
                          fit: BoxFit.fill,
                        )
                      : const Icon(
                          color: Colors.white,
                          Icons.image,
                          size: 100,
                        ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: ColorConstant.onPrimaryColor,
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Select Image"),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () async {
                              final result = await ImagePickerConstant
                                  .openCameraGalleryGlobal(
                                isCamera: false,
                              );

                              if (result != null) {
                                xFile = result;
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.image_outlined,
                              size: 24,
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            onPressed: () async {
                              final result = await ImagePickerConstant
                                  .openCameraGalleryGlobal(
                                isCamera: true,
                              );

                              if (result != null) {
                                xFile = result;
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 24,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Write a caption',
                  hintText: 'Enter your caption',
                  border: InputBorder.none,
                ),
                controller: _descriptionController,
                maxLines: null,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              height: 1,
              color: ColorConstant.onPrimaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text("Add Location")
                    ],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: checkValue,
                        onChanged: (value) {
                          setState(() {
                            checkValue = value ?? false;
                            _handleCheckboxValueChanged(checkValue);
                          });
                        },
                      )
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocConsumer<UploadStoryBloc, UploadStoryState>(
                  listener: (context, state) {
                    if (state is UploadStorySuccess) {
                      Navigator.pushReplacementNamed(
                          context, NameRoutes.navigationPageRoute);
                    } else if (state is UploadStoryFailure) {
                      ShowDialogWidget.showErrorDialog(
                        context: context,
                        title: 'Upload Story Failed',
                        message: state.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UploadStoryLoading) {
                      return const ButtonGlobalWidget(
                        title: SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return ButtonGlobalWidget(
                        title: const Text("Upload"),
                        onTap: () {
                          final description = _descriptionController.text;
                          final latitude = lat;
                          final longitude = lon;

                          if (xFile != null) {
                            if (description.isNotEmpty) {
                              if (checkValue == true) {
                                final upload = UploadStoryRequestModel(
                                  description: description,
                                  photo: File(xFile!.path),
                                  lat: latitude,
                                  lon: longitude,
                                );
                                context
                                    .read<UploadStoryBloc>()
                                    .add(UploadStoryButtonPressed(upload));
                              } else {
                                ShowDialogWidget.showErrorDialog(
                                  context: context,
                                  title: 'Validation Error',
                                  message: "You must add Location",
                                );
                              }
                            } else {
                              ShowDialogWidget.showErrorDialog(
                                context: context,
                                title: 'Validation Error',
                                message: "Description cannot be empty",
                              );
                            }
                          } else {
                            ShowDialogWidget.showErrorDialog(
                              context: context,
                              title: 'Validation Error',
                              message: "Image cannot be empty",
                            );
                          }
                        },
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
