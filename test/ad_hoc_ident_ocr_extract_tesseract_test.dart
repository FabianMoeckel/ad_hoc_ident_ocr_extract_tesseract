import 'dart:typed_data';

import 'package:ad_hoc_ident_ocr/ad_hoc_ident_ocr.dart';
import 'package:ad_hoc_ident_ocr_extract_tesseract/ad_hoc_ident_ocr_extract_tesseract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vision/flutter_vision.dart';

class MockFlutterVision implements FlutterVision {
  final List<Map<String, dynamic>> mockResults;

  const MockFlutterVision(this.mockResults);

  @override
  Future<void> closeTesseractModel() {
    // TODO: implement closeTesseractModel
    throw UnimplementedError();
  }

  @override
  Future<void> closeYoloModel() {
    // TODO: implement closeYoloModel
    throw UnimplementedError();
  }

  @override
  Future<void> loadTesseractModel(
      {String? language, Map<String, String>? args}) {
    // TODO: implement loadTesseractModel
    throw UnimplementedError();
  }

  @override
  Future<void> loadYoloModel(
      {required String modelPath,
      required String labels,
      required String modelVersion,
      bool? quantization,
      int? numThreads,
      bool? useGpu}) {
    // TODO: implement loadYoloModel
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> tesseractOnImage(
      {required Uint8List bytesList}) async {
    return mockResults;
  }

  @override
  Future<List<Map<String, dynamic>>> yoloOnFrame(
      {required List<Uint8List> bytesList,
      required int imageHeight,
      required int imageWidth,
      double? iouThreshold,
      double? confThreshold,
      double? classThreshold}) {
    // TODO: implement yoloOnFrame
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> yoloOnImage(
      {required Uint8List bytesList,
      required int imageHeight,
      required int imageWidth,
      double? iouThreshold,
      double? confThreshold,
      double? classThreshold}) {
    // TODO: implement yoloOnImage
    throw UnimplementedError();
  }
}

void main() {
  test('passes an image to the engine and returns the result', () async {
    const testText = 'String';
    final mockResults = [
      {
        'text': testText,
        'word_conf': [1, 2, 3],
        'mean_conf': 2,
      }
    ];
    final mockVision = MockFlutterVision(mockResults);
    final mockImage = OcrImage(
        singlePlaneBytes: Uint8List.fromList([]),
        singlePlaneBytesPerRow: 0,
        width: 0,
        height: 0,
        rawImageFormat: 256);

    final extractor = TesseractOcrTextExtractor(flutterVision: mockVision);

    final result = await extractor.extract(mockImage);
    final flattenedString = result!
        .reduce(
          (value, element) => value.followedBy(element).toList(),
        )
        .reduce(
          (value, element) => value + element,
        );

    expect(flattenedString, testText);
  });
}
