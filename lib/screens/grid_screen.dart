import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_grid/utils/diamond_border.dart';

class GridScreen extends StatefulWidget {
  final int row;
  final int col;
  final String content;
  const GridScreen(
      {super.key, required this.row, required this.col, required this.content});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  String query = '';
  void findText(String q) {
    setState(() {
      query = q.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
      extendBodyBehindAppBar: true,
      body: Center(
        child: _buildGrid(),
      ),
      floatingActionButton: InputFab(callback: findText),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomeBottomAppBar(),
    );
  }

  Column _buildGrid() {
    int rows = widget.row;
    int cols = widget.col;

    final grid = _generateGrid(rows, cols);
    final result = _searchInGrid(grid, query);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < rows; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int j = 0; j < cols; j++)
                _buildGridContainer(
                    grid[i][j], result.any((list) => listEquals(list, [i, j])))
            ],
          ),
      ],
    );
  }

  Container _buildGridContainer(String char, bool isMatch) {
    var theme = Theme.of(context);
    TextStyle? headline6 = theme.textTheme.headline6;

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: isMatch ? theme.primaryColor : Colors.white,
        border: Border.all(
          color: isMatch ? Colors.white : const Color.fromARGB(48, 0, 0, 0),
          width: .64,
        ),
      ),
      child: Center(
        child: Text(
          char.toUpperCase(),
          style: headline6?.copyWith(
            color: isMatch ? Colors.white : theme.primaryColor,
          ),
        ),
      ),
    );
  }

  List<List<String>> _generateGrid(int rows, int cols) {
    String chars = widget.content.toLowerCase();
    final grid = List.generate(rows, (_) => List.generate(cols, (_) => ''));
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        grid[row][col] = chars[cols * row + col];
      }
    }
    return grid;
  }

  List<List<int>> _searchInGrid(List<List<String>> grid, String text) {
    final rows = grid.length;
    final cols = grid[0].length;
    List<List<int>> result = [];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        // search left to right
        if (col + text.length <= cols &&
            grid[row].sublist(col, col + text.length).join('') == text) {
          result = [
            for (int i = 0; i < text.length; i++) [row, col + i]
          ];
        }
        // search top to bottom
        if (row + text.length <= rows) {
          var match = true;
          for (int i = 0; i < text.length; i++) {
            if (grid[row + i][col] != text[i]) {
              match = false;
              break;
            }
          }
          if (match) {
            result = [
              for (int i = 0; i < text.length; i++) [row + i, col]
            ];
          }
        }
        // search top-left to bottom-right diagonal
        if (row + text.length <= rows && col + text.length <= cols) {
          var match = true;
          for (int i = 0; i < text.length; i++) {
            if (grid[row + i][col + i] != text[i]) {
              match = false;
              break;
            }
          }
          if (match) {
            result = [
              for (int i = 0; i < text.length; i++) [row + i, col + i]
            ];
          }
        }
        // search bottom-left to top-right diagonal
        if (row >= text.length - 1 && col + text.length <= cols) {
          var match = true;
          for (int i = 0; i < text.length; i++) {
            if (grid[row - i][col + i] != text[i]) {
              match = false;
              break;
            }
          }
          if (match) {
            result = [
              for (int i = 0; i < text.length; i++) [row - i, col + i]
            ];
          }
        }
      }
    }
    return result;
  }
}

class CustomeBottomAppBar extends StatelessWidget {
  const CustomeBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 64,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color.fromARGB(48, 0, 0, 0), width: 0.6),
          ),
        ),
      ),
    );
  }
}

class InputFab extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  final Function(String) callback;
  InputFab({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          width: size.width - 160,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
        ),
        const SizedBox(width: 24),
        SizedBox(
          width: 72,
          height: 72,
          child: FloatingActionButton(
            onPressed: () => callback(_controller.text),
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: const DiamondBorder(),
            child: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
