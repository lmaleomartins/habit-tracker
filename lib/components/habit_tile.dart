import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final String habitDescription;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitDescription,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Checkbox
            Checkbox(value: habitCompleted, onChanged: onChanged, activeColor: const Color.fromARGB(255, 0, 174, 86)),

            SizedBox(width: 12),
            
            // Nome e Descrição
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(habitName, softWrap: true,),
                Text(
                  habitDescription,
                  softWrap: true,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

            const Spacer(),

            // Configuração
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => settingsTapped!(context),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTapped!(context),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
