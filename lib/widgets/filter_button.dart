import 'package:flutter/material.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.value,
    this.icon,
  });

  final String text;
  final bool isSelected;
  final onTap;
  final value;
  final icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 100,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? kAppBarBackground : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            width: value != null ? 115 : 110,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: icon != null
                        ? icon.contains('http')
                            ? Image.network(
                                icon,
                                width: 40,
                                height: 30,
                              )
                            : Image.asset(
                                icon,
                                color: isSelected ? Colors.white : null,
                                width: 40,
                                height: 30,
                              )
                        : Image.asset(
                            text == 'Të gjitha bashkitë'
                                ? 'assets/icons/instuticion_kandidat.png'
                                : text == 'Zyrtar/e'
                                    ? 'assets/icons/kandidat.png'
                                    : text == "Të gjithë"
                                        ? 'assets/icons/instuticion_kandidat.png'
                                        : 'assets/icons/institucioni.png',
                            color: isSelected ? Colors.white : null,
                            width: 40,
                            height: 30,
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text + (value != null ? ' (${value.toString()})' : ''),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
