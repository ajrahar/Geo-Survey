// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  const Project({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Project copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => Project(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SurveysTable extends Surveys with TableInfo<$SurveysTable, Survey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _geometryMeta = const VerificationMeta(
    'geometry',
  );
  @override
  late final GeneratedColumn<String> geometry = GeneratedColumn<String>(
    'geometry',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaSizeMeta = const VerificationMeta(
    'areaSize',
  );
  @override
  late final GeneratedColumn<double> areaSize = GeneratedColumn<double>(
    'area_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _perimeterMeta = const VerificationMeta(
    'perimeter',
  );
  @override
  late final GeneratedColumn<double> perimeter = GeneratedColumn<double>(
    'perimeter',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    geometry,
    areaSize,
    perimeter,
    createdAt,
    projectId,
    address,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surveys';
  @override
  VerificationContext validateIntegrity(
    Insertable<Survey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('geometry')) {
      context.handle(
        _geometryMeta,
        geometry.isAcceptableOrUnknown(data['geometry']!, _geometryMeta),
      );
    } else if (isInserting) {
      context.missing(_geometryMeta);
    }
    if (data.containsKey('area_size')) {
      context.handle(
        _areaSizeMeta,
        areaSize.isAcceptableOrUnknown(data['area_size']!, _areaSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_areaSizeMeta);
    }
    if (data.containsKey('perimeter')) {
      context.handle(
        _perimeterMeta,
        perimeter.isAcceptableOrUnknown(data['perimeter']!, _perimeterMeta),
      );
    } else if (isInserting) {
      context.missing(_perimeterMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Survey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Survey(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      geometry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}geometry'],
      )!,
      areaSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}area_size'],
      )!,
      perimeter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}perimeter'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
    );
  }

  @override
  $SurveysTable createAlias(String alias) {
    return $SurveysTable(attachedDatabase, alias);
  }
}

class Survey extends DataClass implements Insertable<Survey> {
  final String id;
  final String name;

  /// JSON string of List&lt;LatLng&gt; coordinates
  /// Format: [{"lat": -6.xxx, "lng": 106.xxx}, ...]
  final String geometry;

  /// Calculated area in square meters
  final double areaSize;

  /// Calculated perimeter in meters
  final double perimeter;
  final DateTime createdAt;

  /// Foreign key to Projects table (nullable for surveys without project)
  final String? projectId;

  /// Address/location name (reverse geocoded or manual)
  final String address;
  const Survey({
    required this.id,
    required this.name,
    required this.geometry,
    required this.areaSize,
    required this.perimeter,
    required this.createdAt,
    this.projectId,
    required this.address,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['geometry'] = Variable<String>(geometry);
    map['area_size'] = Variable<double>(areaSize);
    map['perimeter'] = Variable<double>(perimeter);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    map['address'] = Variable<String>(address);
    return map;
  }

  SurveysCompanion toCompanion(bool nullToAbsent) {
    return SurveysCompanion(
      id: Value(id),
      name: Value(name),
      geometry: Value(geometry),
      areaSize: Value(areaSize),
      perimeter: Value(perimeter),
      createdAt: Value(createdAt),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      address: Value(address),
    );
  }

  factory Survey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Survey(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      geometry: serializer.fromJson<String>(json['geometry']),
      areaSize: serializer.fromJson<double>(json['areaSize']),
      perimeter: serializer.fromJson<double>(json['perimeter']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'geometry': serializer.toJson<String>(geometry),
      'areaSize': serializer.toJson<double>(areaSize),
      'perimeter': serializer.toJson<double>(perimeter),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'projectId': serializer.toJson<String?>(projectId),
      'address': serializer.toJson<String>(address),
    };
  }

  Survey copyWith({
    String? id,
    String? name,
    String? geometry,
    double? areaSize,
    double? perimeter,
    DateTime? createdAt,
    Value<String?> projectId = const Value.absent(),
    String? address,
  }) => Survey(
    id: id ?? this.id,
    name: name ?? this.name,
    geometry: geometry ?? this.geometry,
    areaSize: areaSize ?? this.areaSize,
    perimeter: perimeter ?? this.perimeter,
    createdAt: createdAt ?? this.createdAt,
    projectId: projectId.present ? projectId.value : this.projectId,
    address: address ?? this.address,
  );
  Survey copyWithCompanion(SurveysCompanion data) {
    return Survey(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      geometry: data.geometry.present ? data.geometry.value : this.geometry,
      areaSize: data.areaSize.present ? data.areaSize.value : this.areaSize,
      perimeter: data.perimeter.present ? data.perimeter.value : this.perimeter,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Survey(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('geometry: $geometry, ')
          ..write('areaSize: $areaSize, ')
          ..write('perimeter: $perimeter, ')
          ..write('createdAt: $createdAt, ')
          ..write('projectId: $projectId, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    geometry,
    areaSize,
    perimeter,
    createdAt,
    projectId,
    address,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Survey &&
          other.id == this.id &&
          other.name == this.name &&
          other.geometry == this.geometry &&
          other.areaSize == this.areaSize &&
          other.perimeter == this.perimeter &&
          other.createdAt == this.createdAt &&
          other.projectId == this.projectId &&
          other.address == this.address);
}

class SurveysCompanion extends UpdateCompanion<Survey> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> geometry;
  final Value<double> areaSize;
  final Value<double> perimeter;
  final Value<DateTime> createdAt;
  final Value<String?> projectId;
  final Value<String> address;
  final Value<int> rowid;
  const SurveysCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.geometry = const Value.absent(),
    this.areaSize = const Value.absent(),
    this.perimeter = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.address = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SurveysCompanion.insert({
    required String id,
    required String name,
    required String geometry,
    required double areaSize,
    required double perimeter,
    required DateTime createdAt,
    this.projectId = const Value.absent(),
    this.address = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       geometry = Value(geometry),
       areaSize = Value(areaSize),
       perimeter = Value(perimeter),
       createdAt = Value(createdAt);
  static Insertable<Survey> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? geometry,
    Expression<double>? areaSize,
    Expression<double>? perimeter,
    Expression<DateTime>? createdAt,
    Expression<String>? projectId,
    Expression<String>? address,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (geometry != null) 'geometry': geometry,
      if (areaSize != null) 'area_size': areaSize,
      if (perimeter != null) 'perimeter': perimeter,
      if (createdAt != null) 'created_at': createdAt,
      if (projectId != null) 'project_id': projectId,
      if (address != null) 'address': address,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SurveysCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? geometry,
    Value<double>? areaSize,
    Value<double>? perimeter,
    Value<DateTime>? createdAt,
    Value<String?>? projectId,
    Value<String>? address,
    Value<int>? rowid,
  }) {
    return SurveysCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      geometry: geometry ?? this.geometry,
      areaSize: areaSize ?? this.areaSize,
      perimeter: perimeter ?? this.perimeter,
      createdAt: createdAt ?? this.createdAt,
      projectId: projectId ?? this.projectId,
      address: address ?? this.address,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (geometry.present) {
      map['geometry'] = Variable<String>(geometry.value);
    }
    if (areaSize.present) {
      map['area_size'] = Variable<double>(areaSize.value);
    }
    if (perimeter.present) {
      map['perimeter'] = Variable<double>(perimeter.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveysCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('geometry: $geometry, ')
          ..write('areaSize: $areaSize, ')
          ..write('perimeter: $perimeter, ')
          ..write('createdAt: $createdAt, ')
          ..write('projectId: $projectId, ')
          ..write('address: $address, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SurveyPhotosTable extends SurveyPhotos
    with TableInfo<$SurveyPhotosTable, SurveyPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyPhotosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surveyIdMeta = const VerificationMeta(
    'surveyId',
  );
  @override
  late final GeneratedColumn<String> surveyId = GeneratedColumn<String>(
    'survey_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surveys (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, surveyId, path, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<SurveyPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(
        _surveyIdMeta,
        surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surveyIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surveyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}survey_id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SurveyPhotosTable createAlias(String alias) {
    return $SurveyPhotosTable(attachedDatabase, alias);
  }
}

class SurveyPhoto extends DataClass implements Insertable<SurveyPhoto> {
  final int id;
  final String surveyId;
  final String path;
  final DateTime createdAt;
  const SurveyPhoto({
    required this.id,
    required this.surveyId,
    required this.path,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<String>(surveyId);
    map['path'] = Variable<String>(path);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SurveyPhotosCompanion toCompanion(bool nullToAbsent) {
    return SurveyPhotosCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      path: Value(path),
      createdAt: Value(createdAt),
    );
  }

  factory SurveyPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyPhoto(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<String>(json['surveyId']),
      path: serializer.fromJson<String>(json['path']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<String>(surveyId),
      'path': serializer.toJson<String>(path),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SurveyPhoto copyWith({
    int? id,
    String? surveyId,
    String? path,
    DateTime? createdAt,
  }) => SurveyPhoto(
    id: id ?? this.id,
    surveyId: surveyId ?? this.surveyId,
    path: path ?? this.path,
    createdAt: createdAt ?? this.createdAt,
  );
  SurveyPhoto copyWithCompanion(SurveyPhotosCompanion data) {
    return SurveyPhoto(
      id: data.id.present ? data.id.value : this.id,
      surveyId: data.surveyId.present ? data.surveyId.value : this.surveyId,
      path: data.path.present ? data.path.value : this.path,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurveyPhoto(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('path: $path, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, path, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyPhoto &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.path == this.path &&
          other.createdAt == this.createdAt);
}

class SurveyPhotosCompanion extends UpdateCompanion<SurveyPhoto> {
  final Value<int> id;
  final Value<String> surveyId;
  final Value<String> path;
  final Value<DateTime> createdAt;
  const SurveyPhotosCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.path = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SurveyPhotosCompanion.insert({
    this.id = const Value.absent(),
    required String surveyId,
    required String path,
    required DateTime createdAt,
  }) : surveyId = Value(surveyId),
       path = Value(path),
       createdAt = Value(createdAt);
  static Insertable<SurveyPhoto> custom({
    Expression<int>? id,
    Expression<String>? surveyId,
    Expression<String>? path,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (path != null) 'path': path,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SurveyPhotosCompanion copyWith({
    Value<int>? id,
    Value<String>? surveyId,
    Value<String>? path,
    Value<DateTime>? createdAt,
  }) {
    return SurveyPhotosCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      path: path ?? this.path,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<String>(surveyId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyPhotosCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('path: $path, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $SurveysTable surveys = $SurveysTable(this);
  late final $SurveyPhotosTable surveyPhotos = $SurveyPhotosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    surveys,
    surveyPhotos,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'surveys',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('survey_photos', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
          Project,
          PrefetchHooks Function()
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
      Project,
      PrefetchHooks Function()
    >;
typedef $$SurveysTableCreateCompanionBuilder =
    SurveysCompanion Function({
      required String id,
      required String name,
      required String geometry,
      required double areaSize,
      required double perimeter,
      required DateTime createdAt,
      Value<String?> projectId,
      Value<String> address,
      Value<int> rowid,
    });
typedef $$SurveysTableUpdateCompanionBuilder =
    SurveysCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> geometry,
      Value<double> areaSize,
      Value<double> perimeter,
      Value<DateTime> createdAt,
      Value<String?> projectId,
      Value<String> address,
      Value<int> rowid,
    });

final class $$SurveysTableReferences
    extends BaseReferences<_$AppDatabase, $SurveysTable, Survey> {
  $$SurveysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SurveyPhotosTable, List<SurveyPhoto>>
  _surveyPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.surveyPhotos,
    aliasName: $_aliasNameGenerator(db.surveys.id, db.surveyPhotos.surveyId),
  );

  $$SurveyPhotosTableProcessedTableManager get surveyPhotosRefs {
    final manager = $$SurveyPhotosTableTableManager(
      $_db,
      $_db.surveyPhotos,
    ).filter((f) => f.surveyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_surveyPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SurveysTableFilterComposer
    extends Composer<_$AppDatabase, $SurveysTable> {
  $$SurveysTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get geometry => $composableBuilder(
    column: $table.geometry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get areaSize => $composableBuilder(
    column: $table.areaSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get perimeter => $composableBuilder(
    column: $table.perimeter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> surveyPhotosRefs(
    Expression<bool> Function($$SurveyPhotosTableFilterComposer f) f,
  ) {
    final $$SurveyPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.surveyPhotos,
      getReferencedColumn: (t) => t.surveyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurveyPhotosTableFilterComposer(
            $db: $db,
            $table: $db.surveyPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurveysTableOrderingComposer
    extends Composer<_$AppDatabase, $SurveysTable> {
  $$SurveysTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get geometry => $composableBuilder(
    column: $table.geometry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get areaSize => $composableBuilder(
    column: $table.areaSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get perimeter => $composableBuilder(
    column: $table.perimeter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurveysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurveysTable> {
  $$SurveysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get geometry =>
      $composableBuilder(column: $table.geometry, builder: (column) => column);

  GeneratedColumn<double> get areaSize =>
      $composableBuilder(column: $table.areaSize, builder: (column) => column);

  GeneratedColumn<double> get perimeter =>
      $composableBuilder(column: $table.perimeter, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  Expression<T> surveyPhotosRefs<T extends Object>(
    Expression<T> Function($$SurveyPhotosTableAnnotationComposer a) f,
  ) {
    final $$SurveyPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.surveyPhotos,
      getReferencedColumn: (t) => t.surveyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurveyPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.surveyPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurveysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurveysTable,
          Survey,
          $$SurveysTableFilterComposer,
          $$SurveysTableOrderingComposer,
          $$SurveysTableAnnotationComposer,
          $$SurveysTableCreateCompanionBuilder,
          $$SurveysTableUpdateCompanionBuilder,
          (Survey, $$SurveysTableReferences),
          Survey,
          PrefetchHooks Function({bool surveyPhotosRefs})
        > {
  $$SurveysTableTableManager(_$AppDatabase db, $SurveysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurveysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurveysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurveysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> geometry = const Value.absent(),
                Value<double> areaSize = const Value.absent(),
                Value<double> perimeter = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SurveysCompanion(
                id: id,
                name: name,
                geometry: geometry,
                areaSize: areaSize,
                perimeter: perimeter,
                createdAt: createdAt,
                projectId: projectId,
                address: address,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String geometry,
                required double areaSize,
                required double perimeter,
                required DateTime createdAt,
                Value<String?> projectId = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SurveysCompanion.insert(
                id: id,
                name: name,
                geometry: geometry,
                areaSize: areaSize,
                perimeter: perimeter,
                createdAt: createdAt,
                projectId: projectId,
                address: address,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SurveysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({surveyPhotosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (surveyPhotosRefs) db.surveyPhotos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (surveyPhotosRefs)
                    await $_getPrefetchedData<
                      Survey,
                      $SurveysTable,
                      SurveyPhoto
                    >(
                      currentTable: table,
                      referencedTable: $$SurveysTableReferences
                          ._surveyPhotosRefsTable(db),
                      managerFromTypedResult: (p0) => $$SurveysTableReferences(
                        db,
                        table,
                        p0,
                      ).surveyPhotosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.surveyId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SurveysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurveysTable,
      Survey,
      $$SurveysTableFilterComposer,
      $$SurveysTableOrderingComposer,
      $$SurveysTableAnnotationComposer,
      $$SurveysTableCreateCompanionBuilder,
      $$SurveysTableUpdateCompanionBuilder,
      (Survey, $$SurveysTableReferences),
      Survey,
      PrefetchHooks Function({bool surveyPhotosRefs})
    >;
typedef $$SurveyPhotosTableCreateCompanionBuilder =
    SurveyPhotosCompanion Function({
      Value<int> id,
      required String surveyId,
      required String path,
      required DateTime createdAt,
    });
typedef $$SurveyPhotosTableUpdateCompanionBuilder =
    SurveyPhotosCompanion Function({
      Value<int> id,
      Value<String> surveyId,
      Value<String> path,
      Value<DateTime> createdAt,
    });

final class $$SurveyPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $SurveyPhotosTable, SurveyPhoto> {
  $$SurveyPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SurveysTable _surveyIdTable(_$AppDatabase db) =>
      db.surveys.createAlias(
        $_aliasNameGenerator(db.surveyPhotos.surveyId, db.surveys.id),
      );

  $$SurveysTableProcessedTableManager get surveyId {
    final $_column = $_itemColumn<String>('survey_id')!;

    final manager = $$SurveysTableTableManager(
      $_db,
      $_db.surveys,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surveyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SurveyPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $SurveyPhotosTable> {
  $$SurveyPhotosTableFilterComposer({
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

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SurveysTableFilterComposer get surveyId {
    final $$SurveysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surveyId,
      referencedTable: $db.surveys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurveysTableFilterComposer(
            $db: $db,
            $table: $db.surveys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SurveyPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $SurveyPhotosTable> {
  $$SurveyPhotosTableOrderingComposer({
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

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurveysTableOrderingComposer get surveyId {
    final $$SurveysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surveyId,
      referencedTable: $db.surveys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurveysTableOrderingComposer(
            $db: $db,
            $table: $db.surveys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SurveyPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurveyPhotosTable> {
  $$SurveyPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SurveysTableAnnotationComposer get surveyId {
    final $$SurveysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surveyId,
      referencedTable: $db.surveys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurveysTableAnnotationComposer(
            $db: $db,
            $table: $db.surveys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SurveyPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurveyPhotosTable,
          SurveyPhoto,
          $$SurveyPhotosTableFilterComposer,
          $$SurveyPhotosTableOrderingComposer,
          $$SurveyPhotosTableAnnotationComposer,
          $$SurveyPhotosTableCreateCompanionBuilder,
          $$SurveyPhotosTableUpdateCompanionBuilder,
          (SurveyPhoto, $$SurveyPhotosTableReferences),
          SurveyPhoto,
          PrefetchHooks Function({bool surveyId})
        > {
  $$SurveyPhotosTableTableManager(_$AppDatabase db, $SurveyPhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurveyPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurveyPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurveyPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> surveyId = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SurveyPhotosCompanion(
                id: id,
                surveyId: surveyId,
                path: path,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String surveyId,
                required String path,
                required DateTime createdAt,
              }) => SurveyPhotosCompanion.insert(
                id: id,
                surveyId: surveyId,
                path: path,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SurveyPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({surveyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (surveyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.surveyId,
                                referencedTable: $$SurveyPhotosTableReferences
                                    ._surveyIdTable(db),
                                referencedColumn: $$SurveyPhotosTableReferences
                                    ._surveyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SurveyPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurveyPhotosTable,
      SurveyPhoto,
      $$SurveyPhotosTableFilterComposer,
      $$SurveyPhotosTableOrderingComposer,
      $$SurveyPhotosTableAnnotationComposer,
      $$SurveyPhotosTableCreateCompanionBuilder,
      $$SurveyPhotosTableUpdateCompanionBuilder,
      (SurveyPhoto, $$SurveyPhotosTableReferences),
      SurveyPhoto,
      PrefetchHooks Function({bool surveyId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$SurveysTableTableManager get surveys =>
      $$SurveysTableTableManager(_db, _db.surveys);
  $$SurveyPhotosTableTableManager get surveyPhotos =>
      $$SurveyPhotosTableTableManager(_db, _db.surveyPhotos);
}
