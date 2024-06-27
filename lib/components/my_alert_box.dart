import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Entrada de nome
          Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: const TextSelectionThemeData(
                selectionColor: Color.fromARGB(80, 31, 209, 31)
              )
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: nameController,
              cursorColor: const Color.fromARGB(255, 94, 94, 94),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Color.fromARGB(255, 190, 190, 190)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))
              ),
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          // Entrada de descrição
          Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: const TextSelectionThemeData(
                selectionColor: Color.fromARGB(80, 31, 209, 31)
              )
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: descriptionController,
              cursorColor: const Color.fromARGB(255, 94, 94, 94),
              decoration: const InputDecoration(
                hintText: 'Descrição...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 190, 190, 190)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))
              ),
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Salvar
              MaterialButton(
                onPressed: onSave,
                color: const Color.fromARGB(255, 110, 110, 110),
                child: const Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(width: 10),

              // Cancelar
              MaterialButton(
                onPressed: onCancel,
                color: const Color.fromARGB(255, 110, 110, 110),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
