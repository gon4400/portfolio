import 'package:flutter/material.dart';
import 'package:portfolio/widgets/project_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/widgets/custom_app_bar.dart';


class PortfolioScreen extends StatefulWidget {
  final List<Map<String, String>> projects;
  final String linkedinUrl;
  final String githubUrl;
  final String email;

  const PortfolioScreen({
    Key? key,
    required this.projects,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.email,
  }) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  int? selectedProjectIndex;

  void _scrollTo(double position) {
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salut, je suis Pierre 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                Text(
                  'Développeur mobile Flutter, Kotlin & Swift, passionné par les apps performantes et bien pensées.',
                  style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pierre Meignan', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.displayLarge?.color)),
          SizedBox(height: 8),
          Text('Développeur Mobile | Android | iOS | Flutter',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Theme.of(context).textTheme.displayMedium?.color)),
          SizedBox(height: 20),
          Text('Compétences principales :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.displayLarge?.color)),
          SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              Chip(label: Text('Flutter & Dart')),
              Chip(label: Text('Firebase / Firestore')),
              Chip(label: Text('Android / iOS')),
              Chip(label: Text('UI/UX Design')),
              Chip(label: Text('Git / CI-CD')),
              Chip(label: Text('REST API')),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '💡 Ingénieur consultant & Développeur mobile Passionné par le développement Android & iOS, j’aide les entreprises à concevoir des applications performantes, scalables et intuitives. Spécialiste en Flutter, Kotlin et Swift, je mets mon expertise au service d’expériences utilisateur optimales.',
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
        ],
      ),
    );
  }

  Widget _buildValueSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ce que je peux vous apporter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.displayMedium?.color)),
          SizedBox(height: 10),
          Text(
            '💼 En tant que développeur mobile, je conçois des applications robustes, maintenables et orientées utilisateur. J’ai une forte sensibilité UI/UX et je collabore facilement avec les équipes produit, design et backend.',
            style: TextStyle(color: Theme.of(context).textTheme.displayMedium?.color),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Projets',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(height: 20),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: selectedProjectIndex == null
                  ? LayoutBuilder(
                key: ValueKey("grid"),
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 1000
                      ? 3
                      : constraints.maxWidth > 600
                      ? 2
                      : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                        childAspectRatio: constraints.maxWidth > 1000
                            ? 3 / 2.5
                            : constraints.maxWidth > 600
                            ? 3 / 2
                            : 3 / 1.8,
                    ),
                    itemCount: widget.projects.length,
                    itemBuilder: (context, index) {
                      return ProjectItem(
                        project: widget.projects[index],
                        onTap: () {
                          setState(() {
                            selectedProjectIndex = index;
                          });
                          _scrollTo(500.0);
                        },
                      );
                    },
                  );
                },
              )
                  : Column(
                key: ValueKey("detail"),
                children: [
                  _buildExpandedProjectView(widget.projects[selectedProjectIndex!]),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedProjectIndex = null;
                      });
                      _scrollTo(500.0);
                    },
                    child: Text("Réduire"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildExpandedProjectView(Map<String, String> project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.asset(
            project['image_asset']!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project['title']!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                project['description']!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 12),

              // Affiche l'animation seulement si elle n'est pas "default.jpg"
              if (project.containsKey('animation') && project['animation'] != 'assets/images/default.jpg')
                Image.asset(
                  project['animation']!,
                  fit: BoxFit.none,
                  filterQuality: FilterQuality.high,
                ),

              SizedBox(height: 12),

              // Affiche le bouton seulement si le lien n'est pas vide
              if (project['link'] != null && project['link']!.trim().isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse(project['link']!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  icon: Icon(Icons.open_in_new),
                  label: Text('Voir le projet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildOpenSourceHighlight() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contributions Open Source & Projets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium?.color)),
          SizedBox(height: 10),
          Text(
            'J’ai contribué à plusieurs projets open-source et participé à la création d’apps durant mes stages et projets freelance. Retrouvez tous mes projets sur mon GitHub :',
            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse(widget.githubUrl)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: Colors.blue.shade800, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.code, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Voir tous mes projets', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contactez-moi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => launchUrl(Uri.parse('mailto:${widget.email}')),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email, color: Colors.white),
                SizedBox(width: 8),
                Text('Envoyer un Email', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(widget.linkedinUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.web, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Voir mon profil LinkedIn', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Pierre Meignan © 2025', style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.2)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onScrollTo: _scrollTo),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              _buildAboutSection(),
              _buildValueSection(),
              _buildProjectsSection(),
              _buildOpenSourceHighlight(),
              _buildContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}
