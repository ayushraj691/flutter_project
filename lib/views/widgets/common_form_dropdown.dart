import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';

class CommonFormDropdown extends StatefulWidget {
  List<String> items;
  String? hintText;
  void Function(String?)? onChanged;
  String? value;
  String? searchHintText;
  TextEditingController? searchController;
  FocusNode? focusNode;

  // void Function()? onTap;
  bool isActive;
  bool show;

  CommonFormDropdown({
    Key? key,
    required this.items,
    this.hintText,
    this.onChanged,
    this.value,
    this.searchController,
    this.searchHintText,
    this.focusNode,
    // this.onTap,
    this.isActive = true,
    this.show = true,
  }) : super(key: key);

  @override
  State<CommonFormDropdown> createState() => _CommonFormDropdownState();
}

class _CommonFormDropdownState extends State<CommonFormDropdown> {
  @override
  Widget build(BuildContext context) {
    return (widget.show)
        ? Container(
            // decoration: MyDecoration.decoration(
            //   10.0,
            //   2.0,
            //   AppColors.appWhiteColor,
            //   AppColors.appWhiteColor,
            //   AppColors.appBlueColor,
            // ),
            child: DropdownButtonHideUnderline(
              child: AbsorbPointer(
                absorbing: !widget.isActive,
                child: DropdownButton2<String>(
                  alignment: Alignment.centerLeft,
                  // isDense: true,

                  // buttonStyleData: ButtonStyleData(
                  //   decoration: BoxDecoration(
                  //     color: (widget.isActive) ? AppColors.appBlackColor : Colors.grey,
                  //   ),
                  //   // overlayColor: (widget.isActive)
                  //   //     ? MaterialStatePropertyAll(AppColors.appBlackColor)
                  //   //     : MaterialStatePropertyAll(Colors.grey),
                  // ),
                  focusNode: widget.focusNode,
                  isExpanded: true,
                  hint:
                      (widget.hintText != null) ? Text(widget.hintText!) : null,
                  value: widget.value,
                  items: widget.items
                      .toSet()
                      .toList()
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              color: (widget.isActive)
                                  ? AppColors.appBlackColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: widget.onChanged,
                  // onTap: widget.onTap,
                  dropdownSearchData: (widget.searchController != null)
                      ? DropdownSearchData(
                          searchController: widget.searchController,
                          searchInnerWidgetHeight: 50,
                          searchMatchFn: (item, searchValue) {
                            final myItem = widget.items.firstWhere(
                              (element) =>
                                  element.toLowerCase() ==
                                  item.value?.toLowerCase(),
                            );
                            return myItem
                                .toLowerCase()
                                .contains(searchValue.toLowerCase());
                          },
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: widget.searchController,
                              decoration: InputDecoration(
                                hintText: widget.searchHintText,
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: AppColors.appBlueColor,
                                  size: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      // color: MyColors.textFieldBackgroundColor,
                                      ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      // color: MyColors.textFieldBackgroundColor,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                  onMenuStateChange: (isOpen) {
                    widget.searchController?.clear();
                  },
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
