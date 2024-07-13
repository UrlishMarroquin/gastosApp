import 'package:flutter/material.dart';
import 'package:gastosappg8/db/db_admin.dart';
import 'package:gastosappg8/models/gasto_model.dart';

class ItemGastoWidget extends StatelessWidget {
  GastoModel gasto;
  final VoidCallback refreshCallback;

  ItemGastoWidget({required this.gasto, required this.refreshCallback,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          "assets/images/${gasto.type}.webp",
          // gasto.,
          height: 40,
          width: 40,
        ),
        title: Text(
          gasto.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          gasto.datetime,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),     
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [            
            Text(
              "S/ ${gasto.price}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),// Espacio entre los iconos
            IconButton(
              icon: Icon(
                Icons.delete_sharp,
                color: Colors.blue,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Eliminar'),
                      content: Text('Se desea eliminar ${gasto.title}'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Aceptar'),
                          onPressed: () {
                            DBAdmin().delGasto(gasto.id).then((value) {
                              Navigator.of(context).pop();
                              refreshCallback();
                            });
                          },
                        ),
                        TextButton(
                          child: Text('Cerrar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),                  
          ],
        ),
      ),
    );
  }
}
