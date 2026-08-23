class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const login = '/login';
  static const register = '/register';
  static const logout = '/logout';
  static const me = '/me';
  static const googleLogin = '/auth/google';
  static const googleRedirect = '/auth/google/redirect';
  static const googleSelectTenant = '/auth/google/select-tenant';
  static const forgotPassword = '/forgot-password';

  // Perfil del comercio
  static const tenant = '/tenant';
  static const tenantLogo = '/tenant/logo';

  // Empleados (solo admin_comercio)
  static const empleados = '/empleados';
  static String empleado(String id) => '/empleados/$id';
  static const empleadosComisiones = '/empleados/comisiones';

  // Mercado Pago del comercio (marketplace) — para cobrar sus propias
  // ventas con Point, distinto de la suscripción hacia Code & Lens.
  static const mercadoPagoConnect = '/tenant/mercadopago/connect';
  static const mercadoPagoStatus = '/tenant/mercadopago/status';
  static const mercadoPagoDisconnect = '/tenant/mercadopago/disconnect';
  static const mercadoPagoDevices = '/tenant/mercadopago/devices';
  static const mercadoPagoPaymentIntent = '/tenant/mercadopago/payment-intent';
  static String mercadoPagoPaymentIntentStatus(String id) =>
      '/tenant/mercadopago/payment-intent/$id';

  // Artículos
  static const articulos = '/articulos';
  static String articulo(String id) => '/articulos/$id';
  static String articuloMovimientos(String id) => '/articulos/$id/movimientos';
  static String articuloAjustarStock(String id) => '/articulos/$id/ajustar-stock';
  static String articuloBuscarCodigo(String codigo) => '/articulos/buscar-codigo/$codigo';
  static const articulosExportar = '/articulos/exportar';
  static const articulosImportar = '/articulos/importar';
  static const articulosActualizarPreciosMasivo = '/articulos/actualizar-precios-masivo';

  // Clientes
  static const clientes = '/clientes';
  static String cliente(String id) => '/clientes/$id';
  static String clienteVentas(String id) => '/clientes/$id/ventas';
  static String clienteEstadisticas(String id) => '/clientes/$id/estadisticas';
  static String clienteCuentaCorriente(String id) => '/clientes/$id/cuenta-corriente';
  static String clientePagos(String id) => '/clientes/$id/pagos';

  // Suscripción
  static const subscription = '/subscription';
  static const subscriptionCheckout = '/subscription/checkout';

  // Ventas
  static const ventas = '/ventas';
  static const ventasEstadisticas = '/ventas/estadisticas';
  static const ventasProductosMasVendidos = '/ventas/productos-mas-vendidos';
  static const ventasEstadisticasMensuales = '/ventas/estadisticas-mensuales';
  static String venta(String id) => '/ventas/$id';
  static String ventaAnular(String id) => '/ventas/$id/anular';
  static String ventaNotasCredito(String id) => '/ventas/$id/notas-credito';

  // Notas de crédito
  static const notasCredito = '/notas-credito';
  static String notaCredito(String id) => '/notas-credito/$id';

  // Presupuestos
  static const presupuestos = '/presupuestos';
  static String presupuesto(String id) => '/presupuestos/$id';
  static String presupuestoConvertirVenta(String id) => '/presupuestos/$id/convertir-venta';
  static String presupuestoAnular(String id) => '/presupuestos/$id/anular';

  // Remitos
  static const remitos = '/remitos';
  static String remito(String id) => '/remitos/$id';
  static String remitoConvertirVenta(String id) => '/remitos/$id/convertir-venta';
  static String remitoAnular(String id) => '/remitos/$id/anular';

  // Sesiones de emparejamiento celular↔PC (lector remoto de código de barras)
  static const sesionesPos = '/sesiones-pos';
  static const sesionesPosParear = '/sesiones-pos/parear';
  static String sesionPosScan(String id) => '/sesiones-pos/$id/scan';
  static String sesionPos(String id) => '/sesiones-pos/$id';

  // Caja
  static const cajaActual = '/caja/actual';
  static const cajaHistorial = '/caja/historial';
  static const cajaAbrir = '/caja/abrir';
  static const cajaMovimiento = '/caja/movimiento';
  static const cajaCerrar = '/caja/cerrar';

  // Sync offline
  static const syncPull = '/sync/pull';
  static const syncPush = '/sync/push';

  // Dispositivos (cajas/mostradores) — solo admin_comercio
  static const dispositivos = '/dispositivos';
  static String dispositivoDesactivar(String id) => '/dispositivos/$id/desactivar';
  static String dispositivoReactivar(String id) => '/dispositivos/$id/reactivar';

  // Proveedores
  static const proveedores = '/proveedores';
  static String proveedor(String id) => '/proveedores/$id';
  static String proveedorCompras(String id) => '/proveedores/$id/compras';
  static String proveedorCuentaCorriente(String id) => '/proveedores/$id/cuenta-corriente';
  static String proveedorPagos(String id) => '/proveedores/$id/pagos';

  // Compras
  static const compras = '/compras';
  static String compra(String id) => '/compras/$id';
  static String compraAnular(String id) => '/compras/$id/anular';

  // Reportes
  static const reporteVentasPorRubro = '/reportes/ventas-por-rubro';
  static const reporteVentasPorMarca = '/reportes/ventas-por-marca';
  static const reporteVentasPorZona = '/reportes/ventas-por-zona';
  static const reporteVentasPorVendedor = '/reportes/ventas-por-vendedor';
}
