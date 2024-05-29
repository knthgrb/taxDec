class TaxDecForm {
  String tdNumber = "";
  String propertyIdNo = "";
  String? arpNo = "";
  String owner = "";
  String? ownerTinNo = "";
  String ownerAddress = "";
  String? ownerTelNumber = "";
  String? beneficialUser = "";
  String? beneficialTinNo = "";
  String? benefecialAddress = "";
  int? streetNo;
  String? beneficialTelNumber = "";
  String barangayDistrict = "";
  String municipality = "";
  String province = "";
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
  int? noOfStoreys;

  TaxDecForm(
      {required this.tdNumber,
      required this.propertyIdNo,
      this.arpNo,
      required this.owner,
      this.ownerTinNo,
      required this.ownerAddress,
      this.ownerTelNumber,
      this.beneficialUser,
      this.beneficialTinNo,
      this.benefecialAddress,
      this.streetNo,
      this.beneficialTelNumber,
      required this.barangayDistrict,
      required this.municipality,
      required this.province,
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
      this.noOfStoreys});
}
