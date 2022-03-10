/// Interface dedicated to illuminated widgets
/// Use a map of Opacities to define your state and passe the item in the UI event to trigger this functions

abstract class Illuminable<I> {
  const Illuminable();

  void illuminate(event, I? item);
  void shade(event, I? item);
}
