import 'package:flutter/material.dart';
import 'package:st/app/modules/home/models/common_widget_model.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.commonWidgetModel,
    this.itemCallBack,
  });

  final CommonWidgetModel commonWidgetModel;
  final Function(CommonWidgetModel model)? itemCallBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => itemCallBack?.call(commonWidgetModel),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: commonWidgetModel.color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    commonWidgetModel.icon,
                    color: Colors.white,
                    size: 35,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    commonWidgetModel.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(
                    commonWidgetModel.subTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -24,
              right: -24,
              child: Icon(
                commonWidgetModel.icon,
                color: Colors.white.withOpacity(0.2),
                size: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
