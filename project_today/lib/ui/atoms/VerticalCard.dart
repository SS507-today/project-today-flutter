import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  final String? imgPath;
  final String? desc;
  final VoidCallback? onPressed;
  final bool isLoading;

  const VerticalCard({
    super.key,
    required this.isLoading,
    this.imgPath,
    this.desc,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: isLoading ? _buildSkeleton() : _buildContent(),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 158.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: 120.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              image: DecorationImage(
                image: AssetImage(imgPath!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 67.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.63),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14.0),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              desc!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
