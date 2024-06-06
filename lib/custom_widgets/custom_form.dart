import 'package:flutter/material.dart';
import 'package:tax/constants/colors.dart';
import 'package:tax/custom_widgets/textFormField.dart';
import 'package:tax/custom_widgets/textFormFieldwithValidator.dart';

class AddTaxDecDataForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController tdNumberController;
  final TextEditingController propertyIdController;
  final TextEditingController arpNo;
  final TextEditingController ownerController;
  final TextEditingController ownerTinController;
  final TextEditingController ownerAddressController;
  final TextEditingController ownerTelNumberController;
  final TextEditingController beneficialUser;
  final TextEditingController beneficialUserTin;
  final TextEditingController beneficialUserAddress;
  final TextEditingController beneficialUserTelNumber;
  final TextEditingController streeNumber;
  final TextEditingController octNumber;
  final TextEditingController surveyNumber;
  final TextEditingController cctNumber;
  final TextEditingController lotNumber;
  final TextEditingController dated;
  final TextEditingController blkNumber;
  final TextEditingController northBoundary;
  final TextEditingController southBoundary;
  final TextEditingController eastBoundary;
  final TextEditingController westBoundary;
  final TextEditingController numberOfStoreys;
  final TextEditingController briefDescription;
  final TextEditingController specification;
  final String? selectedBarangay;
  final String? selectedPropertyType;
  final Function(String?) onSelectedPropertyType;
  final void Function() onSubmit;
  final bool isEditing;

  const AddTaxDecDataForm({
    super.key,
    required this.formKey,
    required this.tdNumberController,
    required this.propertyIdController,
    required this.arpNo,
    required this.ownerController,
    required this.ownerTinController,
    required this.onSubmit,
    required this.ownerAddressController,
    required this.ownerTelNumberController,
    required this.beneficialUser,
    required this.beneficialUserTin,
    required this.beneficialUserAddress,
    required this.beneficialUserTelNumber,
    required this.streeNumber,
    required this.octNumber,
    required this.surveyNumber,
    required this.cctNumber,
    required this.lotNumber,
    required this.dated,
    required this.blkNumber,
    required this.northBoundary,
    required this.southBoundary,
    required this.eastBoundary,
    required this.westBoundary,
    this.selectedBarangay,
    this.selectedPropertyType,
    required this.onSelectedPropertyType,
    required this.numberOfStoreys,
    required this.briefDescription,
    required this.specification,
    required this.isEditing,
  });

  @override
  State<AddTaxDecDataForm> createState() => _AddTaxDecDataFormState();
}

class _AddTaxDecDataFormState extends State<AddTaxDecDataForm> {
  String? _selectedBarangay;
  String? _selectedPropertyType;

  @override
  void initState() {
    super.initState();
    _selectedBarangay = widget.selectedBarangay;
    _selectedPropertyType = widget.selectedPropertyType;
  }

  // Function to handle radio value change
  void _handleRadioValueChange(String? value) {
    setState(() {
      setState(() {
        _selectedPropertyType = value;
      });
      widget.onSelectedPropertyType(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditing ? "Edit" : "Add"),
      content: SizedBox(
        width: 800,
        height: 1000,
        child: Form(
          key: widget.formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFieldWithValidator(
                        isNumberField: false,
                        labelText: "TD No.",
                        controller: widget.tdNumberController,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormFieldWithValidator(
                        isNumberField: false,
                        labelText: "Property Identification No.",
                        controller: widget.propertyIdController,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Arp No.",
                        controller: widget.arpNo,
                        isNumberField: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFieldWithValidator(
                        isNumberField: false,
                        labelText: "Owner",
                        controller: widget.ownerController,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "TIN",
                        controller: widget.ownerTinController,
                        isNumberField: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFieldWithValidator(
                        isNumberField: false,
                        labelText: "Address",
                        controller: widget.ownerAddressController,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: false,
                        labelText: "Tel No.",
                        controller: widget.ownerTelNumberController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: false,
                        labelText: "Administrator/Beneficial User",
                        controller: widget.beneficialUser,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: false,
                        labelText: "TIN",
                        controller: widget.beneficialUserTin,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: false,
                        labelText: "Address",
                        controller: widget.beneficialUserAddress,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: false,
                        labelText: "Tel No.",
                        controller: widget.beneficialUserTelNumber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "PROPERTY LOCATION",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              labelText: "Street No.",
                              controller: widget.streeNumber,
                              isNumberField: true,
                            ),
                          ]),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                      readOnly: true,
                      initialValue: "$_selectedBarangay, Daanbantayan, Cebu",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: borderColor, width: 1),
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: true,
                        labelText: "Blk No.",
                        controller: widget.blkNumber,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: true,
                        labelText: "OCT/TCT/CLOA No.",
                        controller: widget.octNumber,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: true,
                        labelText: "Survey No.",
                        controller: widget.surveyNumber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: true,
                        labelText: "CCT",
                        controller: widget.cctNumber,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: true,
                        labelText: "Lot No.",
                        controller: widget.lotNumber,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        isNumberField: false,
                        labelText: "Dated",
                        controller: widget.dated,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "KIND OF PROPERTY",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          groupValue: _selectedPropertyType,
                          value: 'Building',
                          onChanged: (value) => _handleRadioValueChange(value),
                        ),
                        const Text('Building'),
                        const SizedBox(
                          width: 20,
                        ),
                        Radio<String>(
                          value: 'Land',
                          groupValue: _selectedPropertyType,
                          onChanged: (value) => _handleRadioValueChange(value),
                        ),
                        const Text('Land'),
                        const SizedBox(
                          width: 20,
                        ),
                        Radio<String>(
                          value: 'Machinery',
                          groupValue: _selectedPropertyType,
                          onChanged: (value) => _handleRadioValueChange(value),
                        ),
                        const Text('Machinery'),
                        const SizedBox(
                          width: 20,
                        ),
                        Radio<String>(
                          value: 'Others',
                          groupValue: _selectedPropertyType,
                          onChanged: (value) => _handleRadioValueChange(value),
                        ),
                        const Text('Others'),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_selectedPropertyType == "Building") ...[
                  CustomTextFormFieldWithValidator(
                      isNumberField: true,
                      labelText: "No. of Storeys (e.g. 1 or 2)",
                      controller: widget.numberOfStoreys),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFieldWithValidator(
                      isNumberField: false,
                      labelText: "Brief Description",
                      controller: widget.briefDescription)
                ] else if (_selectedPropertyType == "Machinery") ...[
                  CustomTextFormFieldWithValidator(
                      isNumberField: false,
                      labelText: "Brief Description",
                      controller: widget.briefDescription)
                ] else if (_selectedPropertyType == "Others") ...[
                  CustomTextFormFieldWithValidator(
                      isNumberField: false,
                      labelText: "Specify",
                      controller: widget.specification)
                ] else if (_selectedPropertyType == "Land") ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "BOUNDARIES",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              isNumberField: false,
                              labelText: "North",
                              controller: widget.northBoundary,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomTextFormField(
                              isNumberField: false,
                              labelText: "South",
                              controller: widget.southBoundary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              isNumberField: false,
                              labelText: "East",
                              controller: widget.eastBoundary,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomTextFormField(
                              isNumberField: false,
                              labelText: "West",
                              controller: widget.westBoundary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (widget.formKey.currentState?.validate() == true) {
              widget.onSubmit();
            }
          },
          child: Text(widget.isEditing ? "Save" : "Add"),
        ),
      ],
    );
  }
}
