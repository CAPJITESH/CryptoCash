import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/models/get_home_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCardHome extends StatefulWidget {
  final Transaction data;
  final bool isLast;
  const TransactionCardHome(
      {super.key, required this.data, required this.isLast});

  @override
  State<TransactionCardHome> createState() => _TransactionCardHomeState();
}

class _TransactionCardHomeState extends State<TransactionCardHome> {
  @override
  void initState() {
    format();
    super.initState();
  }

  String date = "";
  void format() {
    DateTime parsedDate = DateTime.parse(widget.data.date ?? "");

    date = DateFormat('MMMM d H:mm').format(parsedDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: blue2,
                  image: widget.data.myself!
                      ? null
                      : DecorationImage(
                          image: NetworkImage(widget.data.receiverImage!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.myself!
                        ? "Received"
                        : widget.data.to ?? "Error",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: black2,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                widget.data.myself!
                    ? "+${widget.data.amt.toString().substring(0, 3)} ETH"
                    : "-${widget.data.amt.toString().substring(0, 3)} ETH",
                style: TextStyle(
                  color: widget.data.myself! ? green2 : red3,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 26,
                color: black1,
              )
            ],
          ),
        ),
        if (!widget.isLast)
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: black2.withOpacity(0.7),
              height: 1,
              thickness: 0.5,
            ),
          ),
      ],
    );
  }
}
