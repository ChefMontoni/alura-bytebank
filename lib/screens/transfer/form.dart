import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/components/text_editor.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Criar transferência';
const _accountNumberLabel = 'Número da conta';
const _accountNumberHint = '4579';
const _valueLabel = 'Valor';
const _valueHint = '100.00';
const _buttonText = 'Confirmar';

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
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextEditor(
              controller: _accountNumberRef,
              label: _accountNumberLabel,
              hint: _accountNumberHint,
            ),
            TextEditor(
              controller: _valueRef,
              icon: Icons.attach_money,
              label: _valueLabel,
              hint: _valueHint,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: RaisedButton(
                onPressed: () => _createTransfer(context),
                child: Text(_buttonText),
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
