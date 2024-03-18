import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee/coffee_state.dart';
import 'package:coffee_shop/data/models/product/product_field_keys.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/ui/widgets/image_uploader.dart';
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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            onTap: () {
              showBottomSheetDialog(context);
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              height: 350.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: state.productModel.image.isEmpty
                  ? const Center(child: Text('Choosing a product picture'))
                  : Image.network(state.productModel.image, fit: BoxFit.fill),
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Colors.white,
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
                ),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
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
        context.read<ProductBloc>().add(UpdateCurrentProductEvent(
            fieldKey: ProductFieldKeys.image, value: data.data));
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
        context.read<ProductBloc>().add(UpdateCurrentProductEvent(
            fieldKey: ProductFieldKeys.image, value: data.data));
        Navigator.pop(context);
      }
    }
  }
}
