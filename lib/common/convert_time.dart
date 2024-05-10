String convertTime(String minutos) {
  if (minutos.length == 1) {
    return "0$minutos";
  } else {
    return minutos;
  }
}
