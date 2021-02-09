part of 'meme_cubit.dart';

@immutable
abstract class MemeState {}

class MemeInitial extends MemeState {}

class GettingMemes extends MemeState {
  final List memes;
  GettingMemes(this.memes);
  List<Object> get props => [memes];
}

class ErrorGettingMemes extends MemeState {}

class GenerateTextMeme extends MemeState {
  final ArgumentUrl argumentUrl;

  GenerateTextMeme(this.argumentUrl);
  List<Object> get props => [argumentUrl];
}

class UploadLogoMeme extends MemeState {
  final File image;

  UploadLogoMeme(this.image);
  List<Object> get props => [image];
}
