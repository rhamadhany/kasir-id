import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:kasir_id/app/routes/app_pages.dart';

class HalamanAdminView extends GetView {
  const HalamanAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.25,
        horizontal: Get.width * 0.05,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              CustomIcon(
                icons: FlutterIcons.basket_fill_mco,
                label: 'Tambah Produk',
                onTap: () {
                  Get.toNamed(Routes.PRODUK_BARU);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final IconData icons;
  final String label;
  final Color? fouregroundColor;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Function()? onTap;

  const CustomIcon({
    super.key,
    required this.icons,
    this.fouregroundColor,
    this.foregroundColor,
    this.backgroundColor,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          highlightColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Icon(icons, color: foregroundColor ?? Colors.white),
                SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: foregroundColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
