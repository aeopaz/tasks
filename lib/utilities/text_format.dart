String organizeTitle(title, {long = 10}) {
  String new_title =
      title[0].toUpperCase() + title.substring(1, title.length).toLowerCase();
  if (new_title.length > long) {
    return new_title.substring(0, long) + '...';
  }
  return new_title;
}
