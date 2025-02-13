import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/home_controller.dart';

class SearchMap extends StatelessWidget {
  SearchMap({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: AppColors.black,
        resizeToAvoidBottomInset: true,
        body: Obx(() {
          return SafeArea(
            child: FlutterMap(
              mapController: MapController(),
              options: MapOptions(
                initialCenter: LatLng(
                  controller.pos.value!.latitude,
                  controller.pos.value!.longitude,
                ),
              ),
              children: [
                //openStreetMapTileLayer,
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        controller.pos.value!.latitude,
                        controller.pos.value!.longitude,
                      ),
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: context.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(223),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(30.r),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          clipBehavior: Clip.hardEdge,
                          controller: controller.search,
                          onTap: () {
                            controller.showRecent.value = false;
                          },
                          onChanged: (val) {
                            controller.searching(controller.search.text);
                          },
                          onSubmitted: (value) {
                            controller.pos.value =
                                controller.searchQuery.first.position;
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            label: Text(
                              "Search Here",
                              style: ts.bodyMedium,
                            ),
                            prefixIcon: IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.chevron_left_rounded,
                                color: Colors.black,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            isCollapsed: true,
                            isDense: true,
                          ),
                        ),
                        if (controller.showRecent.isTrue ||
                            controller.searchQuery.isEmpty) ...[
                          SizedBox(height: 32.h),
                          Text(
                            "Recent Search",
                            style: ts.titleSmall,
                          ),
                          SizedBox(height: 16.h),
                          controller.recent.isNotEmpty
                              ? Column(
                                  children: List.generate(
                                    2,
                                    (int i) {
                                      return ListTile(
                                        leading: Icon(Icons.history),
                                        title: Text(
                                          controller.recent[i],
                                          style: ts.titleSmall,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : ListTile(
                                  title: Text(
                                    "No Recent Search",
                                    style: ts.labelMedium,
                                  ),
                                ),
                        ] else
                          Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Column(
                              children: List.generate(
                                controller.searchQuery.length,
                                (int i) {
                                  return ListTile(
                                    leading: Icon(Icons.location_city),
                                    title: Text(
                                      controller.searchQuery[i].name,
                                      style: ts.titleSmall,
                                    ),
                                    onTap: () {
                                      controller.city.value =
                                          controller.searchQuery[i];
                                      controller.search.clear();
                                      controller.searchQuery.clear();
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(32.h),
                    child: FloatingActionButton(
                      onPressed: () {
                        controller.searsching("sama");
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
