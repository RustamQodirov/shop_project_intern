import 'package:flutter/material.dart';

import '../../data/models/branch_model.dart';

class BottomDetailsOverlay extends StatelessWidget {
  final Branch branch;

  const BottomDetailsOverlay({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 330,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(branch.logo.isNotEmpty
                          ? branch.logo
                          : 'assets/images/default.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branch.name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        branch.address,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                          color: Color(0xff74747b),
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 5),
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xfff4f4f5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xff4059E6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: const Color(0xff040415).withOpacity(0.1),
              thickness: 1,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF4F4F5),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      branch.address,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff040405),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF4F4F5),
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      branch.phoneNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff62c994),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF4F4F5),
                    ),
                    child: const Icon(
                      Icons.access_time_filled_rounded,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "пн-пт 10:00-21:00, сб-вс 10:00-20:00",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff040405),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}