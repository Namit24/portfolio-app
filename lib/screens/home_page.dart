import 'package:flutter/material.dart';
import 'package:portfolio_app/screens/tabs/about_page.dart';
import 'package:portfolio_app/screens/tabs/experience_page.dart';
import 'package:portfolio_app/screens/tabs/projects_page.dart';
import 'package:portfolio_app/screens/tabs/blogs_page.dart';
import 'package:portfolio_app/theme/app_colors.dart';

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
                      backgroundColor: AppColors.mint,
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
                              color: AppColors.teal,
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
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Developer & Data Scientist',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.darkGray,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.lightGray,
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.teal,
                unselectedLabelColor: AppColors.darkGray,
                indicatorColor: AppColors.teal,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                ),
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Experience'),
                  Tab(text: 'Projects'),
                  Tab(text: 'Blogs'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
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
