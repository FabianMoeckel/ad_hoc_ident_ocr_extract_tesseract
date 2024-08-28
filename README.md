Part of the [ad\_hoc\_ident](https://pub.dev/packages/ad_hoc_ident) framework.
Provides OCR functionality based on [flutter\_vision](https://pub.dev/packages/flutter_vision).

## Features
The package consists of three domain packages. Each is provided with some implementation packages.
* Provides an OcrTextExtractor implementation to extract text from OcrImages.
* Based on [flutter\_vision](https://pub.dev/packages/flutter_vision).
* Tests to detect MRZ documents had very poor results and performance with the current setup. 
It is highly recommended to use 
[ad\_hoc\_ident\_ocr\_extract\_google](https://pub.dev/packages/ad_hoc_ident_ocr_extract_google) 
instead. 


## Getting started

See the setup documentation of [flutter\_vision](https://pub.dev/packages/flutter_vision) on how to 
add a trained model to your package. As a starting point for trained models specialized for OCR-B 
and MRZ detection, see [tesseractMRZ](https://github.com/DoubangoTelecom/tesseractMRZ) and 
[tessdata\_ocrb](https://github.com/Shreeshrii/tessdata_ocrb).

Add the main domain package to your app's pubspec.yaml file and
add the packages of the features you require for your app.

## Usage

Make yourself familiar with the example app in the
[ad\_hoc\_ident](https://pub.dev/packages/ad_hoc_ident) package,
as it provides a good overview on how to combine the different packages.
Otherwise pick and match the features that suite you.
All features implemented out of the box have their interfaces defined in the respective
domain package, so you can easily create and integrate your own implementations.

## Additional information

If you use this package and implement your own features or extend the existing ones,
consider creating a pull request. This project was created for university, but if it is useful
to other developers I might consider supporting further development.

Please be aware that reading MRZ documents or NFC tags of other persons might be restricted by
local privacy laws.
