import 'package:flutter/material.dart';

import '../../common_index.dart';

class LoadingButtonText extends StatelessWidget {
  final GeneralProvider provider;
  final String text;
  final TextStyle? styleText;
  final Icon? leftIcon;
  final Icon? rightIcon;
  final ButtonType buttonType;

  const LoadingButtonText({
    super.key,
    required this.text,
    required this.provider,
    required this.buttonType,
    this.styleText,
    this.leftIcon,
    this.rightIcon
  });

  @override
  Widget build(BuildContext context) {
    final textStyle =Theme.of(context).textTheme.bodyLarge ; 
    return provider.isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Cargando...',
                style: textStyle!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null) ...[
                leftIcon!,
                const SizedBox(width: 15), 
              ],
              Flexible(
                child: Text(
                  text,
                  style: styleText ?? textStyle!.copyWith(color: ButtonType.filled == buttonType? Colors.white : primaryColor, fontSize: 18),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis
                
                ),
              ),
              if (rightIcon != null) ...[
                rightIcon!,
                const SizedBox(width: 15), 
              ],
            ],
          );
  }
}
