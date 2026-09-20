void main() {
  // Variables con tipo explicito.
  String nombreCliente = 'Ana Lopez';
  String tipoCliente = 'estudiante';
  int numeroFactura = 1001;
  bool compraFinalizada = false;

  // Null safety.
  String? correo;
  String? cupon = 'UMES10';

  // Constante.
  const double porcentajeIva = 0.12;

  // Final: se asigna una sola vez en tiempo de ejecucion.
  final DateTime fechaCompra = DateTime.now();

  // Inferencia de tipo.
  var nombreTienda = 'Tienda Universitaria UMES';

  // Dynamic: puede cambiar de tipo[cite: 1].
  dynamic referenciaPago = 'PENDIENTE';

  // Sintaxis de lista de mapas tipada
  final productos = <Map<String, dynamic>>[
    {
      'nombre': 'Cuaderno',
      'categoria': 'Papeleria',
      'precio': 25.0,
      'cantidad': 3,
    },
    {
      'nombre': 'Memoria USB',
      'categoria': 'Tecnologia',
      'precio': 85.0,
      'cantidad': 1,
    },
    {
      'nombre': 'Libro de Dart',
      'categoria': 'Libros',
      'precio': 120.0,
      'cantidad': 2,
    },
  ];

  const cupones = <String, double>{
    'UMES10': 0.10,
    'LIBRO5': 0.05,
    'DOCENTE15': 0.15,
  };

  // TODO 1: mostrar los productos[cite: 1].
  mostrarProductos(productos);

  // TODO 2: calcular el subtotal[cite: 1].
  double subtotal = calcularSubtotal(productos);

  // TODO 3: obtener el descuento segun el tipo de cliente[cite: 1].
  double descuentoCliente = obtenerDescuentoCliente(tipoCliente);

  // TODO 4: obtener el descuento del cupon aplicando null safety[cite: 1].
  double descuentoCupon = 0.0;
  if (cupon != null && cupones.containsKey(cupon)) {
    descuentoCupon = cupones[cupon]!;
  }

  // TODO 5: calcular el porcentaje total de descuento[cite: 1].
  double porcentajeDescuento = descuentoCliente + descuentoCupon;

  if (porcentajeDescuento > 0.25) {
    porcentajeDescuento = 0.25;
  }

  // TODO 6: calcular el valor monetario del descuento[cite: 1].
  double valorDescuento = subtotal * porcentajeDescuento;

  // TODO 7: calcular el subtotal despues del descuento[cite: 1].
  double subtotalConDescuento = subtotal - valorDescuento;

  // TODO 8: calcular el IVA[cite: 1].
  double impuesto = subtotalConDescuento * porcentajeIva;

  // TODO 9: llamar a calcularTotal con parametros nombrados[cite: 1].
  double total = calcularTotal(
    subtotal: subtotal,
    porcentajeDescuento: porcentajeDescuento,
    porcentajeIva: porcentajeIva,
  );

  // El dato dynamic cambia de String a int[cite: 1].
  referenciaPago = 45892;
  compraFinalizada = true;

  // TODO 10: obtener categorias sin repetir usando Set[cite: 1].
  final categorias = productos.map((p) => p['categoria'] as String).toSet();

  // TODO 11: mostrar la factura[cite: 1].
  mostrarFactura(
    numeroFactura: numeroFactura,
    cliente: nombreCliente,
    correo: correo,
    cupon: cupon,
    subtotal: subtotal,
    descuento: valorDescuento,
    impuesto: impuesto,
    total: total,
  );

  print('Tienda: $nombreTienda');
  print('Fecha: $fechaCompra');
  print('Referencia: $referenciaPago');
  print('Compra finalizada: $compraFinalizada');
  print('Categorias: $categorias');

  // TODO 12: usar if para mostrar un mensaje especial[cite: 1].
  if (total > 350) {
    print('Compra mayor de Q350: recibe envio gratuito.');
  }
}


double calcularSubtotal(List<Map<String, dynamic>> productos) {
  double subtotal = 0.0;
  for (var prod in productos) {
    subtotal += (prod['precio'] as double) * (prod['cantidad'] as int);
  }
  return subtotal;
}

double obtenerDescuentoCliente(String tipoCliente) {
  double descuento = 0.0;
  switch (tipoCliente.toLowerCase()) {
    case 'estudiante':
      descuento = 0.08;
      break;
    case 'docente':
      descuento = 0.12;
      break;
    case 'visitante':
      descuento = 0.0;
      break;
    default:
      descuento = 0.0;
      break;
  }
  return descuento;
}

double calcularTotal({
  required double subtotal,
  required double porcentajeDescuento,
  required double porcentajeIva,
}) {
  double subtotalConDescuento = subtotal * (1 - porcentajeDescuento);
  double impuesto = subtotalConDescuento * porcentajeIva;
  return subtotalConDescuento + impuesto;
}

void mostrarProductos(List<Map<String, dynamic>> productos) {
  print('PRODUCTOS');
  for (var p in productos) {
    String nombre = p['nombre'];
    int cantidad = p['cantidad'];
    double precio = p['precio'];
    double subtotalProd = precio * cantidad;
    print('$nombre: \t$cantidad x Q${precio.toStringAsFixed(2)} = \tQ${subtotalProd.toStringAsFixed(2)}');
  }
  print('');
}

void mostrarFactura({
  required int numeroFactura,
  required String cliente,
  String? correo,
  String? cupon,
  required double subtotal,
  required double descuento,
  required double impuesto,
  required double total,
}) {
  print('\nFACTURA No. $numeroFactura');
  print('Cliente: $cliente');
  // Null safety mediante el operador ??[cite: 1].
  print('Correo: ${correo ?? 'No registrado'}');
  print('Cupon: ${cupon ?? 'Sin cupon'}');
  print('Subtotal: Q${subtotal.toStringAsFixed(2)}');
  print('Descuento: Q${descuento.toStringAsFixed(2)}');
  print('IVA: Q${impuesto.toStringAsFixed(2)}');
  print('Total: Q${total.toStringAsFixed(2)}');
}