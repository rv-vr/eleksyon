class Candidate {
  final String name;
  final int age;
  final String program;
  final String year;
  final String description;
  final String runningFor;
  final String imagePath;
  final List<String> achievements;
  final String partylist;
  final List<Platform> platforms;

  Candidate({
    required this.name,
    required this.age,
    required this.program,
    required this.year,
    required this.description,
    required this.runningFor,
    required this.imagePath,
    required this.achievements,
    required this.partylist,
    required this.platforms,
  });
}

class Platform {
  final String title;
  final String description;

  Platform({
    required this.title,
    required this.description,
  });
}

final List<Candidate> candidates = [
  Candidate(
    name: "Daniel Catedrilla",
    age: 21,
    program: "BS Computer Science",
    year: "2nd Year",
    description:
        "A passionate computer science student with a keen interest in software development and data analysis.",
    imagePath: "assets/candidates/DC001.jpg",
    achievements: ["Dean's List 2022", "Hackathon Winner 2023"],
    partylist: "TDA",
    runningFor: "Governor",
    platforms: [
      Platform(
        title: "Enhancing Student Resources",
        description:
            "I will work towards improving access to resources such as textbooks, software, and online materials for all students.",
      ),
      Platform(
        title: "Organizing Workshops",
        description:
            "I will organize workshops and seminars to help students enhance their skills and knowledge in various areas of computer science.",
      ),
      Platform(
        title: "Fostering Community Engagement",
        description:
            "I will promote community engagement through events and activities that encourage collaboration among students.",
      ),
    ],
  ),
  Candidate(
    name: "Matthew Mallorca",
    age: 19,
    program: "BS Computer Science",
    year: "2nd Year",
    description:
        "A passionate computer science student with a keen interest in software development and data analysis.",
    imagePath: "assets/candidates/MM002.jpg",
    achievements: ["Dean's List 2022", "Hackathon Winner 2023"],
    partylist: "CompuTeam",
    runningFor: "Vice Governor",
    platforms: [
      Platform(
        title: "Enhancing Student Resources",
        description:
            "I will work towards improving access to resources such as textbooks, software, and online materials for all students.",
      ),
      Platform(
        title: "Organizing Workshops",
        description:
            "I will organize workshops and seminars to help students enhance their skills and knowledge in various areas of computer science.",
      ),
      Platform(
        title: "Fostering Community Engagement",
        description:
            "I will promote community engagement through events and activities that encourage collaboration among students.",
      ),
    ],
  ),
  Candidate(
    name: "Ryen Caduada",
    age: 23,
    program: "BS Entrepreneurship",
    year: "4th Year",
    description:
        "A dedicated entrepreneurship student with a strong focus on innovation and business development.",
    partylist: "Spotify top 100 Philippines",
    runningFor: "Marathon",
    imagePath: "assets/candidates/RC003.jpg",
    achievements: ["Best Business Plan 2022", "Startup Pitch Winner 2023", "Mutya ng Chupa 2025"],
    platforms: [
      Platform(
        title: "Facebook Page",
        description:
            "I will create a Facebook page to keep students updated on events, resources, and opportunities.",
      ),
      Platform(
        title: "Free Rhinoplasty",
        description:
            "I will offer free rhinoplasty to students who need it, ensuring that everyone feels confident and comfortable.",
      ),
      Platform(
        title: "Sex Dungeon",
        description:
            "I will establish a safe and inclusive space for students to explore their interests and hobbies.",
      ),
    ],
  )
];
