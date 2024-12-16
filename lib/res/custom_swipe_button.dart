import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSwipeButton extends StatefulWidget {
  final VoidCallback onComplete;
  const CustomSwipeButton({super.key,required this.onComplete});

  @override
  _CustomSwipeButtonState createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton> {
  double _positionX = 0;
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width - 20,
      // height: 50,
      // decoration: BoxDecoration(
      //   color: _completed ? Colors.green : Colors.blue,
      //   borderRadius: BorderRadius.circular(25),
      // ),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _positionX += details.delta.dx;
            if (_positionX >= MediaQuery.of(context).size.width - 100) {
              _completed = true;
            }
          });
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            if (_completed) {
              // ///Page Navigation after successFull ..
              widget.onComplete;
              // Utils.flushBarSuccessMessage('Ride Completed Successfully', context);
            }
            _positionX = 0;
            _completed = false;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 55,
              decoration: BoxDecoration(
                color: _completed ? Colors.green : Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: _completed
                  ? Text(
                'COMPLETED',
                style: GoogleFonts.lato(
                  color: background,
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                ),
              )
                  : Text(
                'SWIPE TO COMPLETE',
                style: GoogleFonts.lato(
                    color: background,
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Positioned(
              left: _positionX.clamp(0.0, MediaQuery.of(context).size.width - 80),
              // left: _positionX,
              child: Container(
                width: 50,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}