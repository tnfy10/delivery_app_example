import 'package:flutter_test/flutter_test.dart';

void main() {
  test('factory test', () {
    final parent = Parent(id: 1);

    print(parent.id);
    expect(parent.runtimeType, Parent);

    final child = Child(id: 3);

    print(child.id);
    expect(child.runtimeType, Child);

    final parent2 = Parent.fromInt(5);

    print(parent2.id);
    expect(parent2.runtimeType, Child);
  });
}

class Parent {
  final int id;

  Parent({required this.id});

  factory Parent.fromInt(int id) {
    return Child(id: id);
  }
}

class Child extends Parent {
  Child({required super.id});
}
