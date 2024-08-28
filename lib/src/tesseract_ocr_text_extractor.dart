import 'dart:async';

import 'package:ad_hoc_ident_ocr/ad_hoc_ident_ocr.dart';
import 'package:flutter_vision/flutter_vision.dart';

/// Tries to extract text data from an [OcrImage]
/// using the Tesseract v5 engine.
///
/// Accepts primarily jpeg format. For other formats refer to the official
/// Tesseract documentation. As most camera implementations do not support
/// other Tesseract compatible image formats, manual conversion is required.
class TesseractOcrTextExtractor implements OcrTextExtractor {
  final FlutterVision _flutterVision;

  /// Creates a [TesseractOcrTextExtractor] from the provided [flutterVision]
  /// instance.
  TesseractOcrTextExtractor({
    required FlutterVision flutterVision,
  }) : _flutterVision = flutterVision;

  /// Creates a [TesseractOcrTextExtractor] from a trained model file.
  ///
  /// The [languageFileName] specifies the file to use. Files have to be stored
  /// in the assets/tessdata folder. The assets directory has to contain a
  /// tessdata_config.json file that lists the model files. For more
  /// information consult the
  /// https://pub.dev/packages/flutter_vision documentation.
  static Future<TesseractOcrTextExtractor> fromFile(
      [String languageFileName = 'mrz']) async {
    final flutterVision = FlutterVision();
    final instance = TesseractOcrTextExtractor(flutterVision: flutterVision);

    await flutterVision.loadTesseractModel(
      args: {
        'psm': '11',
        'oem': '1',
        'preserve_interword_spaces': '1',
      },
      language: languageFileName,
    );
    return instance;
  }

  @override
  Future<List<List<String>>?> extract(OcrImage ocrImage) async {
    final mapResults = await _flutterVision.tesseractOnImage(
        bytesList: ocrImage.singlePlaneBytes);
    final tessResults = mapResults.map(_TesseractResult.fromMap);
    final blocksAndLines =
        tessResults.map((tessResult) => [tessResult.text]).toList();
    return blocksAndLines;
  }

  @override
  Future<void> close() async => await _flutterVision.closeTesseractModel();
}

class _TesseractResult {
  final String text;
  final List<int> wordConf;
  final int meanConf;

  const _TesseractResult(
      {required this.text, required this.wordConf, required this.meanConf});

  static _TesseractResult fromMap(Map<String, dynamic> map) {
    return _TesseractResult(
        text: map['text'],
        wordConf: map['word_conf'],
        meanConf: map['mean_conf']);
  }
}
