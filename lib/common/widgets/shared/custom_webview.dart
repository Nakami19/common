import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';

class CustomWebview extends StatefulWidget {
  // Variable con el url de Registro OD
  //! Siempre HTTPS, sino no funciona
  final String args;
  final double? height;

  const CustomWebview({super.key, required this.args, this.height});

  @override
  State<CustomWebview> createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  @override
  void initState() {
    super.initState();
  }

  //  Variable de configuracion del webview
  InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
    javaScriptEnabled: true,
    allowsAirPlayForMediaPlayback: true,
    allowContentAccess: true,
    allowFileAccess: true,
    allowsPictureInPictureMediaPlayback: true,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 300,
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
            // o lo que esta en el provider o lo que mando por la ruta (es lo mismo)
            widget.args,
          ),
        ),
        initialSettings: settings,
        onWebViewCreated: (InAppWebViewController controller) {},
        onPermissionRequest: (controller, request) async {
          return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT,
          );
        },
      ),
    );
  }
}
