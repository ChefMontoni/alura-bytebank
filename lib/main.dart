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

class TransferList extends StatefulWidget {
  final List<Transfer> _transferList = List();

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));

          future.then((newTransfer) {
            if (newTransfer != null) {
              setState(() {
                widget._transferList.add(newTransfer);
              });
            }
          });
        },
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(6.0),
        itemCount: widget._transferList.length,
        itemBuilder: (context, index) {
          final transfer = widget._transferList[index];
          return TransferItem(transfer);
        },
      ),
    );
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

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumberRef = TextEditingController();
  final TextEditingController _valueRef = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextEditor(
              controller: _accountNumberRef,
              label: 'Número da conta',
              hint: '0000',
            ),
            TextEditor(
              controller: _valueRef,
              icon: Icons.attach_money,
              label: 'Valor',
              hint: '100.00',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: RaisedButton(
                color: Colors.lightBlue,
                onPressed: () => _createTransfer(context),
                child: Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(_accountNumberRef.text);
    final double transferValue = double.tryParse(_valueRef.text);

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
