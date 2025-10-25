import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class DashboardAD extends StatelessWidget {
  // These fields should come from your user/session/auth state!
  final String fullName;
  final String initials;
  final String email;

  const DashboardAD({
    super.key,
    required this.fullName,
    required this.initials,
    required this.email,
  });


  @override
  Widget build(BuildContext context) {
    const sidebarColor = Color(0xFF4B626C);
    const cardBg1 = Color(0xFFE8F1F3);
    const cardBg2 = Color(0xFFFDE3DA);
    const borderRadius = 20.0;
    const iconBg = Color(0xFFDDE7EA);

    return Scaffold(
      backgroundColor: sidebarColor,
      body: Row(
        children: [
          // Sidebar with real user info
          Sidebar(
            fullName: fullName,
            initials: initials,
            email: email,
          ),
          // Sidebar(
          //   fullName: 'Test Admin',
          //   initials: 'TA',
          //   email: 'admin@gmail.com',
          // ),

          // Main dashboard content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "DASHBOARD",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 2,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: iconBg,
                          child: Icon(Icons.person, color: sidebarColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Statistics Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Visits Card
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: cardBg1,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Visits for today",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "824",
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: const [
                                    Chip(label: Text("Popularity 93")),
                                    SizedBox(width: 8),
                                    Chip(label: Text("General rate 4.7")),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("VIEW FULL STATISTIC"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Popularity Card
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: cardBg2,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Popularity rate",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "87",
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(
                                      Icons.trending_up,
                                      color: Colors.orange,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Your Rate has increased because of your recent update activity. Keep moving forward and get more points!",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Lower Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Finance Performance
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Finance Performance",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "\$12,841",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Monthly income",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 80,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      financeBar("DEC", 40),
                                      financeBar("JAN", 70),
                                      financeBar("FEB", 90),
                                      financeBar("MAR", 60),
                                      financeBar("APR", 90),
                                      financeBar("MAY", 75),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Top Performers
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "TOP performers",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                userPerformTile("Bessie Cooper", "Online", 4.3),
                                userPerformTile("Albert Flores", "Online", 4.7),
                                userPerformTile(
                                  "Guy Hawkins",
                                  "2 minutes ago",
                                  4.4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Targeting By Region
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Targeting by region",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Placeholder for a map or chart
                                Container(
                                  height: 50,
                                  color: cardBg1,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Poland: 23.03%, 4.7",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Finance performance bar widget
  static Widget financeBar(String label, double height) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 16,
            height: height,
            decoration: BoxDecoration(
              color: Colors.lightBlue[300],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // User performer tile widget
  static Widget userPerformTile(String name, String time, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 14, backgroundColor: Colors.blue[100]),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Text(
            score.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
