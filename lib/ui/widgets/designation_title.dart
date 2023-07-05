import 'package:flutter/material.dart';

class DesignationTitleWidget extends StatelessWidget {
  const DesignationTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white),
      height: 240,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Product Designer',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context, 'Product Designer');
            },
          ),
          ListTile(
            title: const Text(
              'Flutter Developer',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context, 'Flutter Developer');
            },
          ),
          ListTile(
            title: const Text(
              'QA tester',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context, 'QA tester');
            },
          ),
          ListTile(
            title: const Text(
              'Product Owner',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context, 'Product Owner');
            },
          ),
        ],
      ),
    );
  }
}
