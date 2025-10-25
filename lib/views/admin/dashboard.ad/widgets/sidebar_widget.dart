
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final String fullName;
  final String initials;
  final String email;

  const Sidebar({
    super.key,
    required this.fullName,
    required this.initials,
    required this.email,
  });
  

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.home, 'title': 'Overview'},
    {'icon': Icons.person, 'title': 'Profiles'},
    {'icon': Icons.star, 'title': 'Systems Status'},
    {'icon': Icons.bar_chart, 'title': 'Reports'},
  ];

  @override
  Widget build(BuildContext context) {
      print('fullName: ${widget.fullName}, initials: ${widget.initials}, email: ${widget.email}');
    final sidebarWidth = _isExpanded ? 200.0 : 70.0;
    final sidebarHeight = _isExpanded ? 700.0 : 500.0;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: sidebarHeight,
          width: sidebarWidth,
          decoration: BoxDecoration(
            color: Colors.black26.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ========== TOP SECTION ==========
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: _isExpanded
                          ? Alignment.centerRight
                          : Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          _isExpanded
                              ? Icons.arrow_back_ios
                              : Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (_isExpanded)
                      const Divider(
                        color: Colors.white30,
                        thickness: 0.5,
                        height: 1,
                      ),
                    const SizedBox(height: 15),
                    // Menu items
                    ..._menuItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = _selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(item['icon'], color: Colors.white, size: 26),
                              if (_isExpanded) ...[
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 15),
                    // After menu items divider
                    if (_isExpanded)
                      const Divider(
                        color: Colors.white30,
                        thickness: 1,
                        height: 1,
                      ),
                    // Logout option
                    GestureDetector(
                      onTap: () {
                        // Handle logout logic here
                        print("Logout tapped");
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 26,
                            ),
                            if (_isExpanded) ...[
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  "Logout",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // ========== BOTTOM USER SECTION ==========
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Divider on top
                    const Divider(
                      color: Colors.white30,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 12),
                    // User info row (initials, fullName, email)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left: initials
                          CircleAvatar(
                            backgroundColor: Colors.white.withValues(alpha: 0.3),
                            radius: 20,
                            child: Text(
                              widget.initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (_isExpanded) const SizedBox(width: 10),
                          // Right: fullName + email
                          if (_isExpanded)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.fullName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.email,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
