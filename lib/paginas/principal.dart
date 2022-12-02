import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('MD_Clientes');
//crear cliente
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                ),
                TextField(
                  controller: _direccionController,
                  decoration: const InputDecoration(labelText: 'Direccion'),
                ),
                TextField(
                  controller: _ciudadController,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xff1f005c),
                        Color(0xff5b0060),
                        Color(0xff870160),
                        Color(0xffac255e),
                        Color(0xffca485c),
                        Color(0xffe16b5c),
                        Color(0xfff39060),
                        Color(0xffffb56b),
                      ],
                    )),
                    child: const Center(
                      child: Text(
                        'Crear',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final String sNombreCliente = _nombreController.text;
                    final String sApellidosCliente = _apellidoController.text;
                    final String sDireccionCliente = _direccionController.text;
                    final String sCiudadCliente = _ciudadController.text;
                    if (sNombreCliente.isNotEmpty) {
                      await _clientes.add({
                        "sNombreCliente": sNombreCliente,
                        "sApellidosCliente": sApellidosCliente,
                        "sDireccionCliente": sDireccionCliente,
                        "sCiudadCliente": sCiudadCliente
                      });
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _direccionController.text = '';
                      _ciudadController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  //Actualizar cliente
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nombreController.text = documentSnapshot['sNombreCliente'].toString();
      _apellidoController.text =
          documentSnapshot['sApellidosCliente'].toString();
      _direccionController.text =
          documentSnapshot['sDireccionCliente'].toString();
      _ciudadController.text = documentSnapshot['sCiudadCliente'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                ),
                TextField(
                  controller: _direccionController,
                  decoration: const InputDecoration(labelText: 'Direccion'),
                ),
                TextField(
                  controller: _ciudadController,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xff1f005c),
                        Color(0xff5b0060),
                        Color(0xff870160),
                        Color(0xffac255e),
                        Color(0xffca485c),
                        Color(0xffe16b5c),
                        Color(0xfff39060),
                        Color(0xffffb56b),
                      ],
                    )),
                    child: const Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final String sNombreCliente = _nombreController.text;
                    final String sApellidosCliente = _apellidoController.text;
                    final String sDireccionCliente = _direccionController.text;
                    final String sCiudadCliente = _ciudadController.text;
                    if (sNombreCliente.isNotEmpty) {
                      await _clientes.doc(documentSnapshot!.id).update({
                        "sNombreCliente": sNombreCliente,
                        "sApellidosCliente": sApellidosCliente,
                        "sDireccionCliente": sDireccionCliente,
                        "sCiudadCliente": sCiudadCliente
                      });
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _direccionController.text = '';
                      _ciudadController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  //borrar clientes
  Future<void> _delete(String clientId) async {
    await _clientes.doc(clientId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('El cliente fue eliminado correctamente'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Parcial 4"),
        ),
      ),
      body: StreamBuilder(
        stream: _clientes.snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['sNombreCliente'].toString()),
                    subtitle:
                        Text(documentSnapshot['sApellidosCliente'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _update(documentSnapshot),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _delete(documentSnapshot.id),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _create()),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
