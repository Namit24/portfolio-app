import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namit\'s Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BFA5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BFA5),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animationLoaded = false;
  bool _animationError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToHome();
      }
    });

    // Auto-navigate after 1 second even if animation fails
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!_animationLoaded) {
        navigateToHome();
      }
    });
  }

  void navigateToHome() {
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_animationError)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset(
                        'assets/animations/coding_animation.json',
                        controller: _controller,
                        fit: BoxFit.contain,
                        onLoaded: (composition) {
                          setState(() {
                            _animationLoaded = true;
                          });
                          // Set a shorter duration and speed up the animation
                          _controller.duration = Duration(milliseconds: 1000);
                          _controller.forward();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          setState(() {
                            _animationError = true;
                          });
                          return _buildFallbackAnimation();
                        },
                      ),
                    ),
                  )
                else
                  _buildFallbackAnimation(),
                const SizedBox(height: 30),
                Text(
                  'Namit Solanki',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.3, end: 0),
                const SizedBox(height: 10),
                Text(
                  'Developer & Data Scientist',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAnimation() {
    // Fallback animation using built-in Flutter animations
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.code,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(),
    ).scale(
      duration: 1500.ms,
      begin: const Offset(0.8, 0.8),
      end: const Offset(1.1, 1.1),
    ).then().scale(
      duration: 1500.ms,
      begin: const Offset(1.1, 1.1),
      end: const Offset(0.8, 0.8),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Hero(
                    tag: 'profile',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Namit Solanki',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Developer & Data Scientist',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'About'),
                Tab(text: 'Experience'),
                Tab(text: 'Projects'),
                Tab(text: 'Blogs'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AboutPage(),
                  ExperiencePage(),
                  ProjectsPage(),
                  BlogsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).scale(),
          const SizedBox(height: 24),
          Text(
            'Hello, I\'m Namit',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: -0.2, end: 0),
          const SizedBox(height: 16),
          Text(
            'I\'m a Developer and Data Scientist passionate about building innovative solutions. My expertise spans Machine Learning, App Development, and Data Science.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              height: 1.5,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          const SizedBox(height: 24),
          _buildSkillsSection(context),
          const SizedBox(height: 24),
          _buildInterestsSection(context),
          const SizedBox(height: 24),
          _buildContactSection(context),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final skills = [
      'Machine Learning',
      'Data Science',
      'App Development',
      'Microsoft Office',
      'Git',
      'GitHub',
      'C++',
      'Python',
      'Kotlin',
      'Firebase',
      'SQL',
      'Transformers',
      'Linux',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInterestsSection(BuildContext context) {
    final interests = [
      'Photography',
      'Creative Writing',
      'Canva Designing',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 700.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: interests.map((interest) {
            return Chip(
              label: Text(interest),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 800.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 900.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        ListTile(
          leading: Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
          title: const Text('Email'),
          subtitle: const Text('namitsolanki48@gmail.com'),
          onTap: () => _launchUrl('mailto:namitsolanki48@gmail.com'),
        ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideX(begin: 0.2, end: 0),
        ListTile(
          leading: Icon(Icons.link, color: Theme.of(context).colorScheme.primary),
          title: const Text('LinkedIn'),
          subtitle: const Text('linkedin.com/in/namit-solanki'),
          onTap: () => _launchUrl('https://www.linkedin.com/in/namit-solanki/'),
        ).animate().fadeIn(duration: 600.ms, delay: 1100.ms).slideX(begin: 0.2, end: 0),
      ],
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class ExperiencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildExperienceCard(
          context,
          title: 'DBMS & Data Science Intern',
          company: 'Nereus Technologies',
          location: 'Bengaluru, India',
          duration: 'March 2025 - April 2025',
          description: [
            'Developed a PostgreSQL database and backend system to handle real-time IMU sensor data (velocity, acceleration, joint angles, timestamps), implemented Bluetooth connectivity for real-time CSV generation, and designed an Admin dashboard for managing sessions, user data, and exercise configurations.',
            'Created a user dashboard for interactive exercise tracking and data visualization, featuring session management (examiner login, auto-generated session IDs, pre/post-session inputs) and lapping functionality for accurate real-time data segmentation and analysis.',
          ],
        ),
        const SizedBox(height: 16),
        _buildExperienceCard(
          context,
          title: 'No Code ML Model Builder',
          company: 'Self-Employed',
          location: 'Pune, IN',
          duration: 'Sept. 2024 - Present',
          description: [
            'Developed a no-code machine learning model builder with Python scripts running on a Uvicorn server, enabling users to create ML models with just a click. Integrated scikit-learn for model creation, matplotlib for visualizations, and Streamlit for the frontend interface.',
            'Implemented automated data preprocessing features, including data cleaning, encoding, and transformation, ensuring seamless model building and deployment.',
          ],
        ),
        const SizedBox(height: 16),
        _buildAwardsSection(context),
      ],
    );
  }

  Widget _buildExperienceCard(
    BuildContext context, {
    required String title,
    required String company,
    required String location,
    required String duration,
    required List<String> description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              company,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...description.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_right,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          point,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildAwardsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Awards',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            _buildAwardItem(
              context,
              title: 'All India Rank 6 in TechXlerate Hackathon at BITS Pilani',
              date: 'Feb. 2025',
              description: 'Our team developed a platform where anyone can build their own ML models using a simple drag-and-drop technique without any coding required.',
            ),
            const SizedBox(height: 12),
            _buildAwardItem(
              context,
              title: 'Computer Science Subject Topper',
              date: 'Aug. 2023 - Present',
              description: 'Award given to the student securing highest marks in Computer Science in XII Boards.',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildAwardItem(
    BuildContext context, {
    required String title,
    required String date,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.emoji_events,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProjectsPage extends StatefulWidget {
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> with SingleTickerProviderStateMixin {
  late TabController _projectTabController;
  bool _isSerious = true;

  final List<Map<String, dynamic>> _seriousProjects = [
    {
      'title': 'Stock Predictor',
      'description': 'A machine learning model to predict stock market trends and prices.',
      'icon': Icons.trending_up,
      'url': 'https://github.com/Namit24/Stock_predictor',
      'technologies': ['Python', 'TensorFlow', 'Pandas', 'Matplotlib'],
    },
    {
      'title': 'Anti-Cheating',
      'description': 'A system to prevent cheating during online examinations using computer vision.',
      'icon': Icons.security,
      'url': 'https://github.com/Namit24/Anti-Cheating',
      'technologies': ['Python', 'OpenCV', 'TensorFlow', 'Flask'],
    },
    {
      'title': 'Women-Safety',
      'description': 'An app designed to enhance women\'s safety with emergency features and location tracking.',
      'icon': Icons.shield,
      'url': 'https://github.com/Namit24/Women-Safety',
      'technologies': ['Kotlin', 'Firebase', 'Google Maps API', 'Android'],
    },
    {
      'title': 'HealthApp',
      'description': 'A comprehensive health tracking and monitoring application.',
      'icon': Icons.favorite,
      'url': 'https://github.com/Namit24/HealthApp',
      'technologies': ['Flutter', 'Firebase', 'RESTful APIs', 'SQLite'],
    },
  ];

  final List<Map<String, dynamic>> _funProjects = [
    {
      'title': 'Portfolio Website',
      'description': 'A personal portfolio website showcasing my projects and skills.',
      'icon': Icons.web,
      'url': 'https://github.com/Namit24/namitportfolio',
      'technologies': ['HTML', 'CSS', 'JavaScript', 'React'],
    },
    {
      'title': 'YouTube Summary',
      'description': 'An application that generates summaries of YouTube videos using AI.',
      'icon': Icons.video_library,
      'url': 'https://github.com/Namit24/yt-summary',
      'technologies': ['Python', 'NLP', 'YouTube API', 'Flask'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _projectTabController = TabController(length: 2, vsync: this);
    _projectTabController.addListener(() {
      setState(() {
        _isSerious = _projectTabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _projectTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _projectTabController,
              labelColor: Theme.of(context).colorScheme.onPrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
              ),
              tabs: const [
                Tab(text: 'Serious Projects'),
                Tab(text: 'Fun Projects'),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _projectTabController,
            children: [
              _buildProjectGrid(_seriousProjects),
              _buildProjectGrid(_funProjects),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectGrid(List<Map<String, dynamic>> projects) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(context, projects[index]);
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailPage(project: project),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(
                  project['icon'] as IconData,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: (project['technologies'] as List<String>).map((tech) {
                      return Chip(
                        label: Text(
                          tech,
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
    );
  }
}

class ProjectDetailPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project['title']),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(
                child: Icon(
                  project['icon'] as IconData,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 12),
                  Text(
                    project['description'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 24),
                  Text(
                    'Technologies Used',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['technologies'] as List<String>).map((tech) {
                      return Chip(
                        label: Text(tech),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      );
                    }).toList(),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchUrl(project['url']),
                      icon: const Icon(Icons.code),
                      label: const Text('View Code on GitHub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class BlogsPage extends StatelessWidget {
  final List<Map<String, dynamic>> _blogs = [
    {
      'title': 'Research Paper Collection',
      'description': 'A collection of research papers and academic work.',
      'url': 'https://drive.google.com/drive/u/1/folders/1_UgltTS478MFtPz3VDgE3sybrz1VdBJr',
      'date': 'Various Dates',
      'icon': Icons.article,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _blogs.length,
      itemBuilder: (context, index) {
        final blog = _blogs[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _launchUrl(blog['url']),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Icon(
                      blog['icon'] as IconData,
                      size: 80,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            blog['date'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        blog['description'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _launchUrl(blog['url']),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Open Collection'),
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0);
      },
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
