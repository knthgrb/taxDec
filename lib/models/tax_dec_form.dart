class TaxDecForm {
  String tdNumber = "";
  String propertyIdNo = "";
  String? arpNo = "";
  String owner = "";
  String? ownerTIN = "";
  String ownerAddress = "";
  String? ownerTelNumber = "";
  String? beneficialUser = "";
  String? beneficialTIN = "";
  String? benefecialAddress = "";
  int? streetNo;
  String? beneficialTelNumber = "";
  String barangayDistrict = "";
  String municipality = "";
  String province = "";
  int? octNo;
  int? surveyNo;
  int? cctNo;
  int? lotNo;
  String? dated = "";
  int? blkNo;
  String? northBoundary = "";
  String? southBoundary = "";
  String? eastBoundary = "";
  String? westBoundary = "";
  String propertyType = "";
  String? briefDescription = "";
  String? specification = "";
  int? noOfStoreys;

  TaxDecForm(
      {required this.tdNumber,
      required this.propertyIdNo,
      this.arpNo,
      required this.owner,
      this.ownerTIN,
      required this.ownerAddress,
      this.ownerTelNumber,
      this.beneficialUser,
      this.beneficialTIN,
      this.benefecialAddress,
      this.streetNo,
      this.beneficialTelNumber,
      required this.barangayDistrict,
      required this.municipality,
      required this.province,
      this.octNo,
      this.cctNo,
      this.lotNo,
      this.dated,
      this.blkNo,
      this.northBoundary,
      this.southBoundary,
      this.eastBoundary,
      this.westBoundary,
      required this.propertyType,
      this.briefDescription,
      this.specification,
      this.noOfStoreys});
}
