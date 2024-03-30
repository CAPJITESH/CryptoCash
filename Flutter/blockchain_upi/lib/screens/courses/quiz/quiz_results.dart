import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizResult extends StatefulWidget {
  final int result, total;
  const QuizResult({super.key, required this.result, required this.total});

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/resultBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your score is",
              style: GoogleFonts.odorMeanChey(
                color: Colors.white,
                fontSize: 50,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 16),
            Text("${widget.result} / ${widget.total}",
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 30,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 16),
            if (widget.result == 10)
              Text("Congratulations, you have successfully passed",
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
            if (widget.result > 8 && widget.result < 10)
              Text("Amazing job",
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
            if (widget.result > 5 && widget.result <= 8)
              Text("Good job",
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
            if (widget.result <= 5)
              Text("Well tried!",
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
          ],
        ),
      ),
    );
  }
}