void main(List<String> args) {
  try {
    List<int>? a = List.generate(5, (index) => index);
    final b = a.skipWhile((value) => true).map((e) => e+1).toList();
    print(b.length);
    b.forEach(print);
  } catch (e) {
    print(e);
  }
}
