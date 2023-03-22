import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'grid_screen.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'THE\t',
            style:
                TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
            children: const [
              TextSpan(
                  text: 'GRID', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: InputBody(),
      resizeToAvoidBottomInset: false,
    );
  }
}

class InputBody extends StatelessWidget {
  final TextEditingController _rowTextController = TextEditingController();
  final TextEditingController _colTextController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  InputBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuestion(
            text: '1.Enter No. Rows',
            icon: 'assets/row_icon.svg',
            ctx: context,
            controller: _rowTextController,
          ),
          _buildQuestion(
            text: '2. Enter No. Columns',
            icon: 'assets/col_icon.svg',
            ctx: context,
            controller: _colTextController,
          ),
          _buildQuestion(
            text: '3. Enter Content',
            ctx: context,
            controller: _contentController,
          ),
          ElevatedButton(
            onPressed: () {
              int row = int.tryParse(_rowTextController.text) ?? 0;
              int col = int.tryParse(_colTextController.text) ?? 0;
              String content = _contentController.text;

              if (content.length != (row * col)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'The conte should be in ${row * col} characters, given ${content.length} characters',
                    ),
                  ),
                );
              }
              if (content.length == (row * col)) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GridScreen(
                      row: row,
                      col: col,
                      content: content,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(51),
              textStyle: const TextStyle(fontSize: 16),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Generate Grid'),
          )
        ],
      ),
    );
  }

  Column _buildQuestion({
    required String text,
    String? icon,
    required BuildContext ctx,
    required TextEditingController controller,
  }) {
    TextStyle? headline6 = Theme.of(ctx).textTheme.headline6;
    Size size = MediaQuery.of(ctx).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: headline6),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: icon == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: [
            if (icon != null) SvgPicture.asset(icon, height: 48),
            SizedBox(
              width: icon == null ? size.width - 64 : 128,
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: icon == null ? 8 : 1,
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Eg: 3'),
                keyboardType:
                    icon == null ? TextInputType.text : TextInputType.number,
                inputFormatters: icon == null
                    ? []
                    : [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
