import 'package:flutter/material.dart';
import 'package:portfolio_app/models/project.dart';
import 'package:portfolio_app/screens/project_detail_page.dart';
import 'package:portfolio_app/theme/app_colors.dart';
import 'package:portfolio_app/widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> with SingleTickerProviderStateMixin {
  late TabController _projectTabController;
  bool _isSerious = true;

  final List<Project> _seriousProjects = [
    Project(
      title: 'Stock Predictor',
      description: 'A machine learning model to predict stock market trends and prices.',
      icon: Icons.trending_up,
      url: 'https://github.com/Namit24/Stock_predictor',
      technologies: ['Python', 'TensorFlow', 'Pandas', 'Matplotlib'],
    ),
    Project(
      title: 'Anti-Cheating',
      description: 'A system to prevent cheating during online examinations using computer vision.',
      icon: Icons.security,
      url: 'https://github.com/Namit24/Anti-Cheating',
      technologies: ['Python', 'OpenCV', 'TensorFlow', 'Flask'],
    ),
    Project(
      title: 'Women-Safety',
      description: 'An app designed to enhance women\'s safety with emergency features and location tracking.',
      icon: Icons.shield,
      url: 'https://github.com/Namit24/Women-Safety',
      technologies: ['Kotlin', 'Firebase', 'Google Maps API', 'Android'],
    ),
    Project(
      title: 'HealthApp',
      description: 'A comprehensive health tracking and monitoring application.',
      icon: Icons.favorite,
      url: 'https://github.com/Namit24/HealthApp',
      technologies: ['Flutter', 'Firebase', 'RESTful APIs', 'SQLite'],
    ),
  ];

  final List<Project> _funProjects = [
    Project(
      title: 'Portfolio Website',
      description: 'A personal portfolio website showcasing my projects and skills.',
      icon: Icons.web,
      url: 'https://github.com/Namit24/namitportfolio',
      technologies: ['HTML', 'CSS', 'JavaScript', 'React'],
    ),
    Project(
      title: 'YouTube Summary',
      description: 'An application that generates summaries of YouTube videos using AI.',
      icon: Icons.video_library,
      url: 'https://github.com/Namit24/yt-summary',
      technologies: ['Python', 'NLP', 'YouTube API', 'Flask'],
    ),
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
              color: AppColors.lightGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _projectTabController,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.darkGray,
              indicator: BoxDecoration(
                color: AppColors.teal,
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

  Widget _buildProjectGrid(List<Project> projects) {
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
        return ProjectCard(
          project: projects[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectDetailPage(project: projects[index]),
              ),
            );
          },
          animationDelay: index * 100,
        );
      },
    );
  }
}
