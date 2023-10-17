import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee/coffee_state.dart';
import 'package:coffee_shop/data/models/coffee/coffee_field_keys.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/ui/widgets/image_uploader.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/dialogs/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            onTap: () {
              showBottomSheetDialog(context);
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white10,
              ),
              child: state.coffeeModel.image.isEmpty
                  ? const Center(
                      child: Text(
                        'Choosing a coffee picture',
                        style: TextStyle(color: AppColors.white),
                      ),
                    )
                  : Image.network(state.coffeeModel.image, fit: BoxFit.fill),
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera(context);
                },
                leading: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                title: const Text(
                  "Select from Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery(context);
                },
                leading: const Icon(
                  Icons.photo,
                  color: Colors.white,
                ),
                title: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (context.mounted && xFile != null) {
      showLoading(context: context);
      UniversalData data = await imageUploader(xFile);
      if (context.mounted) {
        hideLoading(context: context);
        context.read<CoffeeBloc>().add(UpdateCurrentCoffeeEvent(
            fieldKey: CoffeeFieldKeys.image, value: data.data));
        Navigator.pop(context);
      }
    }
  }

  Future<void> _getFromGallery(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (context.mounted && xFile != null) {
      showLoading(context: context);
      UniversalData data = await imageUploader(xFile);
      if (context.mounted) {
        hideLoading(context: context);
        context.read<CoffeeBloc>().add(UpdateCurrentCoffeeEvent(
            fieldKey: CoffeeFieldKeys.image, value: data.data));
        Navigator.pop(context);
      }
    }
  }
}
