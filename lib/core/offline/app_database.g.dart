// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalArticulosTable extends LocalArticulos
    with TableInfo<$LocalArticulosTable, LocalArticulo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalArticulosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codigoBarrasMeta = const VerificationMeta(
    'codigoBarras',
  );
  @override
  late final GeneratedColumn<String> codigoBarras = GeneratedColumn<String>(
    'codigo_barras',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codigoInternoMeta = const VerificationMeta(
    'codigoInterno',
  );
  @override
  late final GeneratedColumn<String> codigoInterno = GeneratedColumn<String>(
    'codigo_interno',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
    'marca',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rubroMeta = const VerificationMeta('rubro');
  @override
  late final GeneratedColumn<String> rubro = GeneratedColumn<String>(
    'rubro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagenUrlMeta = const VerificationMeta(
    'imagenUrl',
  );
  @override
  late final GeneratedColumn<String> imagenUrl = GeneratedColumn<String>(
    'imagen_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precioCostoMeta = const VerificationMeta(
    'precioCosto',
  );
  @override
  late final GeneratedColumn<int> precioCosto = GeneratedColumn<int>(
    'precio_costo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioVentaMeta = const VerificationMeta(
    'precioVenta',
  );
  @override
  late final GeneratedColumn<int> precioVenta = GeneratedColumn<int>(
    'precio_venta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioPromocionalMeta = const VerificationMeta(
    'precioPromocional',
  );
  @override
  late final GeneratedColumn<int> precioPromocional = GeneratedColumn<int>(
    'precio_promocional',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promocionDesdeMeta = const VerificationMeta(
    'promocionDesde',
  );
  @override
  late final GeneratedColumn<DateTime> promocionDesde =
      GeneratedColumn<DateTime>(
        'promocion_desde',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _promocionHastaMeta = const VerificationMeta(
    'promocionHasta',
  );
  @override
  late final GeneratedColumn<DateTime> promocionHasta =
      GeneratedColumn<DateTime>(
        'promocion_hasta',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _stockActualMeta = const VerificationMeta(
    'stockActual',
  );
  @override
  late final GeneratedColumn<int> stockActual = GeneratedColumn<int>(
    'stock_actual',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _pendienteSyncMeta = const VerificationMeta(
    'pendienteSync',
  );
  @override
  late final GeneratedColumn<bool> pendienteSync = GeneratedColumn<bool>(
    'pendiente_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pendiente_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    codigoBarras,
    codigoInterno,
    descripcion,
    marca,
    rubro,
    imagenUrl,
    precioCosto,
    precioVenta,
    precioPromocional,
    promocionDesde,
    promocionHasta,
    activo,
    stockActual,
    version,
    pendienteSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_articulos';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalArticulo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('codigo_barras')) {
      context.handle(
        _codigoBarrasMeta,
        codigoBarras.isAcceptableOrUnknown(
          data['codigo_barras']!,
          _codigoBarrasMeta,
        ),
      );
    }
    if (data.containsKey('codigo_interno')) {
      context.handle(
        _codigoInternoMeta,
        codigoInterno.isAcceptableOrUnknown(
          data['codigo_interno']!,
          _codigoInternoMeta,
        ),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
        _marcaMeta,
        marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta),
      );
    }
    if (data.containsKey('rubro')) {
      context.handle(
        _rubroMeta,
        rubro.isAcceptableOrUnknown(data['rubro']!, _rubroMeta),
      );
    }
    if (data.containsKey('imagen_url')) {
      context.handle(
        _imagenUrlMeta,
        imagenUrl.isAcceptableOrUnknown(data['imagen_url']!, _imagenUrlMeta),
      );
    }
    if (data.containsKey('precio_costo')) {
      context.handle(
        _precioCostoMeta,
        precioCosto.isAcceptableOrUnknown(
          data['precio_costo']!,
          _precioCostoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioCostoMeta);
    }
    if (data.containsKey('precio_venta')) {
      context.handle(
        _precioVentaMeta,
        precioVenta.isAcceptableOrUnknown(
          data['precio_venta']!,
          _precioVentaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioVentaMeta);
    }
    if (data.containsKey('precio_promocional')) {
      context.handle(
        _precioPromocionalMeta,
        precioPromocional.isAcceptableOrUnknown(
          data['precio_promocional']!,
          _precioPromocionalMeta,
        ),
      );
    }
    if (data.containsKey('promocion_desde')) {
      context.handle(
        _promocionDesdeMeta,
        promocionDesde.isAcceptableOrUnknown(
          data['promocion_desde']!,
          _promocionDesdeMeta,
        ),
      );
    }
    if (data.containsKey('promocion_hasta')) {
      context.handle(
        _promocionHastaMeta,
        promocionHasta.isAcceptableOrUnknown(
          data['promocion_hasta']!,
          _promocionHastaMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('stock_actual')) {
      context.handle(
        _stockActualMeta,
        stockActual.isAcceptableOrUnknown(
          data['stock_actual']!,
          _stockActualMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('pendiente_sync')) {
      context.handle(
        _pendienteSyncMeta,
        pendienteSync.isAcceptableOrUnknown(
          data['pendiente_sync']!,
          _pendienteSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalArticulo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalArticulo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      codigoBarras: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo_barras'],
      ),
      codigoInterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo_interno'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      marca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marca'],
      ),
      rubro: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rubro'],
      ),
      imagenUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imagen_url'],
      ),
      precioCosto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_costo'],
      )!,
      precioVenta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_venta'],
      )!,
      precioPromocional: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_promocional'],
      ),
      promocionDesde: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}promocion_desde'],
      ),
      promocionHasta: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}promocion_hasta'],
      ),
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      stockActual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_actual'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      pendienteSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pendiente_sync'],
      )!,
    );
  }

  @override
  $LocalArticulosTable createAlias(String alias) {
    return $LocalArticulosTable(attachedDatabase, alias);
  }
}

class LocalArticulo extends DataClass implements Insertable<LocalArticulo> {
  final String id;
  final String? codigoBarras;
  final String? codigoInterno;
  final String descripcion;
  final String? marca;
  final String? rubro;
  final String? imagenUrl;
  final int precioCosto;
  final int precioVenta;
  final int? precioPromocional;
  final DateTime? promocionDesde;
  final DateTime? promocionHasta;
  final bool activo;

  /// Último stock conocido — lo calcula siempre el backend (suma de
  /// movimientos), acá es solo un valor cacheado para mostrar offline.
  final int? stockActual;
  final int version;

  /// true = esta fila tiene cambios locales que todavía no se subieron.
  final bool pendienteSync;
  const LocalArticulo({
    required this.id,
    this.codigoBarras,
    this.codigoInterno,
    required this.descripcion,
    this.marca,
    this.rubro,
    this.imagenUrl,
    required this.precioCosto,
    required this.precioVenta,
    this.precioPromocional,
    this.promocionDesde,
    this.promocionHasta,
    required this.activo,
    this.stockActual,
    required this.version,
    required this.pendienteSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || codigoBarras != null) {
      map['codigo_barras'] = Variable<String>(codigoBarras);
    }
    if (!nullToAbsent || codigoInterno != null) {
      map['codigo_interno'] = Variable<String>(codigoInterno);
    }
    map['descripcion'] = Variable<String>(descripcion);
    if (!nullToAbsent || marca != null) {
      map['marca'] = Variable<String>(marca);
    }
    if (!nullToAbsent || rubro != null) {
      map['rubro'] = Variable<String>(rubro);
    }
    if (!nullToAbsent || imagenUrl != null) {
      map['imagen_url'] = Variable<String>(imagenUrl);
    }
    map['precio_costo'] = Variable<int>(precioCosto);
    map['precio_venta'] = Variable<int>(precioVenta);
    if (!nullToAbsent || precioPromocional != null) {
      map['precio_promocional'] = Variable<int>(precioPromocional);
    }
    if (!nullToAbsent || promocionDesde != null) {
      map['promocion_desde'] = Variable<DateTime>(promocionDesde);
    }
    if (!nullToAbsent || promocionHasta != null) {
      map['promocion_hasta'] = Variable<DateTime>(promocionHasta);
    }
    map['activo'] = Variable<bool>(activo);
    if (!nullToAbsent || stockActual != null) {
      map['stock_actual'] = Variable<int>(stockActual);
    }
    map['version'] = Variable<int>(version);
    map['pendiente_sync'] = Variable<bool>(pendienteSync);
    return map;
  }

  LocalArticulosCompanion toCompanion(bool nullToAbsent) {
    return LocalArticulosCompanion(
      id: Value(id),
      codigoBarras: codigoBarras == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoBarras),
      codigoInterno: codigoInterno == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoInterno),
      descripcion: Value(descripcion),
      marca: marca == null && nullToAbsent
          ? const Value.absent()
          : Value(marca),
      rubro: rubro == null && nullToAbsent
          ? const Value.absent()
          : Value(rubro),
      imagenUrl: imagenUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imagenUrl),
      precioCosto: Value(precioCosto),
      precioVenta: Value(precioVenta),
      precioPromocional: precioPromocional == null && nullToAbsent
          ? const Value.absent()
          : Value(precioPromocional),
      promocionDesde: promocionDesde == null && nullToAbsent
          ? const Value.absent()
          : Value(promocionDesde),
      promocionHasta: promocionHasta == null && nullToAbsent
          ? const Value.absent()
          : Value(promocionHasta),
      activo: Value(activo),
      stockActual: stockActual == null && nullToAbsent
          ? const Value.absent()
          : Value(stockActual),
      version: Value(version),
      pendienteSync: Value(pendienteSync),
    );
  }

  factory LocalArticulo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalArticulo(
      id: serializer.fromJson<String>(json['id']),
      codigoBarras: serializer.fromJson<String?>(json['codigoBarras']),
      codigoInterno: serializer.fromJson<String?>(json['codigoInterno']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      marca: serializer.fromJson<String?>(json['marca']),
      rubro: serializer.fromJson<String?>(json['rubro']),
      imagenUrl: serializer.fromJson<String?>(json['imagenUrl']),
      precioCosto: serializer.fromJson<int>(json['precioCosto']),
      precioVenta: serializer.fromJson<int>(json['precioVenta']),
      precioPromocional: serializer.fromJson<int?>(json['precioPromocional']),
      promocionDesde: serializer.fromJson<DateTime?>(json['promocionDesde']),
      promocionHasta: serializer.fromJson<DateTime?>(json['promocionHasta']),
      activo: serializer.fromJson<bool>(json['activo']),
      stockActual: serializer.fromJson<int?>(json['stockActual']),
      version: serializer.fromJson<int>(json['version']),
      pendienteSync: serializer.fromJson<bool>(json['pendienteSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'codigoBarras': serializer.toJson<String?>(codigoBarras),
      'codigoInterno': serializer.toJson<String?>(codigoInterno),
      'descripcion': serializer.toJson<String>(descripcion),
      'marca': serializer.toJson<String?>(marca),
      'rubro': serializer.toJson<String?>(rubro),
      'imagenUrl': serializer.toJson<String?>(imagenUrl),
      'precioCosto': serializer.toJson<int>(precioCosto),
      'precioVenta': serializer.toJson<int>(precioVenta),
      'precioPromocional': serializer.toJson<int?>(precioPromocional),
      'promocionDesde': serializer.toJson<DateTime?>(promocionDesde),
      'promocionHasta': serializer.toJson<DateTime?>(promocionHasta),
      'activo': serializer.toJson<bool>(activo),
      'stockActual': serializer.toJson<int?>(stockActual),
      'version': serializer.toJson<int>(version),
      'pendienteSync': serializer.toJson<bool>(pendienteSync),
    };
  }

  LocalArticulo copyWith({
    String? id,
    Value<String?> codigoBarras = const Value.absent(),
    Value<String?> codigoInterno = const Value.absent(),
    String? descripcion,
    Value<String?> marca = const Value.absent(),
    Value<String?> rubro = const Value.absent(),
    Value<String?> imagenUrl = const Value.absent(),
    int? precioCosto,
    int? precioVenta,
    Value<int?> precioPromocional = const Value.absent(),
    Value<DateTime?> promocionDesde = const Value.absent(),
    Value<DateTime?> promocionHasta = const Value.absent(),
    bool? activo,
    Value<int?> stockActual = const Value.absent(),
    int? version,
    bool? pendienteSync,
  }) => LocalArticulo(
    id: id ?? this.id,
    codigoBarras: codigoBarras.present ? codigoBarras.value : this.codigoBarras,
    codigoInterno: codigoInterno.present
        ? codigoInterno.value
        : this.codigoInterno,
    descripcion: descripcion ?? this.descripcion,
    marca: marca.present ? marca.value : this.marca,
    rubro: rubro.present ? rubro.value : this.rubro,
    imagenUrl: imagenUrl.present ? imagenUrl.value : this.imagenUrl,
    precioCosto: precioCosto ?? this.precioCosto,
    precioVenta: precioVenta ?? this.precioVenta,
    precioPromocional: precioPromocional.present
        ? precioPromocional.value
        : this.precioPromocional,
    promocionDesde: promocionDesde.present
        ? promocionDesde.value
        : this.promocionDesde,
    promocionHasta: promocionHasta.present
        ? promocionHasta.value
        : this.promocionHasta,
    activo: activo ?? this.activo,
    stockActual: stockActual.present ? stockActual.value : this.stockActual,
    version: version ?? this.version,
    pendienteSync: pendienteSync ?? this.pendienteSync,
  );
  LocalArticulo copyWithCompanion(LocalArticulosCompanion data) {
    return LocalArticulo(
      id: data.id.present ? data.id.value : this.id,
      codigoBarras: data.codigoBarras.present
          ? data.codigoBarras.value
          : this.codigoBarras,
      codigoInterno: data.codigoInterno.present
          ? data.codigoInterno.value
          : this.codigoInterno,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      marca: data.marca.present ? data.marca.value : this.marca,
      rubro: data.rubro.present ? data.rubro.value : this.rubro,
      imagenUrl: data.imagenUrl.present ? data.imagenUrl.value : this.imagenUrl,
      precioCosto: data.precioCosto.present
          ? data.precioCosto.value
          : this.precioCosto,
      precioVenta: data.precioVenta.present
          ? data.precioVenta.value
          : this.precioVenta,
      precioPromocional: data.precioPromocional.present
          ? data.precioPromocional.value
          : this.precioPromocional,
      promocionDesde: data.promocionDesde.present
          ? data.promocionDesde.value
          : this.promocionDesde,
      promocionHasta: data.promocionHasta.present
          ? data.promocionHasta.value
          : this.promocionHasta,
      activo: data.activo.present ? data.activo.value : this.activo,
      stockActual: data.stockActual.present
          ? data.stockActual.value
          : this.stockActual,
      version: data.version.present ? data.version.value : this.version,
      pendienteSync: data.pendienteSync.present
          ? data.pendienteSync.value
          : this.pendienteSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalArticulo(')
          ..write('id: $id, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('codigoInterno: $codigoInterno, ')
          ..write('descripcion: $descripcion, ')
          ..write('marca: $marca, ')
          ..write('rubro: $rubro, ')
          ..write('imagenUrl: $imagenUrl, ')
          ..write('precioCosto: $precioCosto, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('precioPromocional: $precioPromocional, ')
          ..write('promocionDesde: $promocionDesde, ')
          ..write('promocionHasta: $promocionHasta, ')
          ..write('activo: $activo, ')
          ..write('stockActual: $stockActual, ')
          ..write('version: $version, ')
          ..write('pendienteSync: $pendienteSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    codigoBarras,
    codigoInterno,
    descripcion,
    marca,
    rubro,
    imagenUrl,
    precioCosto,
    precioVenta,
    precioPromocional,
    promocionDesde,
    promocionHasta,
    activo,
    stockActual,
    version,
    pendienteSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalArticulo &&
          other.id == this.id &&
          other.codigoBarras == this.codigoBarras &&
          other.codigoInterno == this.codigoInterno &&
          other.descripcion == this.descripcion &&
          other.marca == this.marca &&
          other.rubro == this.rubro &&
          other.imagenUrl == this.imagenUrl &&
          other.precioCosto == this.precioCosto &&
          other.precioVenta == this.precioVenta &&
          other.precioPromocional == this.precioPromocional &&
          other.promocionDesde == this.promocionDesde &&
          other.promocionHasta == this.promocionHasta &&
          other.activo == this.activo &&
          other.stockActual == this.stockActual &&
          other.version == this.version &&
          other.pendienteSync == this.pendienteSync);
}

class LocalArticulosCompanion extends UpdateCompanion<LocalArticulo> {
  final Value<String> id;
  final Value<String?> codigoBarras;
  final Value<String?> codigoInterno;
  final Value<String> descripcion;
  final Value<String?> marca;
  final Value<String?> rubro;
  final Value<String?> imagenUrl;
  final Value<int> precioCosto;
  final Value<int> precioVenta;
  final Value<int?> precioPromocional;
  final Value<DateTime?> promocionDesde;
  final Value<DateTime?> promocionHasta;
  final Value<bool> activo;
  final Value<int?> stockActual;
  final Value<int> version;
  final Value<bool> pendienteSync;
  final Value<int> rowid;
  const LocalArticulosCompanion({
    this.id = const Value.absent(),
    this.codigoBarras = const Value.absent(),
    this.codigoInterno = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.marca = const Value.absent(),
    this.rubro = const Value.absent(),
    this.imagenUrl = const Value.absent(),
    this.precioCosto = const Value.absent(),
    this.precioVenta = const Value.absent(),
    this.precioPromocional = const Value.absent(),
    this.promocionDesde = const Value.absent(),
    this.promocionHasta = const Value.absent(),
    this.activo = const Value.absent(),
    this.stockActual = const Value.absent(),
    this.version = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalArticulosCompanion.insert({
    required String id,
    this.codigoBarras = const Value.absent(),
    this.codigoInterno = const Value.absent(),
    required String descripcion,
    this.marca = const Value.absent(),
    this.rubro = const Value.absent(),
    this.imagenUrl = const Value.absent(),
    required int precioCosto,
    required int precioVenta,
    this.precioPromocional = const Value.absent(),
    this.promocionDesde = const Value.absent(),
    this.promocionHasta = const Value.absent(),
    this.activo = const Value.absent(),
    this.stockActual = const Value.absent(),
    this.version = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       descripcion = Value(descripcion),
       precioCosto = Value(precioCosto),
       precioVenta = Value(precioVenta);
  static Insertable<LocalArticulo> custom({
    Expression<String>? id,
    Expression<String>? codigoBarras,
    Expression<String>? codigoInterno,
    Expression<String>? descripcion,
    Expression<String>? marca,
    Expression<String>? rubro,
    Expression<String>? imagenUrl,
    Expression<int>? precioCosto,
    Expression<int>? precioVenta,
    Expression<int>? precioPromocional,
    Expression<DateTime>? promocionDesde,
    Expression<DateTime>? promocionHasta,
    Expression<bool>? activo,
    Expression<int>? stockActual,
    Expression<int>? version,
    Expression<bool>? pendienteSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigoBarras != null) 'codigo_barras': codigoBarras,
      if (codigoInterno != null) 'codigo_interno': codigoInterno,
      if (descripcion != null) 'descripcion': descripcion,
      if (marca != null) 'marca': marca,
      if (rubro != null) 'rubro': rubro,
      if (imagenUrl != null) 'imagen_url': imagenUrl,
      if (precioCosto != null) 'precio_costo': precioCosto,
      if (precioVenta != null) 'precio_venta': precioVenta,
      if (precioPromocional != null) 'precio_promocional': precioPromocional,
      if (promocionDesde != null) 'promocion_desde': promocionDesde,
      if (promocionHasta != null) 'promocion_hasta': promocionHasta,
      if (activo != null) 'activo': activo,
      if (stockActual != null) 'stock_actual': stockActual,
      if (version != null) 'version': version,
      if (pendienteSync != null) 'pendiente_sync': pendienteSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalArticulosCompanion copyWith({
    Value<String>? id,
    Value<String?>? codigoBarras,
    Value<String?>? codigoInterno,
    Value<String>? descripcion,
    Value<String?>? marca,
    Value<String?>? rubro,
    Value<String?>? imagenUrl,
    Value<int>? precioCosto,
    Value<int>? precioVenta,
    Value<int?>? precioPromocional,
    Value<DateTime?>? promocionDesde,
    Value<DateTime?>? promocionHasta,
    Value<bool>? activo,
    Value<int?>? stockActual,
    Value<int>? version,
    Value<bool>? pendienteSync,
    Value<int>? rowid,
  }) {
    return LocalArticulosCompanion(
      id: id ?? this.id,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      codigoInterno: codigoInterno ?? this.codigoInterno,
      descripcion: descripcion ?? this.descripcion,
      marca: marca ?? this.marca,
      rubro: rubro ?? this.rubro,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      precioCosto: precioCosto ?? this.precioCosto,
      precioVenta: precioVenta ?? this.precioVenta,
      precioPromocional: precioPromocional ?? this.precioPromocional,
      promocionDesde: promocionDesde ?? this.promocionDesde,
      promocionHasta: promocionHasta ?? this.promocionHasta,
      activo: activo ?? this.activo,
      stockActual: stockActual ?? this.stockActual,
      version: version ?? this.version,
      pendienteSync: pendienteSync ?? this.pendienteSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (codigoBarras.present) {
      map['codigo_barras'] = Variable<String>(codigoBarras.value);
    }
    if (codigoInterno.present) {
      map['codigo_interno'] = Variable<String>(codigoInterno.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (rubro.present) {
      map['rubro'] = Variable<String>(rubro.value);
    }
    if (imagenUrl.present) {
      map['imagen_url'] = Variable<String>(imagenUrl.value);
    }
    if (precioCosto.present) {
      map['precio_costo'] = Variable<int>(precioCosto.value);
    }
    if (precioVenta.present) {
      map['precio_venta'] = Variable<int>(precioVenta.value);
    }
    if (precioPromocional.present) {
      map['precio_promocional'] = Variable<int>(precioPromocional.value);
    }
    if (promocionDesde.present) {
      map['promocion_desde'] = Variable<DateTime>(promocionDesde.value);
    }
    if (promocionHasta.present) {
      map['promocion_hasta'] = Variable<DateTime>(promocionHasta.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (stockActual.present) {
      map['stock_actual'] = Variable<int>(stockActual.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (pendienteSync.present) {
      map['pendiente_sync'] = Variable<bool>(pendienteSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalArticulosCompanion(')
          ..write('id: $id, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('codigoInterno: $codigoInterno, ')
          ..write('descripcion: $descripcion, ')
          ..write('marca: $marca, ')
          ..write('rubro: $rubro, ')
          ..write('imagenUrl: $imagenUrl, ')
          ..write('precioCosto: $precioCosto, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('precioPromocional: $precioPromocional, ')
          ..write('promocionDesde: $promocionDesde, ')
          ..write('promocionHasta: $promocionHasta, ')
          ..write('activo: $activo, ')
          ..write('stockActual: $stockActual, ')
          ..write('version: $version, ')
          ..write('pendienteSync: $pendienteSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalClientesTable extends LocalClientes
    with TableInfo<$LocalClientesTable, LocalCliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dniCuitMeta = const VerificationMeta(
    'dniCuit',
  );
  @override
  late final GeneratedColumn<String> dniCuit = GeneratedColumn<String>(
    'dni_cuit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _condicionIvaMeta = const VerificationMeta(
    'condicionIva',
  );
  @override
  late final GeneratedColumn<String> condicionIva = GeneratedColumn<String>(
    'condicion_iva',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('consumidor_final'),
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zonaMeta = const VerificationMeta('zona');
  @override
  late final GeneratedColumn<String> zona = GeneratedColumn<String>(
    'zona',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _porcentajeDescuentoMeta =
      const VerificationMeta('porcentajeDescuento');
  @override
  late final GeneratedColumn<int> porcentajeDescuento = GeneratedColumn<int>(
    'porcentaje_descuento',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _limiteCuentaCorrienteMeta =
      const VerificationMeta('limiteCuentaCorriente');
  @override
  late final GeneratedColumn<int> limiteCuentaCorriente = GeneratedColumn<int>(
    'limite_cuenta_corriente',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _pendienteSyncMeta = const VerificationMeta(
    'pendienteSync',
  );
  @override
  late final GeneratedColumn<bool> pendienteSync = GeneratedColumn<bool>(
    'pendiente_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pendiente_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    dniCuit,
    condicionIva,
    direccion,
    telefono,
    email,
    zona,
    porcentajeDescuento,
    activo,
    limiteCuentaCorriente,
    version,
    pendienteSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_clientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCliente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('dni_cuit')) {
      context.handle(
        _dniCuitMeta,
        dniCuit.isAcceptableOrUnknown(data['dni_cuit']!, _dniCuitMeta),
      );
    }
    if (data.containsKey('condicion_iva')) {
      context.handle(
        _condicionIvaMeta,
        condicionIva.isAcceptableOrUnknown(
          data['condicion_iva']!,
          _condicionIvaMeta,
        ),
      );
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('zona')) {
      context.handle(
        _zonaMeta,
        zona.isAcceptableOrUnknown(data['zona']!, _zonaMeta),
      );
    }
    if (data.containsKey('porcentaje_descuento')) {
      context.handle(
        _porcentajeDescuentoMeta,
        porcentajeDescuento.isAcceptableOrUnknown(
          data['porcentaje_descuento']!,
          _porcentajeDescuentoMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('limite_cuenta_corriente')) {
      context.handle(
        _limiteCuentaCorrienteMeta,
        limiteCuentaCorriente.isAcceptableOrUnknown(
          data['limite_cuenta_corriente']!,
          _limiteCuentaCorrienteMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('pendiente_sync')) {
      context.handle(
        _pendienteSyncMeta,
        pendienteSync.isAcceptableOrUnknown(
          data['pendiente_sync']!,
          _pendienteSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCliente(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      dniCuit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dni_cuit'],
      ),
      condicionIva: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condicion_iva'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      ),
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      zona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zona'],
      ),
      porcentajeDescuento: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}porcentaje_descuento'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      limiteCuentaCorriente: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}limite_cuenta_corriente'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      pendienteSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pendiente_sync'],
      )!,
    );
  }

  @override
  $LocalClientesTable createAlias(String alias) {
    return $LocalClientesTable(attachedDatabase, alias);
  }
}

class LocalCliente extends DataClass implements Insertable<LocalCliente> {
  final String id;
  final String nombre;
  final String? dniCuit;
  final String condicionIva;
  final String? direccion;
  final String? telefono;
  final String? email;
  final String? zona;
  final int porcentajeDescuento;
  final bool activo;
  final int? limiteCuentaCorriente;
  final int version;
  final bool pendienteSync;
  const LocalCliente({
    required this.id,
    required this.nombre,
    this.dniCuit,
    required this.condicionIva,
    this.direccion,
    this.telefono,
    this.email,
    this.zona,
    required this.porcentajeDescuento,
    required this.activo,
    this.limiteCuentaCorriente,
    required this.version,
    required this.pendienteSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || dniCuit != null) {
      map['dni_cuit'] = Variable<String>(dniCuit);
    }
    map['condicion_iva'] = Variable<String>(condicionIva);
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || zona != null) {
      map['zona'] = Variable<String>(zona);
    }
    map['porcentaje_descuento'] = Variable<int>(porcentajeDescuento);
    map['activo'] = Variable<bool>(activo);
    if (!nullToAbsent || limiteCuentaCorriente != null) {
      map['limite_cuenta_corriente'] = Variable<int>(limiteCuentaCorriente);
    }
    map['version'] = Variable<int>(version);
    map['pendiente_sync'] = Variable<bool>(pendienteSync);
    return map;
  }

  LocalClientesCompanion toCompanion(bool nullToAbsent) {
    return LocalClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      dniCuit: dniCuit == null && nullToAbsent
          ? const Value.absent()
          : Value(dniCuit),
      condicionIva: Value(condicionIva),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      zona: zona == null && nullToAbsent ? const Value.absent() : Value(zona),
      porcentajeDescuento: Value(porcentajeDescuento),
      activo: Value(activo),
      limiteCuentaCorriente: limiteCuentaCorriente == null && nullToAbsent
          ? const Value.absent()
          : Value(limiteCuentaCorriente),
      version: Value(version),
      pendienteSync: Value(pendienteSync),
    );
  }

  factory LocalCliente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCliente(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      dniCuit: serializer.fromJson<String?>(json['dniCuit']),
      condicionIva: serializer.fromJson<String>(json['condicionIva']),
      direccion: serializer.fromJson<String?>(json['direccion']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      email: serializer.fromJson<String?>(json['email']),
      zona: serializer.fromJson<String?>(json['zona']),
      porcentajeDescuento: serializer.fromJson<int>(
        json['porcentajeDescuento'],
      ),
      activo: serializer.fromJson<bool>(json['activo']),
      limiteCuentaCorriente: serializer.fromJson<int?>(
        json['limiteCuentaCorriente'],
      ),
      version: serializer.fromJson<int>(json['version']),
      pendienteSync: serializer.fromJson<bool>(json['pendienteSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'dniCuit': serializer.toJson<String?>(dniCuit),
      'condicionIva': serializer.toJson<String>(condicionIva),
      'direccion': serializer.toJson<String?>(direccion),
      'telefono': serializer.toJson<String?>(telefono),
      'email': serializer.toJson<String?>(email),
      'zona': serializer.toJson<String?>(zona),
      'porcentajeDescuento': serializer.toJson<int>(porcentajeDescuento),
      'activo': serializer.toJson<bool>(activo),
      'limiteCuentaCorriente': serializer.toJson<int?>(limiteCuentaCorriente),
      'version': serializer.toJson<int>(version),
      'pendienteSync': serializer.toJson<bool>(pendienteSync),
    };
  }

  LocalCliente copyWith({
    String? id,
    String? nombre,
    Value<String?> dniCuit = const Value.absent(),
    String? condicionIva,
    Value<String?> direccion = const Value.absent(),
    Value<String?> telefono = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> zona = const Value.absent(),
    int? porcentajeDescuento,
    bool? activo,
    Value<int?> limiteCuentaCorriente = const Value.absent(),
    int? version,
    bool? pendienteSync,
  }) => LocalCliente(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    dniCuit: dniCuit.present ? dniCuit.value : this.dniCuit,
    condicionIva: condicionIva ?? this.condicionIva,
    direccion: direccion.present ? direccion.value : this.direccion,
    telefono: telefono.present ? telefono.value : this.telefono,
    email: email.present ? email.value : this.email,
    zona: zona.present ? zona.value : this.zona,
    porcentajeDescuento: porcentajeDescuento ?? this.porcentajeDescuento,
    activo: activo ?? this.activo,
    limiteCuentaCorriente: limiteCuentaCorriente.present
        ? limiteCuentaCorriente.value
        : this.limiteCuentaCorriente,
    version: version ?? this.version,
    pendienteSync: pendienteSync ?? this.pendienteSync,
  );
  LocalCliente copyWithCompanion(LocalClientesCompanion data) {
    return LocalCliente(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      dniCuit: data.dniCuit.present ? data.dniCuit.value : this.dniCuit,
      condicionIva: data.condicionIva.present
          ? data.condicionIva.value
          : this.condicionIva,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      email: data.email.present ? data.email.value : this.email,
      zona: data.zona.present ? data.zona.value : this.zona,
      porcentajeDescuento: data.porcentajeDescuento.present
          ? data.porcentajeDescuento.value
          : this.porcentajeDescuento,
      activo: data.activo.present ? data.activo.value : this.activo,
      limiteCuentaCorriente: data.limiteCuentaCorriente.present
          ? data.limiteCuentaCorriente.value
          : this.limiteCuentaCorriente,
      version: data.version.present ? data.version.value : this.version,
      pendienteSync: data.pendienteSync.present
          ? data.pendienteSync.value
          : this.pendienteSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCliente(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('dniCuit: $dniCuit, ')
          ..write('condicionIva: $condicionIva, ')
          ..write('direccion: $direccion, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('zona: $zona, ')
          ..write('porcentajeDescuento: $porcentajeDescuento, ')
          ..write('activo: $activo, ')
          ..write('limiteCuentaCorriente: $limiteCuentaCorriente, ')
          ..write('version: $version, ')
          ..write('pendienteSync: $pendienteSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    dniCuit,
    condicionIva,
    direccion,
    telefono,
    email,
    zona,
    porcentajeDescuento,
    activo,
    limiteCuentaCorriente,
    version,
    pendienteSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCliente &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.dniCuit == this.dniCuit &&
          other.condicionIva == this.condicionIva &&
          other.direccion == this.direccion &&
          other.telefono == this.telefono &&
          other.email == this.email &&
          other.zona == this.zona &&
          other.porcentajeDescuento == this.porcentajeDescuento &&
          other.activo == this.activo &&
          other.limiteCuentaCorriente == this.limiteCuentaCorriente &&
          other.version == this.version &&
          other.pendienteSync == this.pendienteSync);
}

class LocalClientesCompanion extends UpdateCompanion<LocalCliente> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String?> dniCuit;
  final Value<String> condicionIva;
  final Value<String?> direccion;
  final Value<String?> telefono;
  final Value<String?> email;
  final Value<String?> zona;
  final Value<int> porcentajeDescuento;
  final Value<bool> activo;
  final Value<int?> limiteCuentaCorriente;
  final Value<int> version;
  final Value<bool> pendienteSync;
  final Value<int> rowid;
  const LocalClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.dniCuit = const Value.absent(),
    this.condicionIva = const Value.absent(),
    this.direccion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.zona = const Value.absent(),
    this.porcentajeDescuento = const Value.absent(),
    this.activo = const Value.absent(),
    this.limiteCuentaCorriente = const Value.absent(),
    this.version = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalClientesCompanion.insert({
    required String id,
    required String nombre,
    this.dniCuit = const Value.absent(),
    this.condicionIva = const Value.absent(),
    this.direccion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.zona = const Value.absent(),
    this.porcentajeDescuento = const Value.absent(),
    this.activo = const Value.absent(),
    this.limiteCuentaCorriente = const Value.absent(),
    this.version = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre);
  static Insertable<LocalCliente> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? dniCuit,
    Expression<String>? condicionIva,
    Expression<String>? direccion,
    Expression<String>? telefono,
    Expression<String>? email,
    Expression<String>? zona,
    Expression<int>? porcentajeDescuento,
    Expression<bool>? activo,
    Expression<int>? limiteCuentaCorriente,
    Expression<int>? version,
    Expression<bool>? pendienteSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (dniCuit != null) 'dni_cuit': dniCuit,
      if (condicionIva != null) 'condicion_iva': condicionIva,
      if (direccion != null) 'direccion': direccion,
      if (telefono != null) 'telefono': telefono,
      if (email != null) 'email': email,
      if (zona != null) 'zona': zona,
      if (porcentajeDescuento != null)
        'porcentaje_descuento': porcentajeDescuento,
      if (activo != null) 'activo': activo,
      if (limiteCuentaCorriente != null)
        'limite_cuenta_corriente': limiteCuentaCorriente,
      if (version != null) 'version': version,
      if (pendienteSync != null) 'pendiente_sync': pendienteSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalClientesCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String?>? dniCuit,
    Value<String>? condicionIva,
    Value<String?>? direccion,
    Value<String?>? telefono,
    Value<String?>? email,
    Value<String?>? zona,
    Value<int>? porcentajeDescuento,
    Value<bool>? activo,
    Value<int?>? limiteCuentaCorriente,
    Value<int>? version,
    Value<bool>? pendienteSync,
    Value<int>? rowid,
  }) {
    return LocalClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      dniCuit: dniCuit ?? this.dniCuit,
      condicionIva: condicionIva ?? this.condicionIva,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      zona: zona ?? this.zona,
      porcentajeDescuento: porcentajeDescuento ?? this.porcentajeDescuento,
      activo: activo ?? this.activo,
      limiteCuentaCorriente:
          limiteCuentaCorriente ?? this.limiteCuentaCorriente,
      version: version ?? this.version,
      pendienteSync: pendienteSync ?? this.pendienteSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (dniCuit.present) {
      map['dni_cuit'] = Variable<String>(dniCuit.value);
    }
    if (condicionIva.present) {
      map['condicion_iva'] = Variable<String>(condicionIva.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (zona.present) {
      map['zona'] = Variable<String>(zona.value);
    }
    if (porcentajeDescuento.present) {
      map['porcentaje_descuento'] = Variable<int>(porcentajeDescuento.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (limiteCuentaCorriente.present) {
      map['limite_cuenta_corriente'] = Variable<int>(
        limiteCuentaCorriente.value,
      );
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (pendienteSync.present) {
      map['pendiente_sync'] = Variable<bool>(pendienteSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('dniCuit: $dniCuit, ')
          ..write('condicionIva: $condicionIva, ')
          ..write('direccion: $direccion, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('zona: $zona, ')
          ..write('porcentajeDescuento: $porcentajeDescuento, ')
          ..write('activo: $activo, ')
          ..write('limiteCuentaCorriente: $limiteCuentaCorriente, ')
          ..write('version: $version, ')
          ..write('pendienteSync: $pendienteSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCajasTable extends LocalCajas
    with TableInfo<$LocalCajasTable, LocalCaja> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCajasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoInicialMeta = const VerificationMeta(
    'montoInicial',
  );
  @override
  late final GeneratedColumn<int> montoInicial = GeneratedColumn<int>(
    'monto_inicial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoFinalDeclaradoMeta =
      const VerificationMeta('montoFinalDeclarado');
  @override
  late final GeneratedColumn<int> montoFinalDeclarado = GeneratedColumn<int>(
    'monto_final_declarado',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoFinalCalculadoMeta =
      const VerificationMeta('montoFinalCalculado');
  @override
  late final GeneratedColumn<int> montoFinalCalculado = GeneratedColumn<int>(
    'monto_final_calculado',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diferenciaMeta = const VerificationMeta(
    'diferencia',
  );
  @override
  late final GeneratedColumn<int> diferencia = GeneratedColumn<int>(
    'diferencia',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreDispositivoMeta = const VerificationMeta(
    'nombreDispositivo',
  );
  @override
  late final GeneratedColumn<String> nombreDispositivo =
      GeneratedColumn<String>(
        'nombre_dispositivo',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _ocurridaEnMeta = const VerificationMeta(
    'ocurridaEn',
  );
  @override
  late final GeneratedColumn<DateTime> ocurridaEn = GeneratedColumn<DateTime>(
    'ocurrida_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cerradaEnMeta = const VerificationMeta(
    'cerradaEn',
  );
  @override
  late final GeneratedColumn<DateTime> cerradaEn = GeneratedColumn<DateTime>(
    'cerrada_en',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pendienteSyncMeta = const VerificationMeta(
    'pendienteSync',
  );
  @override
  late final GeneratedColumn<bool> pendienteSync = GeneratedColumn<bool>(
    'pendiente_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pendiente_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    montoInicial,
    montoFinalDeclarado,
    montoFinalCalculado,
    diferencia,
    estado,
    deviceId,
    nombreDispositivo,
    ocurridaEn,
    cerradaEn,
    pendienteSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cajas';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCaja> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('monto_inicial')) {
      context.handle(
        _montoInicialMeta,
        montoInicial.isAcceptableOrUnknown(
          data['monto_inicial']!,
          _montoInicialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_montoInicialMeta);
    }
    if (data.containsKey('monto_final_declarado')) {
      context.handle(
        _montoFinalDeclaradoMeta,
        montoFinalDeclarado.isAcceptableOrUnknown(
          data['monto_final_declarado']!,
          _montoFinalDeclaradoMeta,
        ),
      );
    }
    if (data.containsKey('monto_final_calculado')) {
      context.handle(
        _montoFinalCalculadoMeta,
        montoFinalCalculado.isAcceptableOrUnknown(
          data['monto_final_calculado']!,
          _montoFinalCalculadoMeta,
        ),
      );
    }
    if (data.containsKey('diferencia')) {
      context.handle(
        _diferenciaMeta,
        diferencia.isAcceptableOrUnknown(data['diferencia']!, _diferenciaMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('nombre_dispositivo')) {
      context.handle(
        _nombreDispositivoMeta,
        nombreDispositivo.isAcceptableOrUnknown(
          data['nombre_dispositivo']!,
          _nombreDispositivoMeta,
        ),
      );
    }
    if (data.containsKey('ocurrida_en')) {
      context.handle(
        _ocurridaEnMeta,
        ocurridaEn.isAcceptableOrUnknown(data['ocurrida_en']!, _ocurridaEnMeta),
      );
    } else if (isInserting) {
      context.missing(_ocurridaEnMeta);
    }
    if (data.containsKey('cerrada_en')) {
      context.handle(
        _cerradaEnMeta,
        cerradaEn.isAcceptableOrUnknown(data['cerrada_en']!, _cerradaEnMeta),
      );
    }
    if (data.containsKey('pendiente_sync')) {
      context.handle(
        _pendienteSyncMeta,
        pendienteSync.isAcceptableOrUnknown(
          data['pendiente_sync']!,
          _pendienteSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCaja map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCaja(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      montoInicial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto_inicial'],
      )!,
      montoFinalDeclarado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto_final_declarado'],
      ),
      montoFinalCalculado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto_final_calculado'],
      ),
      diferencia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}diferencia'],
      ),
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      nombreDispositivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_dispositivo'],
      ),
      ocurridaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ocurrida_en'],
      )!,
      cerradaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cerrada_en'],
      ),
      pendienteSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pendiente_sync'],
      )!,
    );
  }

  @override
  $LocalCajasTable createAlias(String alias) {
    return $LocalCajasTable(attachedDatabase, alias);
  }
}

class LocalCaja extends DataClass implements Insertable<LocalCaja> {
  final String id;
  final int montoInicial;
  final int? montoFinalDeclarado;
  final int? montoFinalCalculado;
  final int? diferencia;

  /// 'abierta' | 'cerrada'
  final String estado;
  final String deviceId;
  final String? nombreDispositivo;
  final DateTime ocurridaEn;
  final DateTime? cerradaEn;
  final bool pendienteSync;
  const LocalCaja({
    required this.id,
    required this.montoInicial,
    this.montoFinalDeclarado,
    this.montoFinalCalculado,
    this.diferencia,
    required this.estado,
    required this.deviceId,
    this.nombreDispositivo,
    required this.ocurridaEn,
    this.cerradaEn,
    required this.pendienteSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['monto_inicial'] = Variable<int>(montoInicial);
    if (!nullToAbsent || montoFinalDeclarado != null) {
      map['monto_final_declarado'] = Variable<int>(montoFinalDeclarado);
    }
    if (!nullToAbsent || montoFinalCalculado != null) {
      map['monto_final_calculado'] = Variable<int>(montoFinalCalculado);
    }
    if (!nullToAbsent || diferencia != null) {
      map['diferencia'] = Variable<int>(diferencia);
    }
    map['estado'] = Variable<String>(estado);
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || nombreDispositivo != null) {
      map['nombre_dispositivo'] = Variable<String>(nombreDispositivo);
    }
    map['ocurrida_en'] = Variable<DateTime>(ocurridaEn);
    if (!nullToAbsent || cerradaEn != null) {
      map['cerrada_en'] = Variable<DateTime>(cerradaEn);
    }
    map['pendiente_sync'] = Variable<bool>(pendienteSync);
    return map;
  }

  LocalCajasCompanion toCompanion(bool nullToAbsent) {
    return LocalCajasCompanion(
      id: Value(id),
      montoInicial: Value(montoInicial),
      montoFinalDeclarado: montoFinalDeclarado == null && nullToAbsent
          ? const Value.absent()
          : Value(montoFinalDeclarado),
      montoFinalCalculado: montoFinalCalculado == null && nullToAbsent
          ? const Value.absent()
          : Value(montoFinalCalculado),
      diferencia: diferencia == null && nullToAbsent
          ? const Value.absent()
          : Value(diferencia),
      estado: Value(estado),
      deviceId: Value(deviceId),
      nombreDispositivo: nombreDispositivo == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreDispositivo),
      ocurridaEn: Value(ocurridaEn),
      cerradaEn: cerradaEn == null && nullToAbsent
          ? const Value.absent()
          : Value(cerradaEn),
      pendienteSync: Value(pendienteSync),
    );
  }

  factory LocalCaja.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCaja(
      id: serializer.fromJson<String>(json['id']),
      montoInicial: serializer.fromJson<int>(json['montoInicial']),
      montoFinalDeclarado: serializer.fromJson<int?>(
        json['montoFinalDeclarado'],
      ),
      montoFinalCalculado: serializer.fromJson<int?>(
        json['montoFinalCalculado'],
      ),
      diferencia: serializer.fromJson<int?>(json['diferencia']),
      estado: serializer.fromJson<String>(json['estado']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      nombreDispositivo: serializer.fromJson<String?>(
        json['nombreDispositivo'],
      ),
      ocurridaEn: serializer.fromJson<DateTime>(json['ocurridaEn']),
      cerradaEn: serializer.fromJson<DateTime?>(json['cerradaEn']),
      pendienteSync: serializer.fromJson<bool>(json['pendienteSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'montoInicial': serializer.toJson<int>(montoInicial),
      'montoFinalDeclarado': serializer.toJson<int?>(montoFinalDeclarado),
      'montoFinalCalculado': serializer.toJson<int?>(montoFinalCalculado),
      'diferencia': serializer.toJson<int?>(diferencia),
      'estado': serializer.toJson<String>(estado),
      'deviceId': serializer.toJson<String>(deviceId),
      'nombreDispositivo': serializer.toJson<String?>(nombreDispositivo),
      'ocurridaEn': serializer.toJson<DateTime>(ocurridaEn),
      'cerradaEn': serializer.toJson<DateTime?>(cerradaEn),
      'pendienteSync': serializer.toJson<bool>(pendienteSync),
    };
  }

  LocalCaja copyWith({
    String? id,
    int? montoInicial,
    Value<int?> montoFinalDeclarado = const Value.absent(),
    Value<int?> montoFinalCalculado = const Value.absent(),
    Value<int?> diferencia = const Value.absent(),
    String? estado,
    String? deviceId,
    Value<String?> nombreDispositivo = const Value.absent(),
    DateTime? ocurridaEn,
    Value<DateTime?> cerradaEn = const Value.absent(),
    bool? pendienteSync,
  }) => LocalCaja(
    id: id ?? this.id,
    montoInicial: montoInicial ?? this.montoInicial,
    montoFinalDeclarado: montoFinalDeclarado.present
        ? montoFinalDeclarado.value
        : this.montoFinalDeclarado,
    montoFinalCalculado: montoFinalCalculado.present
        ? montoFinalCalculado.value
        : this.montoFinalCalculado,
    diferencia: diferencia.present ? diferencia.value : this.diferencia,
    estado: estado ?? this.estado,
    deviceId: deviceId ?? this.deviceId,
    nombreDispositivo: nombreDispositivo.present
        ? nombreDispositivo.value
        : this.nombreDispositivo,
    ocurridaEn: ocurridaEn ?? this.ocurridaEn,
    cerradaEn: cerradaEn.present ? cerradaEn.value : this.cerradaEn,
    pendienteSync: pendienteSync ?? this.pendienteSync,
  );
  LocalCaja copyWithCompanion(LocalCajasCompanion data) {
    return LocalCaja(
      id: data.id.present ? data.id.value : this.id,
      montoInicial: data.montoInicial.present
          ? data.montoInicial.value
          : this.montoInicial,
      montoFinalDeclarado: data.montoFinalDeclarado.present
          ? data.montoFinalDeclarado.value
          : this.montoFinalDeclarado,
      montoFinalCalculado: data.montoFinalCalculado.present
          ? data.montoFinalCalculado.value
          : this.montoFinalCalculado,
      diferencia: data.diferencia.present
          ? data.diferencia.value
          : this.diferencia,
      estado: data.estado.present ? data.estado.value : this.estado,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      nombreDispositivo: data.nombreDispositivo.present
          ? data.nombreDispositivo.value
          : this.nombreDispositivo,
      ocurridaEn: data.ocurridaEn.present
          ? data.ocurridaEn.value
          : this.ocurridaEn,
      cerradaEn: data.cerradaEn.present ? data.cerradaEn.value : this.cerradaEn,
      pendienteSync: data.pendienteSync.present
          ? data.pendienteSync.value
          : this.pendienteSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCaja(')
          ..write('id: $id, ')
          ..write('montoInicial: $montoInicial, ')
          ..write('montoFinalDeclarado: $montoFinalDeclarado, ')
          ..write('montoFinalCalculado: $montoFinalCalculado, ')
          ..write('diferencia: $diferencia, ')
          ..write('estado: $estado, ')
          ..write('deviceId: $deviceId, ')
          ..write('nombreDispositivo: $nombreDispositivo, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('cerradaEn: $cerradaEn, ')
          ..write('pendienteSync: $pendienteSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    montoInicial,
    montoFinalDeclarado,
    montoFinalCalculado,
    diferencia,
    estado,
    deviceId,
    nombreDispositivo,
    ocurridaEn,
    cerradaEn,
    pendienteSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCaja &&
          other.id == this.id &&
          other.montoInicial == this.montoInicial &&
          other.montoFinalDeclarado == this.montoFinalDeclarado &&
          other.montoFinalCalculado == this.montoFinalCalculado &&
          other.diferencia == this.diferencia &&
          other.estado == this.estado &&
          other.deviceId == this.deviceId &&
          other.nombreDispositivo == this.nombreDispositivo &&
          other.ocurridaEn == this.ocurridaEn &&
          other.cerradaEn == this.cerradaEn &&
          other.pendienteSync == this.pendienteSync);
}

class LocalCajasCompanion extends UpdateCompanion<LocalCaja> {
  final Value<String> id;
  final Value<int> montoInicial;
  final Value<int?> montoFinalDeclarado;
  final Value<int?> montoFinalCalculado;
  final Value<int?> diferencia;
  final Value<String> estado;
  final Value<String> deviceId;
  final Value<String?> nombreDispositivo;
  final Value<DateTime> ocurridaEn;
  final Value<DateTime?> cerradaEn;
  final Value<bool> pendienteSync;
  final Value<int> rowid;
  const LocalCajasCompanion({
    this.id = const Value.absent(),
    this.montoInicial = const Value.absent(),
    this.montoFinalDeclarado = const Value.absent(),
    this.montoFinalCalculado = const Value.absent(),
    this.diferencia = const Value.absent(),
    this.estado = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.nombreDispositivo = const Value.absent(),
    this.ocurridaEn = const Value.absent(),
    this.cerradaEn = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCajasCompanion.insert({
    required String id,
    required int montoInicial,
    this.montoFinalDeclarado = const Value.absent(),
    this.montoFinalCalculado = const Value.absent(),
    this.diferencia = const Value.absent(),
    required String estado,
    required String deviceId,
    this.nombreDispositivo = const Value.absent(),
    required DateTime ocurridaEn,
    this.cerradaEn = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       montoInicial = Value(montoInicial),
       estado = Value(estado),
       deviceId = Value(deviceId),
       ocurridaEn = Value(ocurridaEn);
  static Insertable<LocalCaja> custom({
    Expression<String>? id,
    Expression<int>? montoInicial,
    Expression<int>? montoFinalDeclarado,
    Expression<int>? montoFinalCalculado,
    Expression<int>? diferencia,
    Expression<String>? estado,
    Expression<String>? deviceId,
    Expression<String>? nombreDispositivo,
    Expression<DateTime>? ocurridaEn,
    Expression<DateTime>? cerradaEn,
    Expression<bool>? pendienteSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (montoInicial != null) 'monto_inicial': montoInicial,
      if (montoFinalDeclarado != null)
        'monto_final_declarado': montoFinalDeclarado,
      if (montoFinalCalculado != null)
        'monto_final_calculado': montoFinalCalculado,
      if (diferencia != null) 'diferencia': diferencia,
      if (estado != null) 'estado': estado,
      if (deviceId != null) 'device_id': deviceId,
      if (nombreDispositivo != null) 'nombre_dispositivo': nombreDispositivo,
      if (ocurridaEn != null) 'ocurrida_en': ocurridaEn,
      if (cerradaEn != null) 'cerrada_en': cerradaEn,
      if (pendienteSync != null) 'pendiente_sync': pendienteSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCajasCompanion copyWith({
    Value<String>? id,
    Value<int>? montoInicial,
    Value<int?>? montoFinalDeclarado,
    Value<int?>? montoFinalCalculado,
    Value<int?>? diferencia,
    Value<String>? estado,
    Value<String>? deviceId,
    Value<String?>? nombreDispositivo,
    Value<DateTime>? ocurridaEn,
    Value<DateTime?>? cerradaEn,
    Value<bool>? pendienteSync,
    Value<int>? rowid,
  }) {
    return LocalCajasCompanion(
      id: id ?? this.id,
      montoInicial: montoInicial ?? this.montoInicial,
      montoFinalDeclarado: montoFinalDeclarado ?? this.montoFinalDeclarado,
      montoFinalCalculado: montoFinalCalculado ?? this.montoFinalCalculado,
      diferencia: diferencia ?? this.diferencia,
      estado: estado ?? this.estado,
      deviceId: deviceId ?? this.deviceId,
      nombreDispositivo: nombreDispositivo ?? this.nombreDispositivo,
      ocurridaEn: ocurridaEn ?? this.ocurridaEn,
      cerradaEn: cerradaEn ?? this.cerradaEn,
      pendienteSync: pendienteSync ?? this.pendienteSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (montoInicial.present) {
      map['monto_inicial'] = Variable<int>(montoInicial.value);
    }
    if (montoFinalDeclarado.present) {
      map['monto_final_declarado'] = Variable<int>(montoFinalDeclarado.value);
    }
    if (montoFinalCalculado.present) {
      map['monto_final_calculado'] = Variable<int>(montoFinalCalculado.value);
    }
    if (diferencia.present) {
      map['diferencia'] = Variable<int>(diferencia.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (nombreDispositivo.present) {
      map['nombre_dispositivo'] = Variable<String>(nombreDispositivo.value);
    }
    if (ocurridaEn.present) {
      map['ocurrida_en'] = Variable<DateTime>(ocurridaEn.value);
    }
    if (cerradaEn.present) {
      map['cerrada_en'] = Variable<DateTime>(cerradaEn.value);
    }
    if (pendienteSync.present) {
      map['pendiente_sync'] = Variable<bool>(pendienteSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCajasCompanion(')
          ..write('id: $id, ')
          ..write('montoInicial: $montoInicial, ')
          ..write('montoFinalDeclarado: $montoFinalDeclarado, ')
          ..write('montoFinalCalculado: $montoFinalCalculado, ')
          ..write('diferencia: $diferencia, ')
          ..write('estado: $estado, ')
          ..write('deviceId: $deviceId, ')
          ..write('nombreDispositivo: $nombreDispositivo, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('cerradaEn: $cerradaEn, ')
          ..write('pendienteSync: $pendienteSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCajaMovimientosTable extends LocalCajaMovimientos
    with TableInfo<$LocalCajaMovimientosTable, LocalCajaMovimiento> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCajaMovimientosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cajaIdMeta = const VerificationMeta('cajaId');
  @override
  late final GeneratedColumn<String> cajaId = GeneratedColumn<String>(
    'caja_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ocurridaEnMeta = const VerificationMeta(
    'ocurridaEn',
  );
  @override
  late final GeneratedColumn<DateTime> ocurridaEn = GeneratedColumn<DateTime>(
    'ocurrida_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendienteSyncMeta = const VerificationMeta(
    'pendienteSync',
  );
  @override
  late final GeneratedColumn<bool> pendienteSync = GeneratedColumn<bool>(
    'pendiente_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pendiente_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cajaId,
    tipo,
    monto,
    nota,
    ocurridaEn,
    pendienteSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_caja_movimientos';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCajaMovimiento> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('caja_id')) {
      context.handle(
        _cajaIdMeta,
        cajaId.isAcceptableOrUnknown(data['caja_id']!, _cajaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cajaIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    } else if (isInserting) {
      context.missing(_notaMeta);
    }
    if (data.containsKey('ocurrida_en')) {
      context.handle(
        _ocurridaEnMeta,
        ocurridaEn.isAcceptableOrUnknown(data['ocurrida_en']!, _ocurridaEnMeta),
      );
    } else if (isInserting) {
      context.missing(_ocurridaEnMeta);
    }
    if (data.containsKey('pendiente_sync')) {
      context.handle(
        _pendienteSyncMeta,
        pendienteSync.isAcceptableOrUnknown(
          data['pendiente_sync']!,
          _pendienteSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCajaMovimiento map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCajaMovimiento(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cajaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caja_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      )!,
      ocurridaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ocurrida_en'],
      )!,
      pendienteSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pendiente_sync'],
      )!,
    );
  }

  @override
  $LocalCajaMovimientosTable createAlias(String alias) {
    return $LocalCajaMovimientosTable(attachedDatabase, alias);
  }
}

class LocalCajaMovimiento extends DataClass
    implements Insertable<LocalCajaMovimiento> {
  final String id;
  final String cajaId;

  /// 'ingreso' | 'retiro'
  final String tipo;

  /// Positivo = entrada, negativo = salida (mismo signo que espera el server).
  final int monto;
  final String nota;
  final DateTime ocurridaEn;
  final bool pendienteSync;
  const LocalCajaMovimiento({
    required this.id,
    required this.cajaId,
    required this.tipo,
    required this.monto,
    required this.nota,
    required this.ocurridaEn,
    required this.pendienteSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['caja_id'] = Variable<String>(cajaId);
    map['tipo'] = Variable<String>(tipo);
    map['monto'] = Variable<int>(monto);
    map['nota'] = Variable<String>(nota);
    map['ocurrida_en'] = Variable<DateTime>(ocurridaEn);
    map['pendiente_sync'] = Variable<bool>(pendienteSync);
    return map;
  }

  LocalCajaMovimientosCompanion toCompanion(bool nullToAbsent) {
    return LocalCajaMovimientosCompanion(
      id: Value(id),
      cajaId: Value(cajaId),
      tipo: Value(tipo),
      monto: Value(monto),
      nota: Value(nota),
      ocurridaEn: Value(ocurridaEn),
      pendienteSync: Value(pendienteSync),
    );
  }

  factory LocalCajaMovimiento.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCajaMovimiento(
      id: serializer.fromJson<String>(json['id']),
      cajaId: serializer.fromJson<String>(json['cajaId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      monto: serializer.fromJson<int>(json['monto']),
      nota: serializer.fromJson<String>(json['nota']),
      ocurridaEn: serializer.fromJson<DateTime>(json['ocurridaEn']),
      pendienteSync: serializer.fromJson<bool>(json['pendienteSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cajaId': serializer.toJson<String>(cajaId),
      'tipo': serializer.toJson<String>(tipo),
      'monto': serializer.toJson<int>(monto),
      'nota': serializer.toJson<String>(nota),
      'ocurridaEn': serializer.toJson<DateTime>(ocurridaEn),
      'pendienteSync': serializer.toJson<bool>(pendienteSync),
    };
  }

  LocalCajaMovimiento copyWith({
    String? id,
    String? cajaId,
    String? tipo,
    int? monto,
    String? nota,
    DateTime? ocurridaEn,
    bool? pendienteSync,
  }) => LocalCajaMovimiento(
    id: id ?? this.id,
    cajaId: cajaId ?? this.cajaId,
    tipo: tipo ?? this.tipo,
    monto: monto ?? this.monto,
    nota: nota ?? this.nota,
    ocurridaEn: ocurridaEn ?? this.ocurridaEn,
    pendienteSync: pendienteSync ?? this.pendienteSync,
  );
  LocalCajaMovimiento copyWithCompanion(LocalCajaMovimientosCompanion data) {
    return LocalCajaMovimiento(
      id: data.id.present ? data.id.value : this.id,
      cajaId: data.cajaId.present ? data.cajaId.value : this.cajaId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      monto: data.monto.present ? data.monto.value : this.monto,
      nota: data.nota.present ? data.nota.value : this.nota,
      ocurridaEn: data.ocurridaEn.present
          ? data.ocurridaEn.value
          : this.ocurridaEn,
      pendienteSync: data.pendienteSync.present
          ? data.pendienteSync.value
          : this.pendienteSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCajaMovimiento(')
          ..write('id: $id, ')
          ..write('cajaId: $cajaId, ')
          ..write('tipo: $tipo, ')
          ..write('monto: $monto, ')
          ..write('nota: $nota, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('pendienteSync: $pendienteSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cajaId, tipo, monto, nota, ocurridaEn, pendienteSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCajaMovimiento &&
          other.id == this.id &&
          other.cajaId == this.cajaId &&
          other.tipo == this.tipo &&
          other.monto == this.monto &&
          other.nota == this.nota &&
          other.ocurridaEn == this.ocurridaEn &&
          other.pendienteSync == this.pendienteSync);
}

class LocalCajaMovimientosCompanion
    extends UpdateCompanion<LocalCajaMovimiento> {
  final Value<String> id;
  final Value<String> cajaId;
  final Value<String> tipo;
  final Value<int> monto;
  final Value<String> nota;
  final Value<DateTime> ocurridaEn;
  final Value<bool> pendienteSync;
  final Value<int> rowid;
  const LocalCajaMovimientosCompanion({
    this.id = const Value.absent(),
    this.cajaId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.monto = const Value.absent(),
    this.nota = const Value.absent(),
    this.ocurridaEn = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCajaMovimientosCompanion.insert({
    required String id,
    required String cajaId,
    required String tipo,
    required int monto,
    required String nota,
    required DateTime ocurridaEn,
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cajaId = Value(cajaId),
       tipo = Value(tipo),
       monto = Value(monto),
       nota = Value(nota),
       ocurridaEn = Value(ocurridaEn);
  static Insertable<LocalCajaMovimiento> custom({
    Expression<String>? id,
    Expression<String>? cajaId,
    Expression<String>? tipo,
    Expression<int>? monto,
    Expression<String>? nota,
    Expression<DateTime>? ocurridaEn,
    Expression<bool>? pendienteSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cajaId != null) 'caja_id': cajaId,
      if (tipo != null) 'tipo': tipo,
      if (monto != null) 'monto': monto,
      if (nota != null) 'nota': nota,
      if (ocurridaEn != null) 'ocurrida_en': ocurridaEn,
      if (pendienteSync != null) 'pendiente_sync': pendienteSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCajaMovimientosCompanion copyWith({
    Value<String>? id,
    Value<String>? cajaId,
    Value<String>? tipo,
    Value<int>? monto,
    Value<String>? nota,
    Value<DateTime>? ocurridaEn,
    Value<bool>? pendienteSync,
    Value<int>? rowid,
  }) {
    return LocalCajaMovimientosCompanion(
      id: id ?? this.id,
      cajaId: cajaId ?? this.cajaId,
      tipo: tipo ?? this.tipo,
      monto: monto ?? this.monto,
      nota: nota ?? this.nota,
      ocurridaEn: ocurridaEn ?? this.ocurridaEn,
      pendienteSync: pendienteSync ?? this.pendienteSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cajaId.present) {
      map['caja_id'] = Variable<String>(cajaId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (ocurridaEn.present) {
      map['ocurrida_en'] = Variable<DateTime>(ocurridaEn.value);
    }
    if (pendienteSync.present) {
      map['pendiente_sync'] = Variable<bool>(pendienteSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCajaMovimientosCompanion(')
          ..write('id: $id, ')
          ..write('cajaId: $cajaId, ')
          ..write('tipo: $tipo, ')
          ..write('monto: $monto, ')
          ..write('nota: $nota, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('pendienteSync: $pendienteSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalVentasTable extends LocalVentas
    with TableInfo<$LocalVentasTable, LocalVenta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalVentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clienteIdMeta = const VerificationMeta(
    'clienteId',
  );
  @override
  late final GeneratedColumn<String> clienteId = GeneratedColumn<String>(
    'cliente_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formaPagoMeta = const VerificationMeta(
    'formaPago',
  );
  @override
  late final GeneratedColumn<String> formaPago = GeneratedColumn<String>(
    'forma_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoComprobanteMeta = const VerificationMeta(
    'tipoComprobante',
  );
  @override
  late final GeneratedColumn<String> tipoComprobante = GeneratedColumn<String>(
    'tipo_comprobante',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descuentoMeta = const VerificationMeta(
    'descuento',
  );
  @override
  late final GeneratedColumn<int> descuento = GeneratedColumn<int>(
    'descuento',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocurridaEnMeta = const VerificationMeta(
    'ocurridaEn',
  );
  @override
  late final GeneratedColumn<DateTime> ocurridaEn = GeneratedColumn<DateTime>(
    'ocurrida_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendienteSyncMeta = const VerificationMeta(
    'pendienteSync',
  );
  @override
  late final GeneratedColumn<bool> pendienteSync = GeneratedColumn<bool>(
    'pendiente_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pendiente_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    numero,
    clienteId,
    formaPago,
    tipoComprobante,
    subtotal,
    descuento,
    total,
    deviceId,
    ocurridaEn,
    pendienteSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalVenta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    }
    if (data.containsKey('cliente_id')) {
      context.handle(
        _clienteIdMeta,
        clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta),
      );
    }
    if (data.containsKey('forma_pago')) {
      context.handle(
        _formaPagoMeta,
        formaPago.isAcceptableOrUnknown(data['forma_pago']!, _formaPagoMeta),
      );
    } else if (isInserting) {
      context.missing(_formaPagoMeta);
    }
    if (data.containsKey('tipo_comprobante')) {
      context.handle(
        _tipoComprobanteMeta,
        tipoComprobante.isAcceptableOrUnknown(
          data['tipo_comprobante']!,
          _tipoComprobanteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoComprobanteMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('descuento')) {
      context.handle(
        _descuentoMeta,
        descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta),
      );
    } else if (isInserting) {
      context.missing(_descuentoMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('ocurrida_en')) {
      context.handle(
        _ocurridaEnMeta,
        ocurridaEn.isAcceptableOrUnknown(data['ocurrida_en']!, _ocurridaEnMeta),
      );
    } else if (isInserting) {
      context.missing(_ocurridaEnMeta);
    }
    if (data.containsKey('pendiente_sync')) {
      context.handle(
        _pendienteSyncMeta,
        pendienteSync.isAcceptableOrUnknown(
          data['pendiente_sync']!,
          _pendienteSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalVenta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalVenta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      ),
      clienteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_id'],
      ),
      formaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}forma_pago'],
      )!,
      tipoComprobante: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_comprobante'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      descuento: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}descuento'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      ocurridaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ocurrida_en'],
      )!,
      pendienteSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pendiente_sync'],
      )!,
    );
  }

  @override
  $LocalVentasTable createAlias(String alias) {
    return $LocalVentasTable(attachedDatabase, alias);
  }
}

class LocalVenta extends DataClass implements Insertable<LocalVenta> {
  final String id;
  final int? numero;
  final String? clienteId;
  final String formaPago;
  final String tipoComprobante;
  final int subtotal;
  final int descuento;
  final int total;
  final String? deviceId;
  final DateTime ocurridaEn;
  final bool pendienteSync;
  const LocalVenta({
    required this.id,
    this.numero,
    this.clienteId,
    required this.formaPago,
    required this.tipoComprobante,
    required this.subtotal,
    required this.descuento,
    required this.total,
    this.deviceId,
    required this.ocurridaEn,
    required this.pendienteSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || numero != null) {
      map['numero'] = Variable<int>(numero);
    }
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<String>(clienteId);
    }
    map['forma_pago'] = Variable<String>(formaPago);
    map['tipo_comprobante'] = Variable<String>(tipoComprobante);
    map['subtotal'] = Variable<int>(subtotal);
    map['descuento'] = Variable<int>(descuento);
    map['total'] = Variable<int>(total);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['ocurrida_en'] = Variable<DateTime>(ocurridaEn);
    map['pendiente_sync'] = Variable<bool>(pendienteSync);
    return map;
  }

  LocalVentasCompanion toCompanion(bool nullToAbsent) {
    return LocalVentasCompanion(
      id: Value(id),
      numero: numero == null && nullToAbsent
          ? const Value.absent()
          : Value(numero),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      formaPago: Value(formaPago),
      tipoComprobante: Value(tipoComprobante),
      subtotal: Value(subtotal),
      descuento: Value(descuento),
      total: Value(total),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      ocurridaEn: Value(ocurridaEn),
      pendienteSync: Value(pendienteSync),
    );
  }

  factory LocalVenta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalVenta(
      id: serializer.fromJson<String>(json['id']),
      numero: serializer.fromJson<int?>(json['numero']),
      clienteId: serializer.fromJson<String?>(json['clienteId']),
      formaPago: serializer.fromJson<String>(json['formaPago']),
      tipoComprobante: serializer.fromJson<String>(json['tipoComprobante']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      descuento: serializer.fromJson<int>(json['descuento']),
      total: serializer.fromJson<int>(json['total']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      ocurridaEn: serializer.fromJson<DateTime>(json['ocurridaEn']),
      pendienteSync: serializer.fromJson<bool>(json['pendienteSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'numero': serializer.toJson<int?>(numero),
      'clienteId': serializer.toJson<String?>(clienteId),
      'formaPago': serializer.toJson<String>(formaPago),
      'tipoComprobante': serializer.toJson<String>(tipoComprobante),
      'subtotal': serializer.toJson<int>(subtotal),
      'descuento': serializer.toJson<int>(descuento),
      'total': serializer.toJson<int>(total),
      'deviceId': serializer.toJson<String?>(deviceId),
      'ocurridaEn': serializer.toJson<DateTime>(ocurridaEn),
      'pendienteSync': serializer.toJson<bool>(pendienteSync),
    };
  }

  LocalVenta copyWith({
    String? id,
    Value<int?> numero = const Value.absent(),
    Value<String?> clienteId = const Value.absent(),
    String? formaPago,
    String? tipoComprobante,
    int? subtotal,
    int? descuento,
    int? total,
    Value<String?> deviceId = const Value.absent(),
    DateTime? ocurridaEn,
    bool? pendienteSync,
  }) => LocalVenta(
    id: id ?? this.id,
    numero: numero.present ? numero.value : this.numero,
    clienteId: clienteId.present ? clienteId.value : this.clienteId,
    formaPago: formaPago ?? this.formaPago,
    tipoComprobante: tipoComprobante ?? this.tipoComprobante,
    subtotal: subtotal ?? this.subtotal,
    descuento: descuento ?? this.descuento,
    total: total ?? this.total,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    ocurridaEn: ocurridaEn ?? this.ocurridaEn,
    pendienteSync: pendienteSync ?? this.pendienteSync,
  );
  LocalVenta copyWithCompanion(LocalVentasCompanion data) {
    return LocalVenta(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      formaPago: data.formaPago.present ? data.formaPago.value : this.formaPago,
      tipoComprobante: data.tipoComprobante.present
          ? data.tipoComprobante.value
          : this.tipoComprobante,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      descuento: data.descuento.present ? data.descuento.value : this.descuento,
      total: data.total.present ? data.total.value : this.total,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      ocurridaEn: data.ocurridaEn.present
          ? data.ocurridaEn.value
          : this.ocurridaEn,
      pendienteSync: data.pendienteSync.present
          ? data.pendienteSync.value
          : this.pendienteSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalVenta(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('clienteId: $clienteId, ')
          ..write('formaPago: $formaPago, ')
          ..write('tipoComprobante: $tipoComprobante, ')
          ..write('subtotal: $subtotal, ')
          ..write('descuento: $descuento, ')
          ..write('total: $total, ')
          ..write('deviceId: $deviceId, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('pendienteSync: $pendienteSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    numero,
    clienteId,
    formaPago,
    tipoComprobante,
    subtotal,
    descuento,
    total,
    deviceId,
    ocurridaEn,
    pendienteSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalVenta &&
          other.id == this.id &&
          other.numero == this.numero &&
          other.clienteId == this.clienteId &&
          other.formaPago == this.formaPago &&
          other.tipoComprobante == this.tipoComprobante &&
          other.subtotal == this.subtotal &&
          other.descuento == this.descuento &&
          other.total == this.total &&
          other.deviceId == this.deviceId &&
          other.ocurridaEn == this.ocurridaEn &&
          other.pendienteSync == this.pendienteSync);
}

class LocalVentasCompanion extends UpdateCompanion<LocalVenta> {
  final Value<String> id;
  final Value<int?> numero;
  final Value<String?> clienteId;
  final Value<String> formaPago;
  final Value<String> tipoComprobante;
  final Value<int> subtotal;
  final Value<int> descuento;
  final Value<int> total;
  final Value<String?> deviceId;
  final Value<DateTime> ocurridaEn;
  final Value<bool> pendienteSync;
  final Value<int> rowid;
  const LocalVentasCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.formaPago = const Value.absent(),
    this.tipoComprobante = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.descuento = const Value.absent(),
    this.total = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.ocurridaEn = const Value.absent(),
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalVentasCompanion.insert({
    required String id,
    this.numero = const Value.absent(),
    this.clienteId = const Value.absent(),
    required String formaPago,
    required String tipoComprobante,
    required int subtotal,
    required int descuento,
    required int total,
    this.deviceId = const Value.absent(),
    required DateTime ocurridaEn,
    this.pendienteSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       formaPago = Value(formaPago),
       tipoComprobante = Value(tipoComprobante),
       subtotal = Value(subtotal),
       descuento = Value(descuento),
       total = Value(total),
       ocurridaEn = Value(ocurridaEn);
  static Insertable<LocalVenta> custom({
    Expression<String>? id,
    Expression<int>? numero,
    Expression<String>? clienteId,
    Expression<String>? formaPago,
    Expression<String>? tipoComprobante,
    Expression<int>? subtotal,
    Expression<int>? descuento,
    Expression<int>? total,
    Expression<String>? deviceId,
    Expression<DateTime>? ocurridaEn,
    Expression<bool>? pendienteSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
      if (clienteId != null) 'cliente_id': clienteId,
      if (formaPago != null) 'forma_pago': formaPago,
      if (tipoComprobante != null) 'tipo_comprobante': tipoComprobante,
      if (subtotal != null) 'subtotal': subtotal,
      if (descuento != null) 'descuento': descuento,
      if (total != null) 'total': total,
      if (deviceId != null) 'device_id': deviceId,
      if (ocurridaEn != null) 'ocurrida_en': ocurridaEn,
      if (pendienteSync != null) 'pendiente_sync': pendienteSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalVentasCompanion copyWith({
    Value<String>? id,
    Value<int?>? numero,
    Value<String?>? clienteId,
    Value<String>? formaPago,
    Value<String>? tipoComprobante,
    Value<int>? subtotal,
    Value<int>? descuento,
    Value<int>? total,
    Value<String?>? deviceId,
    Value<DateTime>? ocurridaEn,
    Value<bool>? pendienteSync,
    Value<int>? rowid,
  }) {
    return LocalVentasCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      clienteId: clienteId ?? this.clienteId,
      formaPago: formaPago ?? this.formaPago,
      tipoComprobante: tipoComprobante ?? this.tipoComprobante,
      subtotal: subtotal ?? this.subtotal,
      descuento: descuento ?? this.descuento,
      total: total ?? this.total,
      deviceId: deviceId ?? this.deviceId,
      ocurridaEn: ocurridaEn ?? this.ocurridaEn,
      pendienteSync: pendienteSync ?? this.pendienteSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<String>(clienteId.value);
    }
    if (formaPago.present) {
      map['forma_pago'] = Variable<String>(formaPago.value);
    }
    if (tipoComprobante.present) {
      map['tipo_comprobante'] = Variable<String>(tipoComprobante.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (descuento.present) {
      map['descuento'] = Variable<int>(descuento.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (ocurridaEn.present) {
      map['ocurrida_en'] = Variable<DateTime>(ocurridaEn.value);
    }
    if (pendienteSync.present) {
      map['pendiente_sync'] = Variable<bool>(pendienteSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalVentasCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('clienteId: $clienteId, ')
          ..write('formaPago: $formaPago, ')
          ..write('tipoComprobante: $tipoComprobante, ')
          ..write('subtotal: $subtotal, ')
          ..write('descuento: $descuento, ')
          ..write('total: $total, ')
          ..write('deviceId: $deviceId, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('pendienteSync: $pendienteSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalVentaItemsTable extends LocalVentaItems
    with TableInfo<$LocalVentaItemsTable, LocalVentaItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalVentaItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ventaIdMeta = const VerificationMeta(
    'ventaId',
  );
  @override
  late final GeneratedColumn<String> ventaId = GeneratedColumn<String>(
    'venta_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _articuloIdMeta = const VerificationMeta(
    'articuloId',
  );
  @override
  late final GeneratedColumn<String> articuloId = GeneratedColumn<String>(
    'articulo_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioUnitarioMeta = const VerificationMeta(
    'precioUnitario',
  );
  @override
  late final GeneratedColumn<int> precioUnitario = GeneratedColumn<int>(
    'precio_unitario',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ventaId,
    articuloId,
    cantidad,
    precioUnitario,
    subtotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_venta_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalVentaItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venta_id')) {
      context.handle(
        _ventaIdMeta,
        ventaId.isAcceptableOrUnknown(data['venta_id']!, _ventaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ventaIdMeta);
    }
    if (data.containsKey('articulo_id')) {
      context.handle(
        _articuloIdMeta,
        articuloId.isAcceptableOrUnknown(data['articulo_id']!, _articuloIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articuloIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
        _precioUnitarioMeta,
        precioUnitario.isAcceptableOrUnknown(
          data['precio_unitario']!,
          _precioUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalVentaItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalVentaItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ventaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venta_id'],
      )!,
      articuloId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}articulo_id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad'],
      )!,
      precioUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_unitario'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
    );
  }

  @override
  $LocalVentaItemsTable createAlias(String alias) {
    return $LocalVentaItemsTable(attachedDatabase, alias);
  }
}

class LocalVentaItem extends DataClass implements Insertable<LocalVentaItem> {
  final String id;
  final String ventaId;
  final String articuloId;
  final int cantidad;
  final int precioUnitario;
  final int subtotal;
  const LocalVentaItem({
    required this.id,
    required this.ventaId,
    required this.articuloId,
    required this.cantidad,
    required this.precioUnitario,
    required this.subtotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['venta_id'] = Variable<String>(ventaId);
    map['articulo_id'] = Variable<String>(articuloId);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario'] = Variable<int>(precioUnitario);
    map['subtotal'] = Variable<int>(subtotal);
    return map;
  }

  LocalVentaItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalVentaItemsCompanion(
      id: Value(id),
      ventaId: Value(ventaId),
      articuloId: Value(articuloId),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
      subtotal: Value(subtotal),
    );
  }

  factory LocalVentaItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalVentaItem(
      id: serializer.fromJson<String>(json['id']),
      ventaId: serializer.fromJson<String>(json['ventaId']),
      articuloId: serializer.fromJson<String>(json['articuloId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitario: serializer.fromJson<int>(json['precioUnitario']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ventaId': serializer.toJson<String>(ventaId),
      'articuloId': serializer.toJson<String>(articuloId),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitario': serializer.toJson<int>(precioUnitario),
      'subtotal': serializer.toJson<int>(subtotal),
    };
  }

  LocalVentaItem copyWith({
    String? id,
    String? ventaId,
    String? articuloId,
    int? cantidad,
    int? precioUnitario,
    int? subtotal,
  }) => LocalVentaItem(
    id: id ?? this.id,
    ventaId: ventaId ?? this.ventaId,
    articuloId: articuloId ?? this.articuloId,
    cantidad: cantidad ?? this.cantidad,
    precioUnitario: precioUnitario ?? this.precioUnitario,
    subtotal: subtotal ?? this.subtotal,
  );
  LocalVentaItem copyWithCompanion(LocalVentaItemsCompanion data) {
    return LocalVentaItem(
      id: data.id.present ? data.id.value : this.id,
      ventaId: data.ventaId.present ? data.ventaId.value : this.ventaId,
      articuloId: data.articuloId.present
          ? data.articuloId.value
          : this.articuloId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalVentaItem(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('articuloId: $articuloId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ventaId, articuloId, cantidad, precioUnitario, subtotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalVentaItem &&
          other.id == this.id &&
          other.ventaId == this.ventaId &&
          other.articuloId == this.articuloId &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario &&
          other.subtotal == this.subtotal);
}

class LocalVentaItemsCompanion extends UpdateCompanion<LocalVentaItem> {
  final Value<String> id;
  final Value<String> ventaId;
  final Value<String> articuloId;
  final Value<int> cantidad;
  final Value<int> precioUnitario;
  final Value<int> subtotal;
  final Value<int> rowid;
  const LocalVentaItemsCompanion({
    this.id = const Value.absent(),
    this.ventaId = const Value.absent(),
    this.articuloId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalVentaItemsCompanion.insert({
    required String id,
    required String ventaId,
    required String articuloId,
    required int cantidad,
    required int precioUnitario,
    required int subtotal,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ventaId = Value(ventaId),
       articuloId = Value(articuloId),
       cantidad = Value(cantidad),
       precioUnitario = Value(precioUnitario),
       subtotal = Value(subtotal);
  static Insertable<LocalVentaItem> custom({
    Expression<String>? id,
    Expression<String>? ventaId,
    Expression<String>? articuloId,
    Expression<int>? cantidad,
    Expression<int>? precioUnitario,
    Expression<int>? subtotal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ventaId != null) 'venta_id': ventaId,
      if (articuloId != null) 'articulo_id': articuloId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
      if (subtotal != null) 'subtotal': subtotal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalVentaItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? ventaId,
    Value<String>? articuloId,
    Value<int>? cantidad,
    Value<int>? precioUnitario,
    Value<int>? subtotal,
    Value<int>? rowid,
  }) {
    return LocalVentaItemsCompanion(
      id: id ?? this.id,
      ventaId: ventaId ?? this.ventaId,
      articuloId: articuloId ?? this.articuloId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      subtotal: subtotal ?? this.subtotal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ventaId.present) {
      map['venta_id'] = Variable<String>(ventaId.value);
    }
    if (articuloId.present) {
      map['articulo_id'] = Variable<String>(articuloId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<int>(precioUnitario.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalVentaItemsCompanion(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('articuloId: $articuloId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('subtotal: $subtotal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueItemsTable extends SyncQueueItems
    with TableInfo<$SyncQueueItemsTable, SyncQueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tablaMeta = const VerificationMeta('tabla');
  @override
  late final GeneratedColumn<String> tabla = GeneratedColumn<String>(
    'tabla',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entidadIdMeta = const VerificationMeta(
    'entidadId',
  );
  @override
  late final GeneratedColumn<String> entidadId = GeneratedColumn<String>(
    'entidad_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _intentosMeta = const VerificationMeta(
    'intentos',
  );
  @override
  late final GeneratedColumn<int> intentos = GeneratedColumn<int>(
    'intentos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tabla,
    entidadId,
    payload,
    creadoEn,
    intentos,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tabla')) {
      context.handle(
        _tablaMeta,
        tabla.isAcceptableOrUnknown(data['tabla']!, _tablaMeta),
      );
    } else if (isInserting) {
      context.missing(_tablaMeta);
    }
    if (data.containsKey('entidad_id')) {
      context.handle(
        _entidadIdMeta,
        entidadId.isAcceptableOrUnknown(data['entidad_id']!, _entidadIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entidadIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    if (data.containsKey('intentos')) {
      context.handle(
        _intentosMeta,
        intentos.isAcceptableOrUnknown(data['intentos']!, _intentosMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tabla: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tabla'],
      )!,
      entidadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entidad_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      intentos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intentos'],
      )!,
    );
  }

  @override
  $SyncQueueItemsTable createAlias(String alias) {
    return $SyncQueueItemsTable(attachedDatabase, alias);
  }
}

class SyncQueueItem extends DataClass implements Insertable<SyncQueueItem> {
  final int id;
  final String tabla;
  final String entidadId;

  /// JSON con los campos a mandar — se arma en el momento de encolar, no
  /// se recalcula después (mismo dato que se hubiera mandado online).
  final String payload;
  final DateTime creadoEn;
  final int intentos;
  const SyncQueueItem({
    required this.id,
    required this.tabla,
    required this.entidadId,
    required this.payload,
    required this.creadoEn,
    required this.intentos,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tabla'] = Variable<String>(tabla);
    map['entidad_id'] = Variable<String>(entidadId);
    map['payload'] = Variable<String>(payload);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['intentos'] = Variable<int>(intentos);
    return map;
  }

  SyncQueueItemsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueItemsCompanion(
      id: Value(id),
      tabla: Value(tabla),
      entidadId: Value(entidadId),
      payload: Value(payload),
      creadoEn: Value(creadoEn),
      intentos: Value(intentos),
    );
  }

  factory SyncQueueItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueItem(
      id: serializer.fromJson<int>(json['id']),
      tabla: serializer.fromJson<String>(json['tabla']),
      entidadId: serializer.fromJson<String>(json['entidadId']),
      payload: serializer.fromJson<String>(json['payload']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      intentos: serializer.fromJson<int>(json['intentos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tabla': serializer.toJson<String>(tabla),
      'entidadId': serializer.toJson<String>(entidadId),
      'payload': serializer.toJson<String>(payload),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'intentos': serializer.toJson<int>(intentos),
    };
  }

  SyncQueueItem copyWith({
    int? id,
    String? tabla,
    String? entidadId,
    String? payload,
    DateTime? creadoEn,
    int? intentos,
  }) => SyncQueueItem(
    id: id ?? this.id,
    tabla: tabla ?? this.tabla,
    entidadId: entidadId ?? this.entidadId,
    payload: payload ?? this.payload,
    creadoEn: creadoEn ?? this.creadoEn,
    intentos: intentos ?? this.intentos,
  );
  SyncQueueItem copyWithCompanion(SyncQueueItemsCompanion data) {
    return SyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      tabla: data.tabla.present ? data.tabla.value : this.tabla,
      entidadId: data.entidadId.present ? data.entidadId.value : this.entidadId,
      payload: data.payload.present ? data.payload.value : this.payload,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      intentos: data.intentos.present ? data.intentos.value : this.intentos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItem(')
          ..write('id: $id, ')
          ..write('tabla: $tabla, ')
          ..write('entidadId: $entidadId, ')
          ..write('payload: $payload, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('intentos: $intentos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tabla, entidadId, payload, creadoEn, intentos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueItem &&
          other.id == this.id &&
          other.tabla == this.tabla &&
          other.entidadId == this.entidadId &&
          other.payload == this.payload &&
          other.creadoEn == this.creadoEn &&
          other.intentos == this.intentos);
}

class SyncQueueItemsCompanion extends UpdateCompanion<SyncQueueItem> {
  final Value<int> id;
  final Value<String> tabla;
  final Value<String> entidadId;
  final Value<String> payload;
  final Value<DateTime> creadoEn;
  final Value<int> intentos;
  const SyncQueueItemsCompanion({
    this.id = const Value.absent(),
    this.tabla = const Value.absent(),
    this.entidadId = const Value.absent(),
    this.payload = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.intentos = const Value.absent(),
  });
  SyncQueueItemsCompanion.insert({
    this.id = const Value.absent(),
    required String tabla,
    required String entidadId,
    required String payload,
    this.creadoEn = const Value.absent(),
    this.intentos = const Value.absent(),
  }) : tabla = Value(tabla),
       entidadId = Value(entidadId),
       payload = Value(payload);
  static Insertable<SyncQueueItem> custom({
    Expression<int>? id,
    Expression<String>? tabla,
    Expression<String>? entidadId,
    Expression<String>? payload,
    Expression<DateTime>? creadoEn,
    Expression<int>? intentos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tabla != null) 'tabla': tabla,
      if (entidadId != null) 'entidad_id': entidadId,
      if (payload != null) 'payload': payload,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (intentos != null) 'intentos': intentos,
    });
  }

  SyncQueueItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? tabla,
    Value<String>? entidadId,
    Value<String>? payload,
    Value<DateTime>? creadoEn,
    Value<int>? intentos,
  }) {
    return SyncQueueItemsCompanion(
      id: id ?? this.id,
      tabla: tabla ?? this.tabla,
      entidadId: entidadId ?? this.entidadId,
      payload: payload ?? this.payload,
      creadoEn: creadoEn ?? this.creadoEn,
      intentos: intentos ?? this.intentos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tabla.present) {
      map['tabla'] = Variable<String>(tabla.value);
    }
    if (entidadId.present) {
      map['entidad_id'] = Variable<String>(entidadId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (intentos.present) {
      map['intentos'] = Variable<int>(intentos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItemsCompanion(')
          ..write('id: $id, ')
          ..write('tabla: $tabla, ')
          ..write('entidadId: $entidadId, ')
          ..write('payload: $payload, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('intentos: $intentos')
          ..write(')'))
        .toString();
  }
}

class $OperacionesPendientesTable extends OperacionesPendientes
    with TableInfo<$OperacionesPendientesTable, OperacionesPendiente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OperacionesPendientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tipoOperacionMeta = const VerificationMeta(
    'tipoOperacion',
  );
  @override
  late final GeneratedColumn<String> tipoOperacion = GeneratedColumn<String>(
    'tipo_operacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entidadLocalIdMeta = const VerificationMeta(
    'entidadLocalId',
  );
  @override
  late final GeneratedColumn<String> entidadLocalId = GeneratedColumn<String>(
    'entidad_local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ocurridaEnMeta = const VerificationMeta(
    'ocurridaEn',
  );
  @override
  late final GeneratedColumn<DateTime> ocurridaEn = GeneratedColumn<DateTime>(
    'ocurrida_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadaEnMeta = const VerificationMeta(
    'creadaEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadaEn = GeneratedColumn<DateTime>(
    'creada_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _intentosMeta = const VerificationMeta(
    'intentos',
  );
  @override
  late final GeneratedColumn<int> intentos = GeneratedColumn<int>(
    'intentos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ultimoErrorMeta = const VerificationMeta(
    'ultimoError',
  );
  @override
  late final GeneratedColumn<String> ultimoError = GeneratedColumn<String>(
    'ultimo_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pendiente'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipoOperacion,
    entidadLocalId,
    payload,
    ocurridaEn,
    creadaEn,
    intentos,
    ultimoError,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'operaciones_pendientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OperacionesPendiente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo_operacion')) {
      context.handle(
        _tipoOperacionMeta,
        tipoOperacion.isAcceptableOrUnknown(
          data['tipo_operacion']!,
          _tipoOperacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoOperacionMeta);
    }
    if (data.containsKey('entidad_local_id')) {
      context.handle(
        _entidadLocalIdMeta,
        entidadLocalId.isAcceptableOrUnknown(
          data['entidad_local_id']!,
          _entidadLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entidadLocalIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('ocurrida_en')) {
      context.handle(
        _ocurridaEnMeta,
        ocurridaEn.isAcceptableOrUnknown(data['ocurrida_en']!, _ocurridaEnMeta),
      );
    } else if (isInserting) {
      context.missing(_ocurridaEnMeta);
    }
    if (data.containsKey('creada_en')) {
      context.handle(
        _creadaEnMeta,
        creadaEn.isAcceptableOrUnknown(data['creada_en']!, _creadaEnMeta),
      );
    }
    if (data.containsKey('intentos')) {
      context.handle(
        _intentosMeta,
        intentos.isAcceptableOrUnknown(data['intentos']!, _intentosMeta),
      );
    }
    if (data.containsKey('ultimo_error')) {
      context.handle(
        _ultimoErrorMeta,
        ultimoError.isAcceptableOrUnknown(
          data['ultimo_error']!,
          _ultimoErrorMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OperacionesPendiente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OperacionesPendiente(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipoOperacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_operacion'],
      )!,
      entidadLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entidad_local_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      ocurridaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ocurrida_en'],
      )!,
      creadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creada_en'],
      )!,
      intentos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intentos'],
      )!,
      ultimoError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ultimo_error'],
      ),
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
    );
  }

  @override
  $OperacionesPendientesTable createAlias(String alias) {
    return $OperacionesPendientesTable(attachedDatabase, alias);
  }
}

class OperacionesPendiente extends DataClass
    implements Insertable<OperacionesPendiente> {
  final int id;

  /// 'crear_cliente' | 'abrir_caja' | 'registrar_movimiento' | 'crear_venta' | 'cerrar_caja'
  final String tipoOperacion;

  /// Id local (= id final, por el id passthrough del backend) de la
  /// entidad que esta operación crea o afecta.
  final String entidadLocalId;

  /// JSON con el mismo body que se manda al endpoint real.
  final String payload;
  final DateTime ocurridaEn;
  final DateTime creadaEn;
  final int intentos;
  final String? ultimoError;

  /// 'pendiente' | 'fallida' — una fallida no se reintenta sola, queda para
  /// que el dueño la revise a mano (poco volumen esperado en un kiosco).
  final String estado;
  const OperacionesPendiente({
    required this.id,
    required this.tipoOperacion,
    required this.entidadLocalId,
    required this.payload,
    required this.ocurridaEn,
    required this.creadaEn,
    required this.intentos,
    this.ultimoError,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo_operacion'] = Variable<String>(tipoOperacion);
    map['entidad_local_id'] = Variable<String>(entidadLocalId);
    map['payload'] = Variable<String>(payload);
    map['ocurrida_en'] = Variable<DateTime>(ocurridaEn);
    map['creada_en'] = Variable<DateTime>(creadaEn);
    map['intentos'] = Variable<int>(intentos);
    if (!nullToAbsent || ultimoError != null) {
      map['ultimo_error'] = Variable<String>(ultimoError);
    }
    map['estado'] = Variable<String>(estado);
    return map;
  }

  OperacionesPendientesCompanion toCompanion(bool nullToAbsent) {
    return OperacionesPendientesCompanion(
      id: Value(id),
      tipoOperacion: Value(tipoOperacion),
      entidadLocalId: Value(entidadLocalId),
      payload: Value(payload),
      ocurridaEn: Value(ocurridaEn),
      creadaEn: Value(creadaEn),
      intentos: Value(intentos),
      ultimoError: ultimoError == null && nullToAbsent
          ? const Value.absent()
          : Value(ultimoError),
      estado: Value(estado),
    );
  }

  factory OperacionesPendiente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OperacionesPendiente(
      id: serializer.fromJson<int>(json['id']),
      tipoOperacion: serializer.fromJson<String>(json['tipoOperacion']),
      entidadLocalId: serializer.fromJson<String>(json['entidadLocalId']),
      payload: serializer.fromJson<String>(json['payload']),
      ocurridaEn: serializer.fromJson<DateTime>(json['ocurridaEn']),
      creadaEn: serializer.fromJson<DateTime>(json['creadaEn']),
      intentos: serializer.fromJson<int>(json['intentos']),
      ultimoError: serializer.fromJson<String?>(json['ultimoError']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipoOperacion': serializer.toJson<String>(tipoOperacion),
      'entidadLocalId': serializer.toJson<String>(entidadLocalId),
      'payload': serializer.toJson<String>(payload),
      'ocurridaEn': serializer.toJson<DateTime>(ocurridaEn),
      'creadaEn': serializer.toJson<DateTime>(creadaEn),
      'intentos': serializer.toJson<int>(intentos),
      'ultimoError': serializer.toJson<String?>(ultimoError),
      'estado': serializer.toJson<String>(estado),
    };
  }

  OperacionesPendiente copyWith({
    int? id,
    String? tipoOperacion,
    String? entidadLocalId,
    String? payload,
    DateTime? ocurridaEn,
    DateTime? creadaEn,
    int? intentos,
    Value<String?> ultimoError = const Value.absent(),
    String? estado,
  }) => OperacionesPendiente(
    id: id ?? this.id,
    tipoOperacion: tipoOperacion ?? this.tipoOperacion,
    entidadLocalId: entidadLocalId ?? this.entidadLocalId,
    payload: payload ?? this.payload,
    ocurridaEn: ocurridaEn ?? this.ocurridaEn,
    creadaEn: creadaEn ?? this.creadaEn,
    intentos: intentos ?? this.intentos,
    ultimoError: ultimoError.present ? ultimoError.value : this.ultimoError,
    estado: estado ?? this.estado,
  );
  OperacionesPendiente copyWithCompanion(OperacionesPendientesCompanion data) {
    return OperacionesPendiente(
      id: data.id.present ? data.id.value : this.id,
      tipoOperacion: data.tipoOperacion.present
          ? data.tipoOperacion.value
          : this.tipoOperacion,
      entidadLocalId: data.entidadLocalId.present
          ? data.entidadLocalId.value
          : this.entidadLocalId,
      payload: data.payload.present ? data.payload.value : this.payload,
      ocurridaEn: data.ocurridaEn.present
          ? data.ocurridaEn.value
          : this.ocurridaEn,
      creadaEn: data.creadaEn.present ? data.creadaEn.value : this.creadaEn,
      intentos: data.intentos.present ? data.intentos.value : this.intentos,
      ultimoError: data.ultimoError.present
          ? data.ultimoError.value
          : this.ultimoError,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OperacionesPendiente(')
          ..write('id: $id, ')
          ..write('tipoOperacion: $tipoOperacion, ')
          ..write('entidadLocalId: $entidadLocalId, ')
          ..write('payload: $payload, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('creadaEn: $creadaEn, ')
          ..write('intentos: $intentos, ')
          ..write('ultimoError: $ultimoError, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tipoOperacion,
    entidadLocalId,
    payload,
    ocurridaEn,
    creadaEn,
    intentos,
    ultimoError,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OperacionesPendiente &&
          other.id == this.id &&
          other.tipoOperacion == this.tipoOperacion &&
          other.entidadLocalId == this.entidadLocalId &&
          other.payload == this.payload &&
          other.ocurridaEn == this.ocurridaEn &&
          other.creadaEn == this.creadaEn &&
          other.intentos == this.intentos &&
          other.ultimoError == this.ultimoError &&
          other.estado == this.estado);
}

class OperacionesPendientesCompanion
    extends UpdateCompanion<OperacionesPendiente> {
  final Value<int> id;
  final Value<String> tipoOperacion;
  final Value<String> entidadLocalId;
  final Value<String> payload;
  final Value<DateTime> ocurridaEn;
  final Value<DateTime> creadaEn;
  final Value<int> intentos;
  final Value<String?> ultimoError;
  final Value<String> estado;
  const OperacionesPendientesCompanion({
    this.id = const Value.absent(),
    this.tipoOperacion = const Value.absent(),
    this.entidadLocalId = const Value.absent(),
    this.payload = const Value.absent(),
    this.ocurridaEn = const Value.absent(),
    this.creadaEn = const Value.absent(),
    this.intentos = const Value.absent(),
    this.ultimoError = const Value.absent(),
    this.estado = const Value.absent(),
  });
  OperacionesPendientesCompanion.insert({
    this.id = const Value.absent(),
    required String tipoOperacion,
    required String entidadLocalId,
    required String payload,
    required DateTime ocurridaEn,
    this.creadaEn = const Value.absent(),
    this.intentos = const Value.absent(),
    this.ultimoError = const Value.absent(),
    this.estado = const Value.absent(),
  }) : tipoOperacion = Value(tipoOperacion),
       entidadLocalId = Value(entidadLocalId),
       payload = Value(payload),
       ocurridaEn = Value(ocurridaEn);
  static Insertable<OperacionesPendiente> custom({
    Expression<int>? id,
    Expression<String>? tipoOperacion,
    Expression<String>? entidadLocalId,
    Expression<String>? payload,
    Expression<DateTime>? ocurridaEn,
    Expression<DateTime>? creadaEn,
    Expression<int>? intentos,
    Expression<String>? ultimoError,
    Expression<String>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipoOperacion != null) 'tipo_operacion': tipoOperacion,
      if (entidadLocalId != null) 'entidad_local_id': entidadLocalId,
      if (payload != null) 'payload': payload,
      if (ocurridaEn != null) 'ocurrida_en': ocurridaEn,
      if (creadaEn != null) 'creada_en': creadaEn,
      if (intentos != null) 'intentos': intentos,
      if (ultimoError != null) 'ultimo_error': ultimoError,
      if (estado != null) 'estado': estado,
    });
  }

  OperacionesPendientesCompanion copyWith({
    Value<int>? id,
    Value<String>? tipoOperacion,
    Value<String>? entidadLocalId,
    Value<String>? payload,
    Value<DateTime>? ocurridaEn,
    Value<DateTime>? creadaEn,
    Value<int>? intentos,
    Value<String?>? ultimoError,
    Value<String>? estado,
  }) {
    return OperacionesPendientesCompanion(
      id: id ?? this.id,
      tipoOperacion: tipoOperacion ?? this.tipoOperacion,
      entidadLocalId: entidadLocalId ?? this.entidadLocalId,
      payload: payload ?? this.payload,
      ocurridaEn: ocurridaEn ?? this.ocurridaEn,
      creadaEn: creadaEn ?? this.creadaEn,
      intentos: intentos ?? this.intentos,
      ultimoError: ultimoError ?? this.ultimoError,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipoOperacion.present) {
      map['tipo_operacion'] = Variable<String>(tipoOperacion.value);
    }
    if (entidadLocalId.present) {
      map['entidad_local_id'] = Variable<String>(entidadLocalId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (ocurridaEn.present) {
      map['ocurrida_en'] = Variable<DateTime>(ocurridaEn.value);
    }
    if (creadaEn.present) {
      map['creada_en'] = Variable<DateTime>(creadaEn.value);
    }
    if (intentos.present) {
      map['intentos'] = Variable<int>(intentos.value);
    }
    if (ultimoError.present) {
      map['ultimo_error'] = Variable<String>(ultimoError.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperacionesPendientesCompanion(')
          ..write('id: $id, ')
          ..write('tipoOperacion: $tipoOperacion, ')
          ..write('entidadLocalId: $entidadLocalId, ')
          ..write('payload: $payload, ')
          ..write('ocurridaEn: $ocurridaEn, ')
          ..write('creadaEn: $creadaEn, ')
          ..write('intentos: $intentos, ')
          ..write('ultimoError: $ultimoError, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
    'clave',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
    'valor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
        _claveMeta,
        clave.isAcceptableOrUnknown(data['clave']!, _claveMeta),
      );
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  SyncMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaData(
      clave: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clave'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor'],
      )!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaData extends DataClass implements Insertable<SyncMetaData> {
  final String clave;
  final String valor;
  const SyncMetaData({required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(clave: Value(clave), valor: Value(valor));
  }

  factory SyncMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaData(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  SyncMetaData copyWith({String? clave, String? valor}) =>
      SyncMetaData(clave: clave ?? this.clave, valor: valor ?? this.valor);
  SyncMetaData copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaData(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaData(')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaData &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaData> {
  final Value<String> clave;
  final Value<String> valor;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String clave,
    required String valor,
    this.rowid = const Value.absent(),
  }) : clave = Value(clave),
       valor = Value(valor);
  static Insertable<SyncMetaData> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? clave,
    Value<String>? valor,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalArticulosTable localArticulos = $LocalArticulosTable(this);
  late final $LocalClientesTable localClientes = $LocalClientesTable(this);
  late final $LocalCajasTable localCajas = $LocalCajasTable(this);
  late final $LocalCajaMovimientosTable localCajaMovimientos =
      $LocalCajaMovimientosTable(this);
  late final $LocalVentasTable localVentas = $LocalVentasTable(this);
  late final $LocalVentaItemsTable localVentaItems = $LocalVentaItemsTable(
    this,
  );
  late final $SyncQueueItemsTable syncQueueItems = $SyncQueueItemsTable(this);
  late final $OperacionesPendientesTable operacionesPendientes =
      $OperacionesPendientesTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localArticulos,
    localClientes,
    localCajas,
    localCajaMovimientos,
    localVentas,
    localVentaItems,
    syncQueueItems,
    operacionesPendientes,
    syncMeta,
  ];
}

typedef $$LocalArticulosTableCreateCompanionBuilder =
    LocalArticulosCompanion Function({
      required String id,
      Value<String?> codigoBarras,
      Value<String?> codigoInterno,
      required String descripcion,
      Value<String?> marca,
      Value<String?> rubro,
      Value<String?> imagenUrl,
      required int precioCosto,
      required int precioVenta,
      Value<int?> precioPromocional,
      Value<DateTime?> promocionDesde,
      Value<DateTime?> promocionHasta,
      Value<bool> activo,
      Value<int?> stockActual,
      Value<int> version,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });
typedef $$LocalArticulosTableUpdateCompanionBuilder =
    LocalArticulosCompanion Function({
      Value<String> id,
      Value<String?> codigoBarras,
      Value<String?> codigoInterno,
      Value<String> descripcion,
      Value<String?> marca,
      Value<String?> rubro,
      Value<String?> imagenUrl,
      Value<int> precioCosto,
      Value<int> precioVenta,
      Value<int?> precioPromocional,
      Value<DateTime?> promocionDesde,
      Value<DateTime?> promocionHasta,
      Value<bool> activo,
      Value<int?> stockActual,
      Value<int> version,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });

class $$LocalArticulosTableFilterComposer
    extends Composer<_$AppDatabase, $LocalArticulosTable> {
  $$LocalArticulosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigoBarras => $composableBuilder(
    column: $table.codigoBarras,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigoInterno => $composableBuilder(
    column: $table.codigoInterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rubro => $composableBuilder(
    column: $table.rubro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagenUrl => $composableBuilder(
    column: $table.imagenUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioPromocional => $composableBuilder(
    column: $table.precioPromocional,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get promocionDesde => $composableBuilder(
    column: $table.promocionDesde,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get promocionHasta => $composableBuilder(
    column: $table.promocionHasta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalArticulosTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalArticulosTable> {
  $$LocalArticulosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigoBarras => $composableBuilder(
    column: $table.codigoBarras,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigoInterno => $composableBuilder(
    column: $table.codigoInterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rubro => $composableBuilder(
    column: $table.rubro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagenUrl => $composableBuilder(
    column: $table.imagenUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioPromocional => $composableBuilder(
    column: $table.precioPromocional,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get promocionDesde => $composableBuilder(
    column: $table.promocionDesde,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get promocionHasta => $composableBuilder(
    column: $table.promocionHasta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalArticulosTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalArticulosTable> {
  $$LocalArticulosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigoBarras => $composableBuilder(
    column: $table.codigoBarras,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codigoInterno => $composableBuilder(
    column: $table.codigoInterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get rubro =>
      $composableBuilder(column: $table.rubro, builder: (column) => column);

  GeneratedColumn<String> get imagenUrl =>
      $composableBuilder(column: $table.imagenUrl, builder: (column) => column);

  GeneratedColumn<int> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioPromocional => $composableBuilder(
    column: $table.precioPromocional,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get promocionDesde => $composableBuilder(
    column: $table.promocionDesde,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get promocionHasta => $composableBuilder(
    column: $table.promocionHasta,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<int> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => column,
  );
}

class $$LocalArticulosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalArticulosTable,
          LocalArticulo,
          $$LocalArticulosTableFilterComposer,
          $$LocalArticulosTableOrderingComposer,
          $$LocalArticulosTableAnnotationComposer,
          $$LocalArticulosTableCreateCompanionBuilder,
          $$LocalArticulosTableUpdateCompanionBuilder,
          (
            LocalArticulo,
            BaseReferences<_$AppDatabase, $LocalArticulosTable, LocalArticulo>,
          ),
          LocalArticulo,
          PrefetchHooks Function()
        > {
  $$LocalArticulosTableTableManager(
    _$AppDatabase db,
    $LocalArticulosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalArticulosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalArticulosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalArticulosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> codigoBarras = const Value.absent(),
                Value<String?> codigoInterno = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String?> marca = const Value.absent(),
                Value<String?> rubro = const Value.absent(),
                Value<String?> imagenUrl = const Value.absent(),
                Value<int> precioCosto = const Value.absent(),
                Value<int> precioVenta = const Value.absent(),
                Value<int?> precioPromocional = const Value.absent(),
                Value<DateTime?> promocionDesde = const Value.absent(),
                Value<DateTime?> promocionHasta = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int?> stockActual = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalArticulosCompanion(
                id: id,
                codigoBarras: codigoBarras,
                codigoInterno: codigoInterno,
                descripcion: descripcion,
                marca: marca,
                rubro: rubro,
                imagenUrl: imagenUrl,
                precioCosto: precioCosto,
                precioVenta: precioVenta,
                precioPromocional: precioPromocional,
                promocionDesde: promocionDesde,
                promocionHasta: promocionHasta,
                activo: activo,
                stockActual: stockActual,
                version: version,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> codigoBarras = const Value.absent(),
                Value<String?> codigoInterno = const Value.absent(),
                required String descripcion,
                Value<String?> marca = const Value.absent(),
                Value<String?> rubro = const Value.absent(),
                Value<String?> imagenUrl = const Value.absent(),
                required int precioCosto,
                required int precioVenta,
                Value<int?> precioPromocional = const Value.absent(),
                Value<DateTime?> promocionDesde = const Value.absent(),
                Value<DateTime?> promocionHasta = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int?> stockActual = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalArticulosCompanion.insert(
                id: id,
                codigoBarras: codigoBarras,
                codigoInterno: codigoInterno,
                descripcion: descripcion,
                marca: marca,
                rubro: rubro,
                imagenUrl: imagenUrl,
                precioCosto: precioCosto,
                precioVenta: precioVenta,
                precioPromocional: precioPromocional,
                promocionDesde: promocionDesde,
                promocionHasta: promocionHasta,
                activo: activo,
                stockActual: stockActual,
                version: version,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalArticulosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalArticulosTable,
      LocalArticulo,
      $$LocalArticulosTableFilterComposer,
      $$LocalArticulosTableOrderingComposer,
      $$LocalArticulosTableAnnotationComposer,
      $$LocalArticulosTableCreateCompanionBuilder,
      $$LocalArticulosTableUpdateCompanionBuilder,
      (
        LocalArticulo,
        BaseReferences<_$AppDatabase, $LocalArticulosTable, LocalArticulo>,
      ),
      LocalArticulo,
      PrefetchHooks Function()
    >;
typedef $$LocalClientesTableCreateCompanionBuilder =
    LocalClientesCompanion Function({
      required String id,
      required String nombre,
      Value<String?> dniCuit,
      Value<String> condicionIva,
      Value<String?> direccion,
      Value<String?> telefono,
      Value<String?> email,
      Value<String?> zona,
      Value<int> porcentajeDescuento,
      Value<bool> activo,
      Value<int?> limiteCuentaCorriente,
      Value<int> version,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });
typedef $$LocalClientesTableUpdateCompanionBuilder =
    LocalClientesCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<String?> dniCuit,
      Value<String> condicionIva,
      Value<String?> direccion,
      Value<String?> telefono,
      Value<String?> email,
      Value<String?> zona,
      Value<int> porcentajeDescuento,
      Value<bool> activo,
      Value<int?> limiteCuentaCorriente,
      Value<int> version,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });

class $$LocalClientesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalClientesTable> {
  $$LocalClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dniCuit => $composableBuilder(
    column: $table.dniCuit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condicionIva => $composableBuilder(
    column: $table.condicionIva,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zona => $composableBuilder(
    column: $table.zona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get porcentajeDescuento => $composableBuilder(
    column: $table.porcentajeDescuento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get limiteCuentaCorriente => $composableBuilder(
    column: $table.limiteCuentaCorriente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalClientesTable> {
  $$LocalClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dniCuit => $composableBuilder(
    column: $table.dniCuit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condicionIva => $composableBuilder(
    column: $table.condicionIva,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zona => $composableBuilder(
    column: $table.zona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get porcentajeDescuento => $composableBuilder(
    column: $table.porcentajeDescuento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get limiteCuentaCorriente => $composableBuilder(
    column: $table.limiteCuentaCorriente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalClientesTable> {
  $$LocalClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get dniCuit =>
      $composableBuilder(column: $table.dniCuit, builder: (column) => column);

  GeneratedColumn<String> get condicionIva => $composableBuilder(
    column: $table.condicionIva,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get zona =>
      $composableBuilder(column: $table.zona, builder: (column) => column);

  GeneratedColumn<int> get porcentajeDescuento => $composableBuilder(
    column: $table.porcentajeDescuento,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<int> get limiteCuentaCorriente => $composableBuilder(
    column: $table.limiteCuentaCorriente,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => column,
  );
}

class $$LocalClientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalClientesTable,
          LocalCliente,
          $$LocalClientesTableFilterComposer,
          $$LocalClientesTableOrderingComposer,
          $$LocalClientesTableAnnotationComposer,
          $$LocalClientesTableCreateCompanionBuilder,
          $$LocalClientesTableUpdateCompanionBuilder,
          (
            LocalCliente,
            BaseReferences<_$AppDatabase, $LocalClientesTable, LocalCliente>,
          ),
          LocalCliente,
          PrefetchHooks Function()
        > {
  $$LocalClientesTableTableManager(_$AppDatabase db, $LocalClientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> dniCuit = const Value.absent(),
                Value<String> condicionIva = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> zona = const Value.absent(),
                Value<int> porcentajeDescuento = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int?> limiteCuentaCorriente = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalClientesCompanion(
                id: id,
                nombre: nombre,
                dniCuit: dniCuit,
                condicionIva: condicionIva,
                direccion: direccion,
                telefono: telefono,
                email: email,
                zona: zona,
                porcentajeDescuento: porcentajeDescuento,
                activo: activo,
                limiteCuentaCorriente: limiteCuentaCorriente,
                version: version,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                Value<String?> dniCuit = const Value.absent(),
                Value<String> condicionIva = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> zona = const Value.absent(),
                Value<int> porcentajeDescuento = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int?> limiteCuentaCorriente = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalClientesCompanion.insert(
                id: id,
                nombre: nombre,
                dniCuit: dniCuit,
                condicionIva: condicionIva,
                direccion: direccion,
                telefono: telefono,
                email: email,
                zona: zona,
                porcentajeDescuento: porcentajeDescuento,
                activo: activo,
                limiteCuentaCorriente: limiteCuentaCorriente,
                version: version,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalClientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalClientesTable,
      LocalCliente,
      $$LocalClientesTableFilterComposer,
      $$LocalClientesTableOrderingComposer,
      $$LocalClientesTableAnnotationComposer,
      $$LocalClientesTableCreateCompanionBuilder,
      $$LocalClientesTableUpdateCompanionBuilder,
      (
        LocalCliente,
        BaseReferences<_$AppDatabase, $LocalClientesTable, LocalCliente>,
      ),
      LocalCliente,
      PrefetchHooks Function()
    >;
typedef $$LocalCajasTableCreateCompanionBuilder =
    LocalCajasCompanion Function({
      required String id,
      required int montoInicial,
      Value<int?> montoFinalDeclarado,
      Value<int?> montoFinalCalculado,
      Value<int?> diferencia,
      required String estado,
      required String deviceId,
      Value<String?> nombreDispositivo,
      required DateTime ocurridaEn,
      Value<DateTime?> cerradaEn,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });
typedef $$LocalCajasTableUpdateCompanionBuilder =
    LocalCajasCompanion Function({
      Value<String> id,
      Value<int> montoInicial,
      Value<int?> montoFinalDeclarado,
      Value<int?> montoFinalCalculado,
      Value<int?> diferencia,
      Value<String> estado,
      Value<String> deviceId,
      Value<String?> nombreDispositivo,
      Value<DateTime> ocurridaEn,
      Value<DateTime?> cerradaEn,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });

class $$LocalCajasTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCajasTable> {
  $$LocalCajasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get montoInicial => $composableBuilder(
    column: $table.montoInicial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get montoFinalDeclarado => $composableBuilder(
    column: $table.montoFinalDeclarado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get montoFinalCalculado => $composableBuilder(
    column: $table.montoFinalCalculado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get diferencia => $composableBuilder(
    column: $table.diferencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreDispositivo => $composableBuilder(
    column: $table.nombreDispositivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cerradaEn => $composableBuilder(
    column: $table.cerradaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalCajasTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCajasTable> {
  $$LocalCajasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get montoInicial => $composableBuilder(
    column: $table.montoInicial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get montoFinalDeclarado => $composableBuilder(
    column: $table.montoFinalDeclarado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get montoFinalCalculado => $composableBuilder(
    column: $table.montoFinalCalculado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get diferencia => $composableBuilder(
    column: $table.diferencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreDispositivo => $composableBuilder(
    column: $table.nombreDispositivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cerradaEn => $composableBuilder(
    column: $table.cerradaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalCajasTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCajasTable> {
  $$LocalCajasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get montoInicial => $composableBuilder(
    column: $table.montoInicial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get montoFinalDeclarado => $composableBuilder(
    column: $table.montoFinalDeclarado,
    builder: (column) => column,
  );

  GeneratedColumn<int> get montoFinalCalculado => $composableBuilder(
    column: $table.montoFinalCalculado,
    builder: (column) => column,
  );

  GeneratedColumn<int> get diferencia => $composableBuilder(
    column: $table.diferencia,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get nombreDispositivo => $composableBuilder(
    column: $table.nombreDispositivo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cerradaEn =>
      $composableBuilder(column: $table.cerradaEn, builder: (column) => column);

  GeneratedColumn<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => column,
  );
}

class $$LocalCajasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCajasTable,
          LocalCaja,
          $$LocalCajasTableFilterComposer,
          $$LocalCajasTableOrderingComposer,
          $$LocalCajasTableAnnotationComposer,
          $$LocalCajasTableCreateCompanionBuilder,
          $$LocalCajasTableUpdateCompanionBuilder,
          (
            LocalCaja,
            BaseReferences<_$AppDatabase, $LocalCajasTable, LocalCaja>,
          ),
          LocalCaja,
          PrefetchHooks Function()
        > {
  $$LocalCajasTableTableManager(_$AppDatabase db, $LocalCajasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCajasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCajasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCajasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> montoInicial = const Value.absent(),
                Value<int?> montoFinalDeclarado = const Value.absent(),
                Value<int?> montoFinalCalculado = const Value.absent(),
                Value<int?> diferencia = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String?> nombreDispositivo = const Value.absent(),
                Value<DateTime> ocurridaEn = const Value.absent(),
                Value<DateTime?> cerradaEn = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCajasCompanion(
                id: id,
                montoInicial: montoInicial,
                montoFinalDeclarado: montoFinalDeclarado,
                montoFinalCalculado: montoFinalCalculado,
                diferencia: diferencia,
                estado: estado,
                deviceId: deviceId,
                nombreDispositivo: nombreDispositivo,
                ocurridaEn: ocurridaEn,
                cerradaEn: cerradaEn,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int montoInicial,
                Value<int?> montoFinalDeclarado = const Value.absent(),
                Value<int?> montoFinalCalculado = const Value.absent(),
                Value<int?> diferencia = const Value.absent(),
                required String estado,
                required String deviceId,
                Value<String?> nombreDispositivo = const Value.absent(),
                required DateTime ocurridaEn,
                Value<DateTime?> cerradaEn = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCajasCompanion.insert(
                id: id,
                montoInicial: montoInicial,
                montoFinalDeclarado: montoFinalDeclarado,
                montoFinalCalculado: montoFinalCalculado,
                diferencia: diferencia,
                estado: estado,
                deviceId: deviceId,
                nombreDispositivo: nombreDispositivo,
                ocurridaEn: ocurridaEn,
                cerradaEn: cerradaEn,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalCajasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCajasTable,
      LocalCaja,
      $$LocalCajasTableFilterComposer,
      $$LocalCajasTableOrderingComposer,
      $$LocalCajasTableAnnotationComposer,
      $$LocalCajasTableCreateCompanionBuilder,
      $$LocalCajasTableUpdateCompanionBuilder,
      (LocalCaja, BaseReferences<_$AppDatabase, $LocalCajasTable, LocalCaja>),
      LocalCaja,
      PrefetchHooks Function()
    >;
typedef $$LocalCajaMovimientosTableCreateCompanionBuilder =
    LocalCajaMovimientosCompanion Function({
      required String id,
      required String cajaId,
      required String tipo,
      required int monto,
      required String nota,
      required DateTime ocurridaEn,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });
typedef $$LocalCajaMovimientosTableUpdateCompanionBuilder =
    LocalCajaMovimientosCompanion Function({
      Value<String> id,
      Value<String> cajaId,
      Value<String> tipo,
      Value<int> monto,
      Value<String> nota,
      Value<DateTime> ocurridaEn,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });

class $$LocalCajaMovimientosTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCajaMovimientosTable> {
  $$LocalCajaMovimientosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cajaId => $composableBuilder(
    column: $table.cajaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalCajaMovimientosTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCajaMovimientosTable> {
  $$LocalCajaMovimientosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cajaId => $composableBuilder(
    column: $table.cajaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalCajaMovimientosTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCajaMovimientosTable> {
  $$LocalCajaMovimientosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cajaId =>
      $composableBuilder(column: $table.cajaId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => column,
  );
}

class $$LocalCajaMovimientosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCajaMovimientosTable,
          LocalCajaMovimiento,
          $$LocalCajaMovimientosTableFilterComposer,
          $$LocalCajaMovimientosTableOrderingComposer,
          $$LocalCajaMovimientosTableAnnotationComposer,
          $$LocalCajaMovimientosTableCreateCompanionBuilder,
          $$LocalCajaMovimientosTableUpdateCompanionBuilder,
          (
            LocalCajaMovimiento,
            BaseReferences<
              _$AppDatabase,
              $LocalCajaMovimientosTable,
              LocalCajaMovimiento
            >,
          ),
          LocalCajaMovimiento,
          PrefetchHooks Function()
        > {
  $$LocalCajaMovimientosTableTableManager(
    _$AppDatabase db,
    $LocalCajaMovimientosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCajaMovimientosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCajaMovimientosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalCajaMovimientosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cajaId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<String> nota = const Value.absent(),
                Value<DateTime> ocurridaEn = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCajaMovimientosCompanion(
                id: id,
                cajaId: cajaId,
                tipo: tipo,
                monto: monto,
                nota: nota,
                ocurridaEn: ocurridaEn,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cajaId,
                required String tipo,
                required int monto,
                required String nota,
                required DateTime ocurridaEn,
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCajaMovimientosCompanion.insert(
                id: id,
                cajaId: cajaId,
                tipo: tipo,
                monto: monto,
                nota: nota,
                ocurridaEn: ocurridaEn,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalCajaMovimientosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCajaMovimientosTable,
      LocalCajaMovimiento,
      $$LocalCajaMovimientosTableFilterComposer,
      $$LocalCajaMovimientosTableOrderingComposer,
      $$LocalCajaMovimientosTableAnnotationComposer,
      $$LocalCajaMovimientosTableCreateCompanionBuilder,
      $$LocalCajaMovimientosTableUpdateCompanionBuilder,
      (
        LocalCajaMovimiento,
        BaseReferences<
          _$AppDatabase,
          $LocalCajaMovimientosTable,
          LocalCajaMovimiento
        >,
      ),
      LocalCajaMovimiento,
      PrefetchHooks Function()
    >;
typedef $$LocalVentasTableCreateCompanionBuilder =
    LocalVentasCompanion Function({
      required String id,
      Value<int?> numero,
      Value<String?> clienteId,
      required String formaPago,
      required String tipoComprobante,
      required int subtotal,
      required int descuento,
      required int total,
      Value<String?> deviceId,
      required DateTime ocurridaEn,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });
typedef $$LocalVentasTableUpdateCompanionBuilder =
    LocalVentasCompanion Function({
      Value<String> id,
      Value<int?> numero,
      Value<String?> clienteId,
      Value<String> formaPago,
      Value<String> tipoComprobante,
      Value<int> subtotal,
      Value<int> descuento,
      Value<int> total,
      Value<String?> deviceId,
      Value<DateTime> ocurridaEn,
      Value<bool> pendienteSync,
      Value<int> rowid,
    });

class $$LocalVentasTableFilterComposer
    extends Composer<_$AppDatabase, $LocalVentasTable> {
  $$LocalVentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clienteId => $composableBuilder(
    column: $table.clienteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formaPago => $composableBuilder(
    column: $table.formaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoComprobante => $composableBuilder(
    column: $table.tipoComprobante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get descuento => $composableBuilder(
    column: $table.descuento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalVentasTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalVentasTable> {
  $$LocalVentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteId => $composableBuilder(
    column: $table.clienteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formaPago => $composableBuilder(
    column: $table.formaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoComprobante => $composableBuilder(
    column: $table.tipoComprobante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get descuento => $composableBuilder(
    column: $table.descuento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalVentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalVentasTable> {
  $$LocalVentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get formaPago =>
      $composableBuilder(column: $table.formaPago, builder: (column) => column);

  GeneratedColumn<String> get tipoComprobante => $composableBuilder(
    column: $table.tipoComprobante,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get descuento =>
      $composableBuilder(column: $table.descuento, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendienteSync => $composableBuilder(
    column: $table.pendienteSync,
    builder: (column) => column,
  );
}

class $$LocalVentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalVentasTable,
          LocalVenta,
          $$LocalVentasTableFilterComposer,
          $$LocalVentasTableOrderingComposer,
          $$LocalVentasTableAnnotationComposer,
          $$LocalVentasTableCreateCompanionBuilder,
          $$LocalVentasTableUpdateCompanionBuilder,
          (
            LocalVenta,
            BaseReferences<_$AppDatabase, $LocalVentasTable, LocalVenta>,
          ),
          LocalVenta,
          PrefetchHooks Function()
        > {
  $$LocalVentasTableTableManager(_$AppDatabase db, $LocalVentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalVentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalVentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalVentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> numero = const Value.absent(),
                Value<String?> clienteId = const Value.absent(),
                Value<String> formaPago = const Value.absent(),
                Value<String> tipoComprobante = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> descuento = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<DateTime> ocurridaEn = const Value.absent(),
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVentasCompanion(
                id: id,
                numero: numero,
                clienteId: clienteId,
                formaPago: formaPago,
                tipoComprobante: tipoComprobante,
                subtotal: subtotal,
                descuento: descuento,
                total: total,
                deviceId: deviceId,
                ocurridaEn: ocurridaEn,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> numero = const Value.absent(),
                Value<String?> clienteId = const Value.absent(),
                required String formaPago,
                required String tipoComprobante,
                required int subtotal,
                required int descuento,
                required int total,
                Value<String?> deviceId = const Value.absent(),
                required DateTime ocurridaEn,
                Value<bool> pendienteSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVentasCompanion.insert(
                id: id,
                numero: numero,
                clienteId: clienteId,
                formaPago: formaPago,
                tipoComprobante: tipoComprobante,
                subtotal: subtotal,
                descuento: descuento,
                total: total,
                deviceId: deviceId,
                ocurridaEn: ocurridaEn,
                pendienteSync: pendienteSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalVentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalVentasTable,
      LocalVenta,
      $$LocalVentasTableFilterComposer,
      $$LocalVentasTableOrderingComposer,
      $$LocalVentasTableAnnotationComposer,
      $$LocalVentasTableCreateCompanionBuilder,
      $$LocalVentasTableUpdateCompanionBuilder,
      (
        LocalVenta,
        BaseReferences<_$AppDatabase, $LocalVentasTable, LocalVenta>,
      ),
      LocalVenta,
      PrefetchHooks Function()
    >;
typedef $$LocalVentaItemsTableCreateCompanionBuilder =
    LocalVentaItemsCompanion Function({
      required String id,
      required String ventaId,
      required String articuloId,
      required int cantidad,
      required int precioUnitario,
      required int subtotal,
      Value<int> rowid,
    });
typedef $$LocalVentaItemsTableUpdateCompanionBuilder =
    LocalVentaItemsCompanion Function({
      Value<String> id,
      Value<String> ventaId,
      Value<String> articuloId,
      Value<int> cantidad,
      Value<int> precioUnitario,
      Value<int> subtotal,
      Value<int> rowid,
    });

class $$LocalVentaItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalVentaItemsTable> {
  $$LocalVentaItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ventaId => $composableBuilder(
    column: $table.ventaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get articuloId => $composableBuilder(
    column: $table.articuloId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalVentaItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalVentaItemsTable> {
  $$LocalVentaItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ventaId => $composableBuilder(
    column: $table.ventaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articuloId => $composableBuilder(
    column: $table.articuloId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalVentaItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalVentaItemsTable> {
  $$LocalVentaItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ventaId =>
      $composableBuilder(column: $table.ventaId, builder: (column) => column);

  GeneratedColumn<String> get articuloId => $composableBuilder(
    column: $table.articuloId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);
}

class $$LocalVentaItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalVentaItemsTable,
          LocalVentaItem,
          $$LocalVentaItemsTableFilterComposer,
          $$LocalVentaItemsTableOrderingComposer,
          $$LocalVentaItemsTableAnnotationComposer,
          $$LocalVentaItemsTableCreateCompanionBuilder,
          $$LocalVentaItemsTableUpdateCompanionBuilder,
          (
            LocalVentaItem,
            BaseReferences<
              _$AppDatabase,
              $LocalVentaItemsTable,
              LocalVentaItem
            >,
          ),
          LocalVentaItem,
          PrefetchHooks Function()
        > {
  $$LocalVentaItemsTableTableManager(
    _$AppDatabase db,
    $LocalVentaItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalVentaItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalVentaItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalVentaItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ventaId = const Value.absent(),
                Value<String> articuloId = const Value.absent(),
                Value<int> cantidad = const Value.absent(),
                Value<int> precioUnitario = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVentaItemsCompanion(
                id: id,
                ventaId: ventaId,
                articuloId: articuloId,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
                subtotal: subtotal,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ventaId,
                required String articuloId,
                required int cantidad,
                required int precioUnitario,
                required int subtotal,
                Value<int> rowid = const Value.absent(),
              }) => LocalVentaItemsCompanion.insert(
                id: id,
                ventaId: ventaId,
                articuloId: articuloId,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
                subtotal: subtotal,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalVentaItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalVentaItemsTable,
      LocalVentaItem,
      $$LocalVentaItemsTableFilterComposer,
      $$LocalVentaItemsTableOrderingComposer,
      $$LocalVentaItemsTableAnnotationComposer,
      $$LocalVentaItemsTableCreateCompanionBuilder,
      $$LocalVentaItemsTableUpdateCompanionBuilder,
      (
        LocalVentaItem,
        BaseReferences<_$AppDatabase, $LocalVentaItemsTable, LocalVentaItem>,
      ),
      LocalVentaItem,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueItemsTableCreateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      Value<int> id,
      required String tabla,
      required String entidadId,
      required String payload,
      Value<DateTime> creadoEn,
      Value<int> intentos,
    });
typedef $$SyncQueueItemsTableUpdateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      Value<int> id,
      Value<String> tabla,
      Value<String> entidadId,
      Value<String> payload,
      Value<DateTime> creadoEn,
      Value<int> intentos,
    });

class $$SyncQueueItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tabla => $composableBuilder(
    column: $table.tabla,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entidadId => $composableBuilder(
    column: $table.entidadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intentos => $composableBuilder(
    column: $table.intentos,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tabla => $composableBuilder(
    column: $table.tabla,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entidadId => $composableBuilder(
    column: $table.entidadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intentos => $composableBuilder(
    column: $table.intentos,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tabla =>
      $composableBuilder(column: $table.tabla, builder: (column) => column);

  GeneratedColumn<String> get entidadId =>
      $composableBuilder(column: $table.entidadId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<int> get intentos =>
      $composableBuilder(column: $table.intentos, builder: (column) => column);
}

class $$SyncQueueItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueItemsTable,
          SyncQueueItem,
          $$SyncQueueItemsTableFilterComposer,
          $$SyncQueueItemsTableOrderingComposer,
          $$SyncQueueItemsTableAnnotationComposer,
          $$SyncQueueItemsTableCreateCompanionBuilder,
          $$SyncQueueItemsTableUpdateCompanionBuilder,
          (
            SyncQueueItem,
            BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
          ),
          SyncQueueItem,
          PrefetchHooks Function()
        > {
  $$SyncQueueItemsTableTableManager(
    _$AppDatabase db,
    $SyncQueueItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tabla = const Value.absent(),
                Value<String> entidadId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> intentos = const Value.absent(),
              }) => SyncQueueItemsCompanion(
                id: id,
                tabla: tabla,
                entidadId: entidadId,
                payload: payload,
                creadoEn: creadoEn,
                intentos: intentos,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tabla,
                required String entidadId,
                required String payload,
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> intentos = const Value.absent(),
              }) => SyncQueueItemsCompanion.insert(
                id: id,
                tabla: tabla,
                entidadId: entidadId,
                payload: payload,
                creadoEn: creadoEn,
                intentos: intentos,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueItemsTable,
      SyncQueueItem,
      $$SyncQueueItemsTableFilterComposer,
      $$SyncQueueItemsTableOrderingComposer,
      $$SyncQueueItemsTableAnnotationComposer,
      $$SyncQueueItemsTableCreateCompanionBuilder,
      $$SyncQueueItemsTableUpdateCompanionBuilder,
      (
        SyncQueueItem,
        BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
      ),
      SyncQueueItem,
      PrefetchHooks Function()
    >;
typedef $$OperacionesPendientesTableCreateCompanionBuilder =
    OperacionesPendientesCompanion Function({
      Value<int> id,
      required String tipoOperacion,
      required String entidadLocalId,
      required String payload,
      required DateTime ocurridaEn,
      Value<DateTime> creadaEn,
      Value<int> intentos,
      Value<String?> ultimoError,
      Value<String> estado,
    });
typedef $$OperacionesPendientesTableUpdateCompanionBuilder =
    OperacionesPendientesCompanion Function({
      Value<int> id,
      Value<String> tipoOperacion,
      Value<String> entidadLocalId,
      Value<String> payload,
      Value<DateTime> ocurridaEn,
      Value<DateTime> creadaEn,
      Value<int> intentos,
      Value<String?> ultimoError,
      Value<String> estado,
    });

class $$OperacionesPendientesTableFilterComposer
    extends Composer<_$AppDatabase, $OperacionesPendientesTable> {
  $$OperacionesPendientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoOperacion => $composableBuilder(
    column: $table.tipoOperacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entidadLocalId => $composableBuilder(
    column: $table.entidadLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intentos => $composableBuilder(
    column: $table.intentos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ultimoError => $composableBuilder(
    column: $table.ultimoError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OperacionesPendientesTableOrderingComposer
    extends Composer<_$AppDatabase, $OperacionesPendientesTable> {
  $$OperacionesPendientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoOperacion => $composableBuilder(
    column: $table.tipoOperacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entidadLocalId => $composableBuilder(
    column: $table.entidadLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intentos => $composableBuilder(
    column: $table.intentos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ultimoError => $composableBuilder(
    column: $table.ultimoError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OperacionesPendientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OperacionesPendientesTable> {
  $$OperacionesPendientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipoOperacion => $composableBuilder(
    column: $table.tipoOperacion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entidadLocalId => $composableBuilder(
    column: $table.entidadLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get ocurridaEn => $composableBuilder(
    column: $table.ocurridaEn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadaEn =>
      $composableBuilder(column: $table.creadaEn, builder: (column) => column);

  GeneratedColumn<int> get intentos =>
      $composableBuilder(column: $table.intentos, builder: (column) => column);

  GeneratedColumn<String> get ultimoError => $composableBuilder(
    column: $table.ultimoError,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$OperacionesPendientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OperacionesPendientesTable,
          OperacionesPendiente,
          $$OperacionesPendientesTableFilterComposer,
          $$OperacionesPendientesTableOrderingComposer,
          $$OperacionesPendientesTableAnnotationComposer,
          $$OperacionesPendientesTableCreateCompanionBuilder,
          $$OperacionesPendientesTableUpdateCompanionBuilder,
          (
            OperacionesPendiente,
            BaseReferences<
              _$AppDatabase,
              $OperacionesPendientesTable,
              OperacionesPendiente
            >,
          ),
          OperacionesPendiente,
          PrefetchHooks Function()
        > {
  $$OperacionesPendientesTableTableManager(
    _$AppDatabase db,
    $OperacionesPendientesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OperacionesPendientesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$OperacionesPendientesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$OperacionesPendientesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tipoOperacion = const Value.absent(),
                Value<String> entidadLocalId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> ocurridaEn = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
                Value<int> intentos = const Value.absent(),
                Value<String?> ultimoError = const Value.absent(),
                Value<String> estado = const Value.absent(),
              }) => OperacionesPendientesCompanion(
                id: id,
                tipoOperacion: tipoOperacion,
                entidadLocalId: entidadLocalId,
                payload: payload,
                ocurridaEn: ocurridaEn,
                creadaEn: creadaEn,
                intentos: intentos,
                ultimoError: ultimoError,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tipoOperacion,
                required String entidadLocalId,
                required String payload,
                required DateTime ocurridaEn,
                Value<DateTime> creadaEn = const Value.absent(),
                Value<int> intentos = const Value.absent(),
                Value<String?> ultimoError = const Value.absent(),
                Value<String> estado = const Value.absent(),
              }) => OperacionesPendientesCompanion.insert(
                id: id,
                tipoOperacion: tipoOperacion,
                entidadLocalId: entidadLocalId,
                payload: payload,
                ocurridaEn: ocurridaEn,
                creadaEn: creadaEn,
                intentos: intentos,
                ultimoError: ultimoError,
                estado: estado,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OperacionesPendientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OperacionesPendientesTable,
      OperacionesPendiente,
      $$OperacionesPendientesTableFilterComposer,
      $$OperacionesPendientesTableOrderingComposer,
      $$OperacionesPendientesTableAnnotationComposer,
      $$OperacionesPendientesTableCreateCompanionBuilder,
      $$OperacionesPendientesTableUpdateCompanionBuilder,
      (
        OperacionesPendiente,
        BaseReferences<
          _$AppDatabase,
          $OperacionesPendientesTable,
          OperacionesPendiente
        >,
      ),
      OperacionesPendiente,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder =
    SyncMetaCompanion Function({
      required String clave,
      required String valor,
      Value<int> rowid,
    });
typedef $$SyncMetaTableUpdateCompanionBuilder =
    SyncMetaCompanion Function({
      Value<String> clave,
      Value<String> valor,
      Value<int> rowid,
    });

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaData,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaData,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
          ),
          SyncMetaData,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clave = const Value.absent(),
                Value<String> valor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(clave: clave, valor: valor, rowid: rowid),
          createCompanionCallback:
              ({
                required String clave,
                required String valor,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaData,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (
        SyncMetaData,
        BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
      ),
      SyncMetaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalArticulosTableTableManager get localArticulos =>
      $$LocalArticulosTableTableManager(_db, _db.localArticulos);
  $$LocalClientesTableTableManager get localClientes =>
      $$LocalClientesTableTableManager(_db, _db.localClientes);
  $$LocalCajasTableTableManager get localCajas =>
      $$LocalCajasTableTableManager(_db, _db.localCajas);
  $$LocalCajaMovimientosTableTableManager get localCajaMovimientos =>
      $$LocalCajaMovimientosTableTableManager(_db, _db.localCajaMovimientos);
  $$LocalVentasTableTableManager get localVentas =>
      $$LocalVentasTableTableManager(_db, _db.localVentas);
  $$LocalVentaItemsTableTableManager get localVentaItems =>
      $$LocalVentaItemsTableTableManager(_db, _db.localVentaItems);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(_db, _db.syncQueueItems);
  $$OperacionesPendientesTableTableManager get operacionesPendientes =>
      $$OperacionesPendientesTableTableManager(_db, _db.operacionesPendientes);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
}
