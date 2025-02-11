import 'package:flutter/material.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              _buildSection('Meet Our Team:', _buildTeamInfo()),
              _buildSection('About ASWDC:', _buildAboutASWDC()),
              _buildSection('Contact Us:', _buildContactInfo()),
              _buildSection('More Options:', _buildAdditionalLinks()),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.redAccent,
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                height: 105,
                width: 105,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Parinay Matrimony",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF1704),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF1710),
              ),
            ),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo() {
    return Column(
      children:[
        _buildInfoRow('Developed by:', 'Ayush Maradia (23010101159)'),
        _buildInfoRow('Mentored by:', 'Prof. Mehul Bhundiya (Computer Engineering)'),
        _buildInfoRow('Explored by:', 'ASWDC, School Of Computer Science'),
        _buildInfoRow('Eulogized by:', 'Darshan University, Rajkot, Gujarat - INDIA'),
      ],
    );
  }

  Widget _buildAboutASWDC() {
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              'https://scontent.fraj2-1.fna.fbcdn.net/v/t39.30808-6/306781005_511047894359680_6012666892421775330_n.png?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=WFUN6a7go9kQ7kNvgHhyRkS&_nc_oc=AdhA7GAFFTCW9Gy5yocH_0G7Os3Mdlgs_8hzTLqs_nfuwd_vV8o0KsRS92ugy-Q9nbKU2bXEFfx8sr6p4RPI_hkq&_nc_zt=23&_nc_ht=scontent.fraj2-1.fna&_nc_gid=Al4eNQT9ecm_iWg0QYJhnMO&oh=00_AYC63F9nDRwbCqX0abnulfTXEuXYbEYZf0mkrlR0YKhaug&oe=67B15071',
              height: 120,
              fit: BoxFit.contain,
            ),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyJclgXfX52jUN8XxpgpjSxX9RS-XVXZkp4g&s',
              height: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'ASWDC is an Application, Software, and Website Development Center @ Darshan University.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children:[
        _buildContactRow(Icons.email_rounded, 'aswdc@datshan.ac.in'),
        _buildContactRow(Icons.call, '+91-9727747317'),
        _buildContactRow(Icons.language_rounded, 'www.datshan.ac.in'),
      ],
    );
  }

  Widget _buildAdditionalLinks() {
    return Column(
      children:[
        _buildContactRow(Icons.share, 'Share App'),
        _buildContactRow(Icons.grid_view, 'More Apps'),
        _buildContactRow(Icons.star_rate_outlined, 'Rate Us'),
        _buildContactRow(Icons.thumb_up_alt_rounded, 'Like us on Facebook'),
        _buildContactRow(Icons.refresh, 'Check For Update'),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: const [
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.copyright_outlined, size: 20),
            Text(' 2025 Darshan University', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        Text('All Rights Reserved - Privacy Policy', style: TextStyle(fontSize: 16)),
        Text('Made with ❤️ in India', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold,)),
          ),
        ],
      ),
    );
  }

  static Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}