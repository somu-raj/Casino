import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TambolaGameProvider.dart';

class TambolaGameScreen extends StatelessWidget {
  const TambolaGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambola Game'),
      ),
      body: const Column(
        children: [
          TicketDisplay(),
          SizedBox(height: 20),
          CalledNumbersDisplay(),
          SizedBox(height: 20),
          CallNumberButton(),
        ],
      ),
    );
  }
}

class TicketDisplay extends StatelessWidget {
  const TicketDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var ticket = context.watch<TambolaGameProvider>().ticket;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: ticket.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((num) {
              return num != 0 ? Text('$num', style: const TextStyle(fontSize: 24)) : const Text(' ', style: TextStyle(fontSize: 24));
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class CalledNumbersDisplay extends StatelessWidget {
  const CalledNumbersDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var calledNumbers = context.watch<TambolaGameProvider>().calledNumbers;
    return SizedBox(
      height: 100,
      child: GridView.count(
        crossAxisCount: 10,
        children: calledNumbers.map((num) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(2),
            color: Colors.blueAccent,
            child: Text('$num', style: const TextStyle(color: Colors.white)),
          );
        }).toList(),
      ),
    );
  }
}

class CallNumberButton extends StatelessWidget {
  const CallNumberButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<TambolaGameProvider>().callNumber();
      },
      child: const Text('Call Number'),
    );
  }
}
