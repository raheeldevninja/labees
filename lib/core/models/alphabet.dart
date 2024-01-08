class Alphabet {

  final String letter;
  final bool isSelected;

  Alphabet({required this.letter, this.isSelected = false});

  Alphabet copyWith({String? letter, bool? isSelected}) {
    return Alphabet(
      letter: letter ?? this.letter,
      isSelected: isSelected ?? this.isSelected,
    );
  }


}