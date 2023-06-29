part of '../../neon.dart';

final _cacheManager = DefaultCacheManager();

typedef APIImageDownloader = Future<Uint8List> Function();

class NeonCachedImage extends StatefulWidget {
  const NeonCachedImage._({
    required this.getImageFile,
    required Key super.key,
    this.isSvgHint = false,
    this.size,
    this.fit,
    this.svgColor,
    this.iconColor,
  });

  factory NeonCachedImage.url({
    required final String url,
    final Size? size,
    final BoxFit? fit,
    final Color? svgColor,
    final Color? iconColor,
    final Key? key,
  }) =>
      NeonCachedImage._(
        getImageFile: () async {
          final file = await _cacheManager.getSingleFile(url);
          return file.readAsBytes();
        },
        isSvgHint: Uri.parse(url).path.endsWith('.svg'),
        size: size,
        fit: fit,
        svgColor: svgColor,
        iconColor: iconColor,
        key: key ?? Key(url),
      );

  factory NeonCachedImage.api({
    required final Account account,
    required final String cacheKey,
    required final APIImageDownloader download,
    final String? etag,
    final Size? size,
    final BoxFit? fit,
    final Color? svgColor,
    final Color? iconColor,
    final Key? key,
  }) {
    final realKey = '${account.id}-$cacheKey';
    return NeonCachedImage._(
      getImageFile: () async {
        final cacheFile = await _cacheManager.getFileFromCache(realKey);
        if (cacheFile != null && cacheFile.validTill.isAfter(DateTime.now())) {
          return cacheFile.file.readAsBytes();
        }

        final file = await download();

        unawaited(
          _cacheManager.putFile(
            realKey,
            file,
            maxAge: const Duration(days: 7),
            eTag: etag,
          ),
        );

        return file;
      },
      size: size,
      fit: fit,
      svgColor: svgColor,
      iconColor: iconColor,
      key: key ?? Key(realKey),
    );
  }

  final Future<Uint8List> Function() getImageFile;
  final bool isSvgHint;

  final Size? size;
  final BoxFit? fit;

  final Color? svgColor;
  final Color? iconColor;

  @override
  State<NeonCachedImage> createState() => _NeonCachedImageState();
}

class _NeonCachedImageState extends State<NeonCachedImage> {
  late Future<Uint8List> _future = widget.getImageFile();

  @override
  Widget build(final BuildContext context) => Center(
        child: FutureBuilder<Uint8List>(
          future: _future,
          builder: (final context, final fileSnapshot) {
            if (!fileSnapshot.hasData) {
              return SizedBox(
                width: widget.size?.width,
                child: NeonLinearProgressIndicator(
                  color: widget.iconColor,
                ),
              );
            }

            if (fileSnapshot.hasError) {
              return NeonException(
                fileSnapshot.error,
                onRetry: () {
                  setState(() {
                    // ignore: discarded_futures
                    _future = widget.getImageFile();
                  });
                },
                onlyIcon: true,
                iconSize: widget.size?.shortestSide,
                color: widget.iconColor ?? Theme.of(context).colorScheme.error,
              );
            }

            final content = fileSnapshot.requireData;

            try {
              // TODO: Is this safe enough?
              if (widget.isSvgHint || utf8.decode(content).contains('<svg')) {
                return SvgPicture.memory(
                  content,
                  height: widget.size?.height,
                  width: widget.size?.width,
                  fit: widget.fit ?? BoxFit.contain,
                  colorFilter: widget.svgColor != null ? ColorFilter.mode(widget.svgColor!, BlendMode.srcIn) : null,
                );
              }
            } catch (_) {
              // If the data is not UTF-8
            }

            return Image.memory(
              content,
              height: widget.size?.height,
              width: widget.size?.width,
              fit: widget.fit,
              gaplessPlayback: true,
            );
          },
        ),
      );
}
