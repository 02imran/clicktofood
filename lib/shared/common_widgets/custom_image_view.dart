import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/config/asset_config.dart';
import '../../core/utils/size_config.dart';

class CustomImageView extends StatelessWidget {
  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;
  Widget? placeHolderWidget;
  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
    this.placeHolderWidget,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: _buildWidget(),
    )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    // debugPrint("image type: ${imagePath!.imageType}, path: ${imagePath!}");
    if ((imagePath ?? "").isNotEmpty) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              color: color,
            ),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              // return Icon(Icons.broken_image_rounded, size: getProportionateScreenHeight(35),);
              return CustomImageView(imagePath: AssetConfig.cross_icon, fit: BoxFit.contain, height: getProportionateScreenHeight(height ?? 35));
            },
          );
        case ImageType.network:
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
            child: CachedNetworkImage(
              imageUrl: imagePath ?? AssetConfig.appLogo,
              height: height,
              width: width,
              fit: fit,
              color: color,
              placeholder: (context, url) {
                return Center(
                  child: Container(
                    height: height,
                    width: width,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(AssetConfig.appLogo, fit: BoxFit.contain),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                Future<List<int>> getSSLImage(String imagePath) async {
                  HttpClient httpClient = HttpClient()
                    ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

                  var request = await httpClient.getUrl(Uri.parse(imagePath));
                  var response = await request.close();

                  if (response.statusCode == 200) {
                    List<int> bytes = await consolidateHttpClientResponseBytes(response);
                    // print("request :: ${bytes}");
                    return bytes;
                  } else {
                    throw Exception('Failed to load image. Status code: ${response.statusCode}');
                  }
                }

                // return Icon(Icons.image_not_supported_rounded, size: getProportionateScreenHeight(height ?? 36),);
                return FutureBuilder(
                  future: getSSLImage(imagePath ?? ""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      // return Image.memory(Uint8List.fromList(snapshot.data as List<int>));
                      return ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                        child: Image.memory(
                          Uint8List.fromList(snapshot.data as List<int>),
                          height: height,
                          width: width,
                          fit: fit,
                          color: color,
                        ),
                      );
                    } else {
                      // return Icon(Icons.broken_image_rounded, size: getProportionateScreenHeight(height ?? 35));
                      return CustomImageView(imagePath: AssetConfig.cross_icon, fit: BoxFit.contain, height: getProportionateScreenHeight(height ?? 35));
                    }
                  },
                );
              },
            ),
          );
          /// Old
          // return ClipRRect(
          //   borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          //   child: CachedNetworkImage(
          //     imageUrl: imagePath ?? AssetConfig.appLogo,
          //     height: height,
          //     width: width,
          //     fit: fit,
          //     color: color,
          //     placeholder: (context, url) {
          //       return Center(
          //         child: Container(
          //           height: height,
          //           width: width,
          //           padding: const EdgeInsets.all(0),
          //           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          //           child: Lottie.asset(AssetConfig.smanagerLogoLoaderLottie, fit: BoxFit.contain),
          //         ),
          //       );
          //     },
          //     errorWidget: (context, url, error) {
          //       return Icon(Icons.image_not_supported_rounded, size: getProportionateScreenHeight(height ?? 36),);
          //     },
          //   ),
          // );
          /// Older
          // return ClipRRect(
          //   borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          //   child: Image.network(imagePath ?? AssetConfig.appLogo,
          //     height: height,
          //     width: width,
          //     fit: fit,
          //     color: color,
          //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          //       if (loadingProgress == null) {
          //         return child;
          //       } else {
          //         return Center(
          //           child: Container(
          //             height: height,
          //             width: width,
          //             padding: const EdgeInsets.all(0),
          //             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          //             child: Lottie.asset(AssetConfig.smanagerLogoLoaderLottie, fit: BoxFit.contain),
          //           ),
          //         );
          //       }
          //     },
          //     errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          //       return Icon(Icons.broken_image_rounded, size: getProportionateScreenHeight(height ?? 36),);
          //     },
          //   ),
          // );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              // return Icon(Icons.broken_image_rounded, size: getProportionateScreenHeight(35),);
              return CustomImageView(imagePath: AssetConfig.cross_icon, fit: BoxFit.contain, height: getProportionateScreenHeight(height ?? 35));
            },
          );
      }
    }else{
      return placeHolderWidget == null ? Image.asset(
        placeHolder,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          // return Icon(Icons.broken_image_rounded, size: getProportionateScreenHeight(35),);
          return CustomImageView(imagePath: AssetConfig.cross_icon, fit: BoxFit.contain, height: getProportionateScreenHeight(height ?? 35));
        },
      ) : placeHolderWidget!;
    }

  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')||startsWith('/')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }