import 'package:bytebank/screens/transfer/form.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transferências';

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
        title: Text(_appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TransferForm();
            }),
          ).then(
            (newTransfer) => addNewTransfer(newTransfer),
          );
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

  void addNewTransfer(Transfer newTransfer) {
    if (newTransfer != null) {
      setState(() {
        widget._transferList.add(newTransfer);
      });
    }
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.attach_money, size: 40),
        title: Text(_transfer.transferValue.toStringAsFixed(2)),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}
