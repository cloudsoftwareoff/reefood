import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {

  final DropListModel dropListModel;
  const DropDown({
    required this.dropListModel,
    super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  OptionItem optionItemSelected = OptionItem(title: "Select a Gouvernat");
  @override
  Widget build(BuildContext context) {
    return  SelectDropList(
              itemSelected:optionItemSelected,
              dropListModel: widget.dropListModel,
              showIcon: true,     // Show Icon in DropDown Title
              showArrowIcon: true,     // Show Arrow Icon in DropDown
              showBorder: true,
              paddingTop: 0,
              icon: const Icon(Icons.location_city,color: Colors.black),
              onOptionSelected:(optionItem){
                optionItemSelected = optionItem;
                setState(() {});
              },
            );
  }
}