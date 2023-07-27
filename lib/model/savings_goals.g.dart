// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_goals.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavingsGoalsCollection on Isar {
  IsarCollection<SavingsGoals> get savingsGoals => this.collection();
}

const SavingsGoalsSchema = CollectionSchema(
  name: r'SavingsGoals',
  id: -333687450540975634,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'endDate': PropertySchema(
      id: 1,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'goalNotes': PropertySchema(
      id: 2,
      name: r'goalNotes',
      type: IsarType.string,
    ),
    r'progressPercentage': PropertySchema(
      id: 3,
      name: r'progressPercentage',
      type: IsarType.double,
    ),
    r'startAmount': PropertySchema(
      id: 4,
      name: r'startAmount',
      type: IsarType.double,
    ),
    r'targetAmount': PropertySchema(
      id: 5,
      name: r'targetAmount',
      type: IsarType.double,
    ),
    r'uid': PropertySchema(
      id: 6,
      name: r'uid',
      type: IsarType.string,
    )
  },
  estimateSize: _savingsGoalsEstimateSize,
  serialize: _savingsGoalsSerialize,
  deserialize: _savingsGoalsDeserialize,
  deserializeProp: _savingsGoalsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _savingsGoalsGetId,
  getLinks: _savingsGoalsGetLinks,
  attach: _savingsGoalsAttach,
  version: '3.1.0+1',
);

int _savingsGoalsEstimateSize(
  SavingsGoals object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.goalNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _savingsGoalsSerialize(
  SavingsGoals object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.categoryId);
  writer.writeDateTime(offsets[1], object.endDate);
  writer.writeString(offsets[2], object.goalNotes);
  writer.writeDouble(offsets[3], object.progressPercentage);
  writer.writeDouble(offsets[4], object.currentAmount);
  writer.writeDouble(offsets[5], object.targetAmount);
  writer.writeString(offsets[6], object.uid);
}

SavingsGoals _savingsGoalsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavingsGoals(
    categoryId: reader.readLong(offsets[0]),
    endDate: reader.readDateTime(offsets[1]),
    goalNotes: reader.readStringOrNull(offsets[2]),
    progressPercentage: reader.readDouble(offsets[3]),
    currentAmount: reader.readDouble(offsets[4]),
    targetAmount: reader.readDouble(offsets[5]),
    uid: reader.readString(offsets[6]),
  );
  object.id = id;
  return object;
}

P _savingsGoalsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savingsGoalsGetId(SavingsGoals object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _savingsGoalsGetLinks(SavingsGoals object) {
  return [];
}

void _savingsGoalsAttach(
    IsarCollection<dynamic> col, Id id, SavingsGoals object) {
  object.id = id;
}

extension SavingsGoalsQueryWhereSort
    on QueryBuilder<SavingsGoals, SavingsGoals, QWhere> {
  QueryBuilder<SavingsGoals, SavingsGoals, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavingsGoalsQueryWhere
    on QueryBuilder<SavingsGoals, SavingsGoals, QWhereClause> {
  QueryBuilder<SavingsGoals, SavingsGoals, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SavingsGoalsQueryFilter
    on QueryBuilder<SavingsGoals, SavingsGoals, QFilterCondition> {
  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      categoryIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      categoryIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      categoryIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      endDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      endDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      endDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      endDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'goalNotes',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'goalNotes',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goalNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goalNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goalNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goalNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      goalNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goalNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      progressPercentageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      progressPercentageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progressPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      progressPercentageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progressPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      progressPercentageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progressPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      startAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      startAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      startAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      startAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      targetAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      targetAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      targetAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      targetAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }
}

extension SavingsGoalsQueryObject
    on QueryBuilder<SavingsGoals, SavingsGoals, QFilterCondition> {}

extension SavingsGoalsQueryLinks
    on QueryBuilder<SavingsGoals, SavingsGoals, QFilterCondition> {}

extension SavingsGoalsQuerySortBy
    on QueryBuilder<SavingsGoals, SavingsGoals, QSortBy> {
  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByGoalNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalNotes', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByGoalNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalNotes', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      sortByProgressPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      sortByProgressPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByStartAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAmount', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      sortByStartAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAmount', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      sortByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension SavingsGoalsQuerySortThenBy
    on QueryBuilder<SavingsGoals, SavingsGoals, QSortThenBy> {
  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByGoalNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalNotes', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByGoalNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalNotes', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      thenByProgressPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      thenByProgressPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByStartAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAmount', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      thenByStartAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startAmount', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy>
      thenByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension SavingsGoalsQueryWhereDistinct
    on QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> {
  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> distinctByGoalNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct>
      distinctByProgressPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progressPercentage');
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> distinctByStartAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startAmount');
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> distinctByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetAmount');
    });
  }

  QueryBuilder<SavingsGoals, SavingsGoals, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension SavingsGoalsQueryProperty
    on QueryBuilder<SavingsGoals, SavingsGoals, QQueryProperty> {
  QueryBuilder<SavingsGoals, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavingsGoals, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<SavingsGoals, DateTime, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<SavingsGoals, String?, QQueryOperations> goalNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalNotes');
    });
  }

  QueryBuilder<SavingsGoals, double, QQueryOperations>
      progressPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progressPercentage');
    });
  }

  QueryBuilder<SavingsGoals, double, QQueryOperations> startAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startAmount');
    });
  }

  QueryBuilder<SavingsGoals, double, QQueryOperations> targetAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetAmount');
    });
  }

  QueryBuilder<SavingsGoals, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingsGoals _$SavingsGoalsFromJson(Map<Object?, Object?> json) => SavingsGoals(
      uid: json['uid'] as String,
      targetAmount: (json['targetAmount'] as num).toDouble(),
      goalNotes: json['goalNotes'] as String?,
      categoryId: json['categoryId'] as int,
      currentAmount: (json['startAmount'] as num).toDouble(),
      endDate: DateTime.parse(json['endDate'] as String),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
    )..id = json['id'] as int?;

Map<String, dynamic> _$SavingsGoalsToJson(SavingsGoals instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'targetAmount': instance.targetAmount,
      'goalNotes': instance.goalNotes,
      'categoryId': instance.categoryId,
      'startAmount': instance.currentAmount,
      'endDate': instance.endDate.toIso8601String(),
      'progressPercentage': instance.progressPercentage,
    };
