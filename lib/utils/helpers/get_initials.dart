 String getInitials(String name) {
    List<String> words = name.split(" ");
    String initials = "";
    int numWords = 2; // Show 2 initials at most

    for (var i = 0; i < words.length && i < numWords; i++) {
      initials += words[i][0].toUpperCase();
    }

    return initials;
  }