// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tax/constants/colors.dart';
import 'package:tax/constants/data/barangay.dart';
import 'package:tax/custom_widgets/custom_form.dart';
import 'package:tax/main.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:tax/services/pdf_format.dart';
import 'package:tax/services/pdf_service.dart';
import 'package:tax/utils/error_dialog.dart';
import 'package:tax/utils/error_messages.dart';

class MainBody extends StatefulWidget {
  final int selectedBarangayIndex;

  const MainBody({super.key, required this.selectedBarangayIndex});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _tdNumberController = TextEditingController();
  final TextEditingController _propertyIdController = TextEditingController();
  final TextEditingController _arpNo = TextEditingController();
  final TextEditingController _owner = TextEditingController();
  final TextEditingController _ownerTin = TextEditingController();
  final TextEditingController _ownerAddress = TextEditingController();
  final TextEditingController _ownerTelNumber = TextEditingController();
  final TextEditingController _beneficialUser = TextEditingController();
  final TextEditingController _beneficialUserTin = TextEditingController();
  final TextEditingController _beneficialUserAddress = TextEditingController();
  final TextEditingController _beneficialUserTelNumber =
      TextEditingController();
  final TextEditingController _streetNumber = TextEditingController();
  final TextEditingController _cctNo = TextEditingController();
  final TextEditingController _surveyNo = TextEditingController();
  final TextEditingController _octNo = TextEditingController();
  final TextEditingController _lotNo = TextEditingController();
  final TextEditingController _dated = TextEditingController();
  final TextEditingController _blkNo = TextEditingController();
  final TextEditingController _northBoundary = TextEditingController();
  final TextEditingController _southBoundary = TextEditingController();
  final TextEditingController _eastBoundary = TextEditingController();
  final TextEditingController _westBoundary = TextEditingController();
  final TextEditingController _noOfStoreys = TextEditingController();
  final TextEditingController _briefDescription = TextEditingController();
  final TextEditingController _specification = TextEditingController();

  String? _selectedPropertyType = "Building";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didUpdateWidget(MainBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedBarangayIndex != oldWidget.selectedBarangayIndex) {
      _fetchData();
    }
  }

  // Function to fetch data from DB
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final barangayName = barangays[widget.selectedBarangayIndex].barangayName;
      final data = await supabase
          .from('tax_declaration_data')
          .select()
          .eq('barangayDistrict', barangayName);

      setState(() {
        _data = data.toList();
        _filteredData = _data;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Function for seach functionality
  void _searchData(String query) {
    setState(() {
      _filteredData = _data.where((item) {
        final tdNumber = item['tdNumber'].toString().toLowerCase();
        final owner = item['owner'].toString().toLowerCase();
        final propertyIdNo = item['propertyIdNo'].toString().toLowerCase();
        final propertyType = item['propertyType'].toString().toLowerCase();
        return tdNumber.startsWith(query) ||
            owner.startsWith(query) ||
            propertyIdNo.startsWith(query) ||
            propertyType.startsWith(query);
      }).toList();
    });
  }

  // Function to add data to database
  Future<void> _addDataToDatabase() async {
    final barangayName = barangays[widget.selectedBarangayIndex].barangayName;

    final payload = {
      'tdNumber': _tdNumberController.text,
      'propertyIdNo': _propertyIdController.text,
      'arpNo': _arpNo.text.isNotEmpty ? _arpNo.text : "",
      'owner': _owner.text,
      'ownerTIN': _ownerTin.text.isNotEmpty ? _ownerTin.text : "",
      'ownerAddress': _ownerAddress.text,
      'ownerTelNumber':
          _ownerTelNumber.text.isNotEmpty ? _ownerTelNumber.text : "",
      'beneficialUser':
          _beneficialUser.text.isNotEmpty ? _beneficialUser.text : "",
      'beneficialTIN':
          _beneficialUserTin.text.isNotEmpty ? _beneficialUserTin.text : "",
      'beneficialAddress': _beneficialUserAddress.text.isNotEmpty
          ? _beneficialUserAddress.text
          : "",
      'beneficialTelNumber': _beneficialUserTelNumber.text.isNotEmpty
          ? _beneficialUserTelNumber.text
          : "",
      'streetNo':
          _streetNumber.text.isNotEmpty ? int.parse(_streetNumber.text) : null,
      'barangayDistrict': barangayName,
      'municipality': "Daanbantayan",
      'province': "Cebu",
      'octNo': _octNo.text.isNotEmpty ? int.parse(_octNo.text) : null,
      'surveyNo': _surveyNo.text.isNotEmpty ? int.parse(_surveyNo.text) : null,
      'cctNo': _cctNo.text.isNotEmpty ? int.parse(_cctNo.text) : null,
      'lotNo': _lotNo.text.isNotEmpty ? int.parse(_lotNo.text) : null,
      'dated': _dated.text.isNotEmpty ? _dated.text : "",
      'blkNo': _blkNo.text.isNotEmpty ? int.parse(_blkNo.text) : null,
      'northBoundary':
          _northBoundary.text.isNotEmpty ? _northBoundary.text : "",
      'southBoundary':
          _southBoundary.text.isNotEmpty ? _southBoundary.text : "",
      'eastBoundary': _eastBoundary.text.isNotEmpty ? _eastBoundary.text : "",
      'westBoundary': _westBoundary.text.isNotEmpty ? _westBoundary.text : "",
      'propertyType': _selectedPropertyType,
      'noOfStoreys':
          _noOfStoreys.text.isNotEmpty ? int.tryParse(_noOfStoreys.text) : null,
      'briefDescription':
          _briefDescription.text.isNotEmpty ? _briefDescription.text : "",
      'specification': _specification.text.isNotEmpty ? _specification.text : ""
    };

    try {
      await supabase.from('tax_declaration_data').insert(payload).select();
      Navigator.of(context).pop(); // Close the dialog
      _fetchData();
    } catch (error) {
      String errorMessage = "";
      String subMessage = "";
      if (error.toString().contains(
          'duplicate key value violates unique constraint "tax_declaration_data_td_number_key"')) {
        errorMessage = ErrorMessages.duplicateTDNumber;
        subMessage = "Please choose a different one and try again.";
      } else if (error.toString().contains(
          'duplicate key value violates unique constraint "tax_declaration_data_property_id_no_key"')) {
        errorMessage = ErrorMessages.duplicatePropertyID;
        subMessage = "Please choose a different one and try again.";
      } else if (error
          .toString()
          .contains('null value in column "propertyType"')) {
        errorMessage = ErrorMessages.nullPropertyType;
        subMessage = "Please select one and try again.";
      } else {
        errorMessage = ErrorMessages.genericError;
      }
      showErrorDialog(context, errorMessage, subMessage);
      if (kDebugMode) {
        print("error $error");
      }
    }
  }

  // Function to update an item in the database
  Future<void> _updateDataInDB(id) async {
    final barangayName = barangays[widget.selectedBarangayIndex].barangayName;

    final payload = {
      'tdNumber': _tdNumberController.text,
      'propertyIdNo': _propertyIdController.text,
      'arpNo': _arpNo.text.isNotEmpty ? _arpNo.text : "",
      'owner': _owner.text,
      'ownerTIN': _ownerTin.text.isNotEmpty ? _ownerTin.text : "",
      'ownerAddress': _ownerAddress.text,
      'ownerTelNumber':
          _ownerTelNumber.text.isNotEmpty ? _ownerTelNumber.text : "",
      'beneficialUser':
          _beneficialUser.text.isNotEmpty ? _beneficialUser.text : "",
      'beneficialTIN':
          _beneficialUserTin.text.isNotEmpty ? _beneficialUserTin.text : "",
      'beneficialAddress': _beneficialUserAddress.text.isNotEmpty
          ? _beneficialUserAddress.text
          : "",
      'beneficialTelNumber': _beneficialUserTelNumber.text.isNotEmpty
          ? _beneficialUserTelNumber.text
          : "",
      'streetNo':
          _streetNumber.text.isNotEmpty ? int.parse(_streetNumber.text) : null,
      'barangayDistrict': barangayName,
      'municipality': "Daanbantayan",
      'province': "Cebu",
      'octNo': _octNo.text.isNotEmpty ? int.parse(_octNo.text) : null,
      'surveyNo': _surveyNo.text.isNotEmpty ? int.parse(_surveyNo.text) : null,
      'cctNo': _cctNo.text.isNotEmpty ? int.parse(_cctNo.text) : null,
      'lotNo': _lotNo.text.isNotEmpty ? int.parse(_lotNo.text) : null,
      'dated': _dated.text.isNotEmpty ? _dated.text : "",
      'blkNo': _blkNo.text.isNotEmpty ? int.parse(_blkNo.text) : null,
      'northBoundary':
          _northBoundary.text.isNotEmpty ? _northBoundary.text : "",
      'southBoundary':
          _southBoundary.text.isNotEmpty ? _southBoundary.text : "",
      'eastBoundary': _eastBoundary.text.isNotEmpty ? _eastBoundary.text : "",
      'westBoundary': _westBoundary.text.isNotEmpty ? _westBoundary.text : "",
      'propertyType': _selectedPropertyType,
      'noOfStoreys':
          _noOfStoreys.text.isNotEmpty ? int.tryParse(_noOfStoreys.text) : null,
      'briefDescription':
          _briefDescription.text.isNotEmpty ? _briefDescription.text : "",
      'specification': _specification.text.isNotEmpty ? _specification.text : ""
    };

    try {
      await supabase
          .from('tax_declaration_data')
          .update(payload)
          .eq('id', id)
          .select();
      Navigator.of(context).pop(); // Close the dialog
      _fetchData();
    } catch (error) {
      String errorMessage = "";
      String subMessage = "";
      if (error.toString().contains(
          'duplicate key value violates unique constraint "tax_declaration_data_td_number_key"')) {
        errorMessage = ErrorMessages.duplicateTDNumber;
        subMessage = "Please choose a different one and try again.";
      } else if (error.toString().contains(
          'duplicate key value violates unique constraint "tax_declaration_data_property_id_no_key"')) {
        errorMessage = ErrorMessages.duplicatePropertyID;
        subMessage = "Please choose a different one and try again.";
      } else if (error
          .toString()
          .contains('null value in column "propertyType"')) {
        errorMessage = ErrorMessages.nullPropertyType;
        subMessage = "Please select one and try again.";
      } else {
        errorMessage = ErrorMessages.genericError;
      }
      showErrorDialog(context, errorMessage, subMessage);
      if (kDebugMode) {
        print("error $error");
      }
    }
  }

  // Function to delete an item
  Future<void> _deleteItem(id) async {
    try {
      await supabase.from('tax_declaration_data').delete().eq('id', id);
      _fetchData();
    } catch (error) {
      showErrorDialog(context, error.toString(), "Please try again.");
      if (kDebugMode) {
        print("error $error");
      }
    }
  }

  // Dialog to add tax declaration data
  void _showAddTaxDecDataForm() {
    _clearFormFields();
    showDialog(
        context: context,
        builder: (context) => AddTaxDecDataForm(
              formKey: _formKey,
              isEditing: false,
              tdNumberController: _tdNumberController,
              propertyIdController: _propertyIdController,
              arpNo: _arpNo,
              ownerController: _owner,
              ownerTinController: _ownerTin,
              ownerAddressController: _ownerAddress,
              ownerTelNumberController: _ownerTelNumber,
              beneficialUser: _beneficialUser,
              beneficialUserTin: _beneficialUserTin,
              beneficialUserAddress: _beneficialUserAddress,
              beneficialUserTelNumber: _beneficialUserTelNumber,
              streeNumber: _streetNumber,
              octNumber: _octNo,
              surveyNumber: _surveyNo,
              cctNumber: _cctNo,
              lotNumber: _lotNo,
              dated: _dated,
              blkNumber: _blkNo,
              northBoundary: _northBoundary,
              southBoundary: _southBoundary,
              eastBoundary: _eastBoundary,
              westBoundary: _westBoundary,
              numberOfStoreys: _noOfStoreys,
              briefDescription: _briefDescription,
              specification: _specification,
              selectedBarangay:
                  barangays[widget.selectedBarangayIndex].barangayName,
              selectedPropertyType: _selectedPropertyType,
              onSelectedPropertyType: (String? propertyType) {
                setState(() {
                  _selectedPropertyType = propertyType;
                });
              },
              onSubmit: () => _addDataToDatabase(),
            ));
  }

  void _showEditForm(int id) {
    // Find the data of the selected row
    var selectedData = _data.firstWhere((item) => item['id'] == id);

    // Populate the form fields with the data of the selected row
    _tdNumberController.text = selectedData['tdNumber'].toString();
    _propertyIdController.text = selectedData['propertyIdNo'].toString();
    _arpNo.text = selectedData['arpNo'] ?? '';
    _owner.text = selectedData['owner'].toString();
    _ownerTin.text = selectedData['ownerTIN'] ?? '';
    _ownerAddress.text = selectedData['ownerAddress'].toString();
    _ownerTelNumber.text = selectedData['ownerTelNumber'] ?? '';
    _beneficialUser.text = selectedData['beneficialUser'] ?? '';
    _beneficialUserTin.text = selectedData['beneficialTIN'] ?? '';
    _beneficialUserAddress.text = selectedData['beneficialAddress'] ?? '';
    _beneficialUserTelNumber.text = selectedData['beneficialTelNumber'] ?? '';
    _streetNumber.text = selectedData['streetNo']?.toString() ?? '';
    _octNo.text = selectedData['octNo']?.toString() ?? '';
    _surveyNo.text = selectedData['surveyNo']?.toString() ?? '';
    _cctNo.text = selectedData['cctNo']?.toString() ?? '';
    _lotNo.text = selectedData['lotNo']?.toString() ?? '';
    _dated.text = selectedData['dated'] ?? '';
    _blkNo.text = selectedData['blkNo']?.toString() ?? '';
    _northBoundary.text = selectedData['northBoundary'] ?? '';
    _southBoundary.text = selectedData['southBoundary'] ?? '';
    _eastBoundary.text = selectedData['eastBoundary'] ?? '';
    _westBoundary.text = selectedData['westBoundary'] ?? '';
    _selectedPropertyType = selectedData['propertyType'];
    _noOfStoreys.text = selectedData['noOfStoreys']?.toString() ?? '';
    _briefDescription.text = selectedData['briefDescription'] ?? '';
    _specification.text = selectedData['specification'] ?? '';

    // Open the dialog to edit the data
    showDialog(
      context: context,
      builder: (context) => AddTaxDecDataForm(
        isEditing: true,
        formKey: _formKey,
        tdNumberController: _tdNumberController,
        propertyIdController: _propertyIdController,
        arpNo: _arpNo,
        ownerController: _owner,
        ownerTinController: _ownerTin,
        ownerAddressController: _ownerAddress,
        ownerTelNumberController: _ownerTelNumber,
        beneficialUser: _beneficialUser,
        beneficialUserTin: _beneficialUserTin,
        beneficialUserAddress: _beneficialUserAddress,
        beneficialUserTelNumber: _beneficialUserTelNumber,
        streeNumber: _streetNumber,
        octNumber: _octNo,
        surveyNumber: _surveyNo,
        cctNumber: _cctNo,
        lotNumber: _lotNo,
        dated: _dated,
        blkNumber: _blkNo,
        northBoundary: _northBoundary,
        southBoundary: _southBoundary,
        eastBoundary: _eastBoundary,
        westBoundary: _westBoundary,
        numberOfStoreys: _noOfStoreys,
        briefDescription: _briefDescription,
        specification: _specification,
        selectedBarangay: selectedData['barangayDistrict'].toString(),
        selectedPropertyType: _selectedPropertyType,
        onSelectedPropertyType: (String? propertyType) {
          setState(() {
            _noOfStoreys.clear();
            _briefDescription.clear();
            _specification.clear();
            _northBoundary.clear();
            _southBoundary.clear();
            _eastBoundary.clear();
            _westBoundary.clear();
            _selectedPropertyType = propertyType;
          });
        },
        onSubmit: () => _updateDataInDB(id),
      ),
    );
  }

  // FUNCTION TO GET DATA FROM DB THEN GENERATE PDF
  Future<void> _getDataFromDBandGeneratePDF(int id) async {
    final payload = await supabase
        .from("tax_declaration_data")
        .select()
        .eq('id', id)
        .single();

    final pdfFile = await PdfGenerateForm.generate(payload);

    PdfService.savePdfFile("test", pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    final selectedBarangayName =
        barangays[widget.selectedBarangayIndex].barangayName;
    final double screenWidth = MediaQuery.of(context).size.width;

    final columnSize = MediaQuery.of(context).size.width / 10;

    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(bottom: BorderSide(width: 1, color: borderColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedBarangayName.toUpperCase(),
                  style: TextStyle(
                      letterSpacing: 0,
                      color: darkGrayColor,
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width:
                              screenWidth * 0.25, // Adjust the width as needed
                          child: CupertinoTextField(
                            prefix: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Iconify(
                                Ri.search_line,
                                size: 20,
                                color: lightTextColor,
                              ),
                            ),
                            onChanged: (text) =>
                                _searchData(text.toLowerCase()),
                            cursorHeight: 16,
                            placeholderStyle: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                color: lighterTextColor,
                                overflow: TextOverflow.ellipsis),
                            placeholder: "Search TD No/Property No/Owner/Type",
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        SizedBox(
                          height: 40,
                          child: FilledButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(darkGrayColor),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () => _showAddTaxDecDataForm(),
                              child: const Center(
                                child: Row(
                                  children: [
                                    Iconify(
                                      Lucide.plus,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                      ),
                                    ) // widget
                                  ],
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _filteredData.isEmpty
                    ? const Center(
                        child: Text("No data available"),
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columnSpacing: columnSize * 0.01,
                            dividerThickness: 0,
                            dataTextStyle: const TextStyle(
                              fontFamily: "Inter",
                            ),
                            columns: [
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "TD No.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: darkGrayColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  "Property Id No.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: darkGrayColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  "Owner",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: darkGrayColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  "Property Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: darkGrayColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Actions",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkGrayColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                            rows: _filteredData.map<DataRow>((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Container(
                                      alignment: Alignment.center,
                                      width: columnSize * 1.5,
                                      child: Text(
                                        item['tdNumber'].toString(),
                                        textAlign: TextAlign.center,
                                      ))),
                                  DataCell(Container(
                                    alignment: Alignment.center,
                                    width: columnSize * 1.5,
                                    child: Text(
                                      item['propertyIdNo'].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(Container(
                                      alignment: Alignment.center,
                                      width: columnSize * 1.3,
                                      child: Text(
                                        item['owner'].toString(),
                                        textAlign: TextAlign.center,
                                      ))),
                                  DataCell(Container(
                                    alignment: Alignment.center,
                                    width: columnSize * 1.5,
                                    child:
                                        Text(item['propertyType'].toString()),
                                  )),
                                  DataCell(SizedBox(
                                    width: columnSize * 1.2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        PopupMenuButton<String>(
                                          onSelected: (String value) async {
                                            switch (value) {
                                              case 'edit':
                                                _showEditForm(item['id']);
                                                break;
                                              case 'pdf':
                                                _getDataFromDBandGeneratePDF(
                                                    item['id']);
                                                break;
                                              case 'delete':
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    title: const Text(
                                                        'Confirm Delete'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this record?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          _deleteItem(
                                                              item['id']);
                                                        },
                                                        child: const Text(
                                                            'Delete'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                break;
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'edit',
                                              child: Text('Edit'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'pdf',
                                              child: Text('View Details'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tdNumberController.dispose();
    _propertyIdController.dispose();
    _owner.dispose();
    _ownerTin.dispose();
    _ownerAddress.dispose();
    _ownerTelNumber.dispose();
    _beneficialUser.dispose();
    _beneficialUserTin.dispose();
    _beneficialUserAddress.dispose();
    _beneficialUserTelNumber.dispose();
    _streetNumber.dispose();
    _cctNo.dispose();
    _surveyNo.dispose();
    _octNo.dispose();
    _lotNo.dispose();
    _dated.dispose();
    _blkNo.dispose();
    _northBoundary.dispose();
    _southBoundary.dispose();
    _eastBoundary.dispose();
    _westBoundary.dispose();
    _noOfStoreys.dispose();
    _briefDescription.dispose();
    _specification.dispose();
    super.dispose();
  }

  void _clearFormFields() {
    _tdNumberController.clear();
    _propertyIdController.clear();
    _arpNo.clear();
    _owner.clear();
    _ownerTin.clear();
    _ownerAddress.clear();
    _ownerTelNumber.clear();
    _beneficialUser.clear();
    _beneficialUserTin.clear();
    _beneficialUserAddress.clear();
    _beneficialUserTelNumber.clear();
    _streetNumber.clear();
    _octNo.clear();
    _surveyNo.clear();
    _cctNo.clear();
    _lotNo.clear();
    _dated.clear();
    _blkNo.clear();
    _northBoundary.clear();
    _southBoundary.clear();
    _eastBoundary.clear();
    _westBoundary.clear();
    _noOfStoreys.clear();
    _briefDescription.clear();
    _specification.clear();
  }
}
