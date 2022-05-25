
extension TimeFromInt on int {
  String toTime({bool withLetter = false}) {
    int timeInSeconds = this;
    int hours = timeInSeconds ~/ 3600;
    timeInSeconds %= 3600;
    int minutes = timeInSeconds ~/ 60;
    timeInSeconds %= 60;
    int seconds = timeInSeconds;

    if (hours > 0) {
      if (withLetter) {
        return "${hours}h ${minutes.padLeft()}m";
      } else {
        return "${hours.padLeft()}:${minutes.padLeft()}:${seconds.padLeft()}";
      }
    }else{
		if(withLetter){
			return "${minutes}m ${seconds.padLeft()}s";
		}else{
			return "${minutes.padLeft()} : ${seconds.padLeft()}";
		}
	}
  }

  String padLeft([int width = 2, String padding = '0']) => toString().padLeft(width, padding);

}
