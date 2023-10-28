class FormatUtils {
  static String removeAccent(String input) {
    const withAccents = 'áàãâäéèêëíìïóòôöúùüç';
    const withoutAccents = 'aaaaaeeeeiiiooouuuc';
    final buffer = StringBuffer();

    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      final index = withAccents.indexOf(char);
      if (index != -1) {
        buffer.write(withoutAccents[index]);
      } else if (char == 'ç') {
        buffer.write('c');
      } else {
        buffer.write(char);
      }
    }

    return buffer.toString();
  }

  static String capitalize(String input) {
    if (input.isEmpty) {
      return input; // Retorna uma string vazia se a entrada for vazia
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
