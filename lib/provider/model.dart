class ColorRow {
  final String value;
  final String title;
  final int colorcode;

  ColorRow(this.value, this.title, this.colorcode);
}

class Items {
  final List<ColorRow> colorRow;
  final int pointerValue;

  Items(this.colorRow, this.pointerValue);
}
