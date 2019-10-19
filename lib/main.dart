import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  final List<Transfer> _transferList = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => navigate(context, _transferList),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _transferList.length,
        itemBuilder: (context, index) {
          final transfer = _transferList[index];
          return TransferItem(transfer);
        },
      ),
    );
  }

  void navigate(BuildContext context, List<Transfer> transferList) {
    final Future<Transfer> future =
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TransferForm();
    }));

    future.then((newTransfer) {
      transferList.add(newTransfer);
    });
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.attach_money),
        title: Text(_transfer.transferValue.toStringAsFixed(2)),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double transferValue;
  final int accountNumber;

  Transfer(this.transferValue, this.accountNumber);

  @override
  String toString() {
    return 'Transfer {transferValue: $transferValue, accountNumber: $accountNumber}';
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _accountNumberControlller =
      TextEditingController();
  final TextEditingController _valueControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar transferência'),
      ),
      body: Column(
        children: <Widget>[
          TextEditor(
            controller: _accountNumberControlller,
            label: 'Número da conta',
            hint: '0000',
          ),
          TextEditor(
            controller: _valueControlller,
            icon: Icons.attach_money,
            label: 'Valor',
            hint: '100.00',
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: RaisedButton(
              color: Colors.lightBlue,
              onPressed: () => createTransfer(context),
              child: Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(_accountNumberControlller.text);
    final double transferValue = double.tryParse(_valueControlller.text);

    if (accountNumber != null && transferValue != null) {
      final newTransfer = Transfer(transferValue, accountNumber);
      Navigator.pop(context, newTransfer);
    }
  }
}

class TextEditor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  TextEditor({this.controller, this.label, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
