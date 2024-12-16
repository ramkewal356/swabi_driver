import 'package:flutter/material.dart';

class PageLayoutPlain extends StatefulWidget {
  const PageLayoutPlain({super.key});

  @override
  State<PageLayoutPlain> createState() => _PageLayoutPlainState();
}

class _PageLayoutPlainState extends State<PageLayoutPlain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40,),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0, 5),
                    spreadRadius: 0
                  )
                ],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all()
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
