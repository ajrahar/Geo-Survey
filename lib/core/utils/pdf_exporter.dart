import 'dart:typed_data';
import 'package:geosurvey/core/database/app_database.dart';
import 'package:geosurvey/core/utils/file_exporter.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// PDF export utilities for survey reports
class PdfExporter {
  /// Generate PDF report for survey
  static Future<Uint8List> generateSurveyReport({
    required Survey survey,
    required List<LatLng> vertices,
    Uint8List? mapScreenshot,
  }) async {
    final pdf = pw.Document();

    // Add page
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          // Header
          _buildHeader(survey),
          pw.SizedBox(height: 20),

          // Map screenshot (if available)
          if (mapScreenshot != null) ...[
            pw.Text(
              'Peta Lokasi',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400),
              ),
              child: pw.Image(
                pw.MemoryImage(mapScreenshot),
                fit: pw.BoxFit.contain,
                height: 300,
              ),
            ),
            pw.SizedBox(height: 20),
          ],

          // Statistics
          _buildStatistics(survey, vertices),
          pw.SizedBox(height: 20),

          // Coordinates table
          _buildCoordinatesTable(vertices),
          pw.SizedBox(height: 20),

          // Footer
          _buildFooter(),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(Survey survey) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'LAPORAN SURVEY LAHAN',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal700,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Divider(thickness: 2, color: PdfColors.teal700),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Nama Survey: ${survey.name}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Tanggal: ${DateFormat('dd MMMM yyyy, HH:mm').format(survey.createdAt)}',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'ID: ${survey.id}',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
                if (survey.address.isNotEmpty) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(
                    survey.address,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildStatistics(Survey survey, List<LatLng> vertices) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Statistik Survey',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          children: [
            _buildTableRow('Jumlah Titik', '${vertices.length} titik'),
            _buildTableRow(
              'Luas Area',
              GeoCalculator.formatArea(survey.areaSize),
            ),
            _buildTableRow(
              'Keliling',
              GeoCalculator.formatDistance(survey.perimeter),
            ),
            _buildTableRow(
              'Luas (Hektar)',
              '${(survey.areaSize / 10000).toStringAsFixed(4)} ha',
            ),
            _buildTableRow(
              'Luas (m²)',
              '${survey.areaSize.toStringAsFixed(2)} m²',
            ),
          ],
        ),
      ],
    );
  }

  static pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(value)),
      ],
    );
  }

  static pw.Widget _buildCoordinatesTable(List<LatLng> vertices) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Koordinat Titik',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: {
            0: const pw.FixedColumnWidth(50),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
          },
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'No',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Latitude',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Longitude',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Data rows
            ...vertices.asMap().entries.map((entry) {
              final index = entry.key;
              final vertex = entry.value;
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('${index + 1}'),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(vertex.latitude.toStringAsFixed(6)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(vertex.longitude.toStringAsFixed(6)),
                  ),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(color: PdfColors.grey400),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Generated by Geo Survey',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
            pw.Text(
              DateFormat('dd MMM yyyy HH:mm').format(DateTime.now()),
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ),
      ],
    );
  }

  /// Save and share PDF
  static Future<void> exportAndShare({
    required Survey survey,
    required List<LatLng> vertices,
    Uint8List? mapScreenshot,
  }) async {
    // Generate PDF
    final pdfBytes = await generateSurveyReport(
      survey: survey,
      vertices: vertices,
      mapScreenshot: mapScreenshot,
    );

    // Save to file
    final filename =
        'survey_${survey.name.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';

    await FileExporter.saveBytesAndShare(
      bytes: pdfBytes,
      filename: filename,
      shareText: 'Laporan Survey: ${survey.name}',
    );
  }

  /// Save PDF to file and return path
  static Future<String> savePdfToFile({
    required Survey survey,
    required List<LatLng> vertices,
    Uint8List? mapScreenshot,
  }) async {
    final pdfBytes = await generateSurveyReport(
      survey: survey,
      vertices: vertices,
      mapScreenshot: mapScreenshot,
    );

    final filename =
        'survey_${survey.name.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';

    return await FileExporter.saveBytesToFile(
      bytes: pdfBytes,
      filename: filename,
    );
  }
}
