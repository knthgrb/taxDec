import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerateForm {
  static Future<Uint8List> generate(Map<String, dynamic> data) async {
    // create the pdf document
    final pdf = pw.Document();

    // load image
    final image =
        (await rootBundle.load("assets/images/seal.jpeg")).buffer.asUint8List();

    // load font
    final ovo =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Ovo-Regular.ttf"));
    final secularOne = pw.Font.ttf(
        await rootBundle.load("assets/fonts/SecularOne-Regular.ttf"));

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.legal,
      margin: const pw.EdgeInsets.fromLTRB(
          0.9 * PdfPageFormat.inch,
          0.5 * PdfPageFormat.inch,
          0.9 * PdfPageFormat.inch,
          0.5 * PdfPageFormat.inch),
      build: (pw.Context context) => [buildForm(data, image, ovo, secularOne)],
    ));
    return pdf.save();
  }

  static buildForm(
      Map<String, dynamic> data, Uint8List image, ovo, secularOne) {
    return pw.Column(children: [
      buildHeader(data, image, ovo, secularOne),
      pw.SizedBox(height: 20),
      buildBody(data)
    ]);
  }

  static buildHeader(
      Map<String, dynamic> data, Uint8List image, ovo, secularOne) {
    return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
      pw.Image(pw.MemoryImage(image),
          width: 50, height: 50, fit: pw.BoxFit.cover),
      pw.SizedBox(
        width: 10,
      ),
      pw.Column(children: [
        pw.Text("Republic of the Philippines", style: pw.TextStyle(font: ovo)),
        pw.Text("Province of Cebu",
            style: pw.TextStyle(font: ovo, fontSize: 12)),
        pw.Text("TAX DECLARATION PROPERTY",
            style: pw.TextStyle(font: secularOne))
      ]),
      pw.SizedBox(
        width: 40,
      ),
    ]);
  }

  static buildBody(Map<String, dynamic> data) {
    return pw
        .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(
          children: [
            pw.Text("TD No."),
            pw.SizedBox(width: 5),
            pw.Container(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: 1))),
                child: pw.Text(data['tdNumber']))
          ],
        ),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
          pw.Row(children: [
            pw.Text("Philippine Identification No."),
            pw.SizedBox(width: 5),
            pw.Container(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: 1))),
                child: pw.Text(data['propertyIdNo'])),
          ]),
          pw.SizedBox(
            height: 5,
          ),
          pw.Row(children: [
            pw.Text("Arp No."),
            pw.SizedBox(width: 5),
            pw.Container(
                decoration: pw.BoxDecoration(
                    border: data['arpNo'] != ""
                        ? const pw.Border(bottom: pw.BorderSide(width: 1))
                        : null),
                child: pw.Text(
                    data['arpNo'] != "" ? data['arpNo'] : '_____________'))
          ])
        ])
      ]),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("Owner:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1))),
              child: pw.Text(data['owner'])),
        ]),
        pw.Row(children: [
          pw.Text("TIN:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['ownerTIN'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(
                  data['ownerTIN'] != "" ? data['ownerTIN'] : '_____________')),
        ]),
      ]),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("Address:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1))),
              child: pw.Text(data['ownerAddress'])),
        ]),
        pw.Row(children: [
          pw.Text("Tel No.:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['ownerTelNumber'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['ownerTelNumber'] != ""
                  ? data['ownerTelNumber']
                  : '_____________')),
        ]),
      ]),
      pw.SizedBox(height: 20),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("Administrator/Beneficial User:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['beneficialUser'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['beneficialUser'] != ""
                  ? data['beneficialUser']
                  : '________________________')),
        ]),
        pw.Row(children: [
          pw.Text("TIN:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['beneficialTIN'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['beneficialTIN'] != ""
                  ? data['beneficialTIN']
                  : '_____________')),
        ]),
      ]),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("Address:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['beneficialAddress'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['beneficialAddress'] != ""
                  ? data['beneficialAddress']
                  : '________________________')),
        ]),
        pw.Row(children: [
          pw.Text("Tel No.:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['beneficialTelNumber'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['beneficialTelNumber'] != ""
                  ? data['beneficialTelNumber']
                  : '_____________')),
        ]),
      ]),
      pw.SizedBox(height: 10),
      pw.Row(children: [
        pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [pw.Text("Location of Property:")]),
        pw.Column(children: [
          pw.SizedBox(height: 8),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['streetNo'] != null
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['streetNo'] != null
                  ? data['streetNo'].toString()
                  : '_____________')),
          pw.Text("(Number and Street)",
              style: pw.TextStyle(fontStyle: pw.FontStyle.italic))
        ]),
        pw.SizedBox(width: 10),
        pw.Column(children: [
          pw.SizedBox(height: 8),
          pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1))),
              child: pw.Text(data['barangayDistrict'])),
          pw.Text("(Barangay District)",
              style: pw.TextStyle(fontStyle: pw.FontStyle.italic))
        ]),
        pw.SizedBox(width: 10),
        pw.Column(children: [
          pw.SizedBox(height: 8),
          pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1))),
              child: pw.Text("${data['municipality']}/${data['province']}")),
          pw.Text("(Municipality & Province)",
              style: pw.TextStyle(fontStyle: pw.FontStyle.italic))
        ])
      ]),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("OCT/TCT/CLOA No.:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['octNo'] != null
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['octNo'] != null
                  ? data['octNo'].toString()
                  : '_______________')),
        ]),
        pw.Row(children: [
          pw.Text("Survey No.:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['surveyNo'] != null
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['surveyNo'] != null
                  ? data['surveyNo'].toString()
                  : '_________________')),
        ]),
      ]),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("CCT:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['cctNo'] != null
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['cctNo'] != null
                  ? data['cctNo'].toString()
                  : '____________________________')),
        ]),
        pw.Row(children: [
          pw.Text("Lot No.:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['lotNo'] != null
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['lotNo'] != null
                  ? data['lotNo'].toString()
                  : '_________________')),
        ]),
      ]),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("Dated:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['dated'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['dated'] != ""
                  ? data['dated']
                  : '___________________________')),
        ]),
        pw.Row(children: [
          pw.Text("Blk No.:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['blkNo'] != null
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['blkNo'] != null
                  ? data['blkNo'].toString()
                  : '_________________')),
        ]),
      ]),
      pw.SizedBox(height: 15),
      pw.Text(
        "Boundaries",
      ),
      pw.SizedBox(height: 5),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("North:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['northBoundary'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['northBoundary'] != ""
                  ? data['northBoundary']
                  : '________________________')),
        ]),
        pw.Row(children: [
          pw.Text("South:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['southBoundary'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['southBoundary'] != ""
                  ? data['southBoundary']
                  : '________________________')),
        ]),
      ]),
      pw.SizedBox(height: 5),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Row(children: [
          pw.Text("East:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['eastBoundary'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['eastBoundary'] != ""
                  ? data['eastBoundary']
                  : '________________________')),
        ]),
        pw.Row(children: [
          pw.Text("West:"),
          pw.SizedBox(width: 5),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: data['westBoundary'] != ""
                      ? const pw.Border(bottom: pw.BorderSide(width: 1))
                      : null),
              child: pw.Text(data['westBoundary'] != ""
                  ? data['westBoundary']
                  : '________________________')),
        ]),
      ]),
      pw.SizedBox(height: 15),
      pw.Text("KIND OF PROPERTY ASSESED",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 5),
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(children: [
            pw.Container(
                height: 15,
                width: 15,
                padding: const pw.EdgeInsets.only(left: 5, right: 5),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 1, color: PdfColors.black)),
                child: pw.Center(
                    child: pw.Text(data['propertyType'] == "Land" ? "/" : ""))),
            pw.SizedBox(width: 10),
            pw.Text("LAND"),
          ]),
          pw.SizedBox(height: 30),
          pw.Row(children: [
            pw.Container(
                height: 15,
                width: 15,
                padding: const pw.EdgeInsets.only(left: 5, right: 5),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 1, color: PdfColors.black)),
                child: pw.Center(
                    child: pw.Text(
                        data['propertyType'] == "Building" ? "/" : ""))),
            pw.SizedBox(width: 10),
            pw.Text("BUILDING"),
          ]),
          pw.SizedBox(height: 5),
          pw.Row(children: [
            pw.Text("No. of Storeys:"),
            pw.SizedBox(width: 5),
            pw.Container(
                decoration: pw.BoxDecoration(
                    border: data['noOfStoreys'] != null
                        ? const pw.Border(bottom: pw.BorderSide(width: 1))
                        : null),
                child: pw.Text(data['noOfStoreys'] != null
                    ? data['noOfStoreys'].toString()
                    : '__________')),
          ]),
          pw.Row(children: [
            pw.Text("Brief Description:"),
            pw.SizedBox(width: 5),
            pw.Container(
                decoration: pw.BoxDecoration(
                    border: (data['briefDescription'] != "" &&
                            data['propertyType'] == "Building")
                        ? const pw.Border(bottom: pw.BorderSide(width: 1))
                        : null),
                child: pw.Text((data['briefDescription'] != "" &&
                        data['propertyType'] == "Building")
                    ? data['briefDescription']
                    : '__________________')),
          ]),
        ]),
        pw.SizedBox(width: 50),
        pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Container(
                    height: 15,
                    width: 15,
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(width: 1, color: PdfColors.black)),
                    child: pw.Center(
                        child: pw.Text(
                            data['propertyType'] == "Machinery" ? "/" : ""))),
                pw.SizedBox(width: 10),
                pw.Text("MACHINERY")
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text("Brief Description:"),
                pw.SizedBox(width: 5),
                pw.Container(
                    decoration: pw.BoxDecoration(
                        border: (data['briefDescription'] != "" &&
                                data['propertyType'] == "Machinery")
                            ? const pw.Border(bottom: pw.BorderSide(width: 1))
                            : null),
                    child: pw.Text((data['briefDescription'] != "" &&
                            data['propertyType'] == "Machinery")
                        ? data['briefDescription']
                        : '_____________________')),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Container(
                    height: 15,
                    width: 15,
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(width: 1, color: PdfColors.black)),
                    child: pw.Center(
                        child: pw.Text(
                            data['propertyType'] == "Others" ? "/" : ""))),
                pw.SizedBox(width: 10),
                pw.Text("OTHERS")
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text("Specify:"),
                pw.SizedBox(width: 5),
                pw.Container(
                    decoration: pw.BoxDecoration(
                        border: data['specification'] != ""
                            ? const pw.Border(bottom: pw.BorderSide(width: 1))
                            : null),
                    child: pw.Text(data['specification'] != ""
                        ? data['specification']
                        : '_____________________')),
              ])
            ])
      ]),
      pw.SizedBox(height: 10),
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start, children: []),
        pw.SizedBox(width: 10),
        pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [])
      ]),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            // CLASSIFICATION
            pw.Column(children: [
              pw.Text("Classification"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
            ]),
            // AREA

            pw.Column(children: [
              pw.Text("Area"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
            ]),
            // MARKET VALUE
            pw.Column(children: [
              pw.Text("Market Value"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
            ]),
            // ACTUAL USE
            pw.Column(children: [
              pw.Text("Actual"),
              pw.Text("Use"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
            ]),
            // ASSESSMENT LEVEL
            pw.Column(children: [
              pw.Text("Assessment"),
              pw.Text("Level"),
              pw.Text("________ %"),
              pw.Text("________ %"),
              pw.Text("________ %"),
              pw.Text("________ %"),
              pw.Text("________ %"),
            ]),
            // ASSESSED VALUE
            pw.Column(children: [
              pw.Text("Assessed"),
              pw.Text("Value"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
              pw.Text("________"),
            ])
          ]),
      pw.Row(children: [
        pw.SizedBox(width: 110),
        pw.Text("Total"),
        pw.SizedBox(width: 43),
        pw.Text("________"),
        pw.SizedBox(width: 196),
        pw.Text("________")
      ]),
      pw.SizedBox(height: 10),
      pw.Row(children: [
        pw.Text("Total Assessed Value"),
        pw.SizedBox(width: 20),
        pw.Column(children: [
          pw.SizedBox(height: 10),
          pw.Text("____________________________________________________"),
          pw.Text("(Amount in Words)")
        ])
      ]),
      pw.Row(children: [
        pw.Text("Taxable"),
        pw.SizedBox(width: 5),
        pw.Container(
            height: 15,
            width: 25,
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
        pw.SizedBox(width: 10),
        pw.Text("Exempt"),
        pw.SizedBox(width: 5),
        pw.Container(
            height: 15,
            width: 25,
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
        pw.SizedBox(width: 14),
        pw.Text("Effectivity of Assessment/Reassessment"),
        pw.SizedBox(width: 10),
        pw.Column(children: [
          pw.SizedBox(height: 5),
          pw.Text("______"),
          pw.Text("Qtr.")
        ]),
        pw.SizedBox(width: 10),
        pw.Column(children: [
          pw.SizedBox(height: 5),
          pw.Text("______"),
          pw.Text("Yr.")
        ])
      ]),
      pw.SizedBox(height: 20),
      pw.Row(children: [
        pw.Text("APPROVED BY:",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(width: 20),
        pw.Column(children: [
          pw.SizedBox(height: 5),
          pw.Text("_______________________________________"),
          pw.Text("OIC - Provincial/City/Municipal Assessor",
              style: pw.TextStyle(fontStyle: pw.FontStyle.italic))
        ]),
        pw.SizedBox(width: 20),
        pw.Column(children: [
          pw.SizedBox(height: 5),
          pw.Text("_____________"),
          pw.Text("Date", style: pw.TextStyle(fontStyle: pw.FontStyle.italic))
        ])
      ]),
      pw.SizedBox(height: 15),
      pw.Text(
          "This declaration cancels TD No. ________ Owner: ______________________ Previous A.V. Php ________",
          style: const pw.TextStyle(fontSize: 10)),
      pw.SizedBox(height: 15),
      pw.Text(
          "Memoranda:  ___________________________________________________________________________",
          style: const pw.TextStyle(fontSize: 10)),
      pw.Text(
          "________________________________________________________________________"),
      pw.Text(
          "________________________________________________________________________"),
      pw.Text(
          "________________________________________________________________________"),
      pw.SizedBox(height: 5),
      pw.RichText(
          text: pw.TextSpan(children: [
        pw.TextSpan(
            text: "Notes: * ",
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 7)),
        const pw.TextSpan(
            text:
                'THIS TAX DECLARATION IS FOR REAL PROPERTY TAXATION PURPOSES ONLY AND '
                'THE VALUATION INDICATED HEREIN ARE BASED ON THE SCHEDULE OF BASE UNIT '
                "& FAIR MARKET VALUES PREPARED FOR THE HEREIN PURPOSE AND DULY ENACTED "
                "INTO ORDINANCE BY THE SANGGUNIANG PANLALAWIGAN UNDER ORDINANCE NO. "
                "2019-17 DATED DECEMBER 26, 2019 & APPROVED BY GWENDOLYN F. GARCIA, "
                "PROVINCIAL GOVERNOR DATED JANUARY 3, 2020 & OFFICE MEMORANDUM CIRCULAR "
                "NO. 01-2020 DATED JANUARY 8, 2020, IT DOES NOT AND CANNOT BY ITSELF ALONE "
                "CONFER ANY OWNERSHIP OR LEGAL TITLE TO THE PROPERTY.",
            style: pw.TextStyle(fontSize: 7))
      ]))
    ]);
  }
}
