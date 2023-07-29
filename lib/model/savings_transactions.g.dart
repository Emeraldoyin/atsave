// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_transactions.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavingsTransactionsCollection on Isar {
  IsarCollection<SavingsTransactions> get savingsTransactions =>
      this.collection();
}

const SavingsTransactionsSchema = CollectionSchema(
  name: r'SavingsTransactions',
  id: 8461615529432988598,
  properties: {
    r'amountExpended': PropertySchema(
      id: 0,
      name: r'amountExpended',
      type: IsarType.double,
    ),
    r'amountSaved': PropertySchema(
      id: 1,
      name: r'amountSaved',
      type: IsarType.double,
    ),
    r'savingsId': PropertySchema(
      id: 2,
      name: r'savingsId',
      type: IsarType.long,
    ),
    r'timeStamp': PropertySchema(
      id: 3,
      name: r'timeStamp',
      type: IsarType.dateTime,
    ),
    r'uid': PropertySchema(
      id: 4,
      name: r'uid',
      type: IsarType.string,
    )
  },
  estimateSize: _savingsTransactionsEstimateSize,
  serialize: _savingsTransactionsSerialize,
  deserialize: _savingsTransactionsDeserialize,
  deserializeProp: _savingsTransactionsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _savingsTransactionsGetId,
  getLinks: _savingsTransactionsGetLinks,
  attach: _savingsTransactionsAttach,
  version: '3.1.0+1',
);

int _savingsTransactionsEstimateSize(
  SavingsTransactions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _savingsTransactionsSerialize(
  SavingsTransactions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountExpended);
  writer.writeDouble(offsets[1], object.amountSaved);
  writer.writeLong(offsets[2], object.savingsId);
  writer.writeDateTime(offsets[3], object.timeStamp);
  writer.writeString(offsets[4], object.uid);
}

SavingsTransactions _savingsTransactionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavingsTransactions(
    amountExpended: reader.readDoubleOrNull(offsets[0]),
    amountSaved: reader.readDoubleOrNull(offsets[1]),
    id: id,
    savingsId: reader.readLongOrNull(offsets[2]),
    timeStamp: reader.readDateTime(offsets[3]),
    uid: reader.readString(offsets[4]),
  );
  return object;
}

P _savingsTransactionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savingsTransactionsGetId(SavingsTransactions object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _savingsTransactionsGetLinks(
    SavingsTransactions object) {
  return [];
}

void _savingsTransactionsAttach(
    IsarCollection<dynamic> col, Id id, SavingsTransactions object) {
  object.id = id;
}

extension SavingsTransactionsQueryWhereSort
    on QueryBuilder<SavingsTransactions, SavingsTransactions, QWhere> {
  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavingsTransactionsQueryWhere
    on QueryBuilder<SavingsTransactions, SavingsTransactions, QWhereClause> {
  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterWhereClause>
      idBetween(
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

extension SavingsTransactionsQueryFilter on QueryBuilder<SavingsTransactions,
    SavingsTransactions, QFilterCondition> {
  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountExpendedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountExpended',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountExpendedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountExpended',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountExpendedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountExpended',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountExpendedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountExpended',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountExpendedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountExpended',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountExpendedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountExpended',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountSavedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountSaved',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountSavedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountSaved',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountSavedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountSaved',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountSavedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountSaved',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountSavedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountSaved',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      amountSavedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountSaved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      savingsIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'savingsId',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      savingsIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'savingsId',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      savingsIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savingsId',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      savingsIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savingsId',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      savingsIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savingsId',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      savingsIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savingsId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      timeStampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      timeStampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      timeStampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      timeStampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeStamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidEqualTo(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidLessThan(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidBetween(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidStartsWith(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidEndsWith(
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

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }
}

extension SavingsTransactionsQueryObject on QueryBuilder<SavingsTransactions,
    SavingsTransactions, QFilterCondition> {}

extension SavingsTransactionsQueryLinks on QueryBuilder<SavingsTransactions,
    SavingsTransactions, QFilterCondition> {}

extension SavingsTransactionsQuerySortBy
    on QueryBuilder<SavingsTransactions, SavingsTransactions, QSortBy> {
  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByAmountExpended() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountExpended', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByAmountExpendedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountExpended', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByAmountSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountSaved', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByAmountSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountSaved', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortBySavingsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsId', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortBySavingsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsId', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByTimeStampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension SavingsTransactionsQuerySortThenBy
    on QueryBuilder<SavingsTransactions, SavingsTransactions, QSortThenBy> {
  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByAmountExpended() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountExpended', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByAmountExpendedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountExpended', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByAmountSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountSaved', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByAmountSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountSaved', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenBySavingsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsId', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenBySavingsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsId', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByTimeStampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.desc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QAfterSortBy>
      thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension SavingsTransactionsQueryWhereDistinct
    on QueryBuilder<SavingsTransactions, SavingsTransactions, QDistinct> {
  QueryBuilder<SavingsTransactions, SavingsTransactions, QDistinct>
      distinctByAmountExpended() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountExpended');
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QDistinct>
      distinctByAmountSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountSaved');
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QDistinct>
      distinctBySavingsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savingsId');
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QDistinct>
      distinctByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeStamp');
    });
  }

  QueryBuilder<SavingsTransactions, SavingsTransactions, QDistinct>
      distinctByUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension SavingsTransactionsQueryProperty
    on QueryBuilder<SavingsTransactions, SavingsTransactions, QQueryProperty> {
  QueryBuilder<SavingsTransactions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavingsTransactions, double?, QQueryOperations>
      amountExpendedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountExpended');
    });
  }

  QueryBuilder<SavingsTransactions, double?, QQueryOperations>
      amountSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountSaved');
    });
  }

  QueryBuilder<SavingsTransactions, int?, QQueryOperations>
      savingsIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savingsId');
    });
  }

  QueryBuilder<SavingsTransactions, DateTime, QQueryOperations>
      timeStampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeStamp');
    });
  }

  QueryBuilder<SavingsTransactions, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingsTransactions _$SavingsTransactionsFromJson(Map<Object?, Object?> json) =>
    SavingsTransactions(
      id: json['id'] as int?,
      savingsId: json['savingsId'] as int?,
      amountExpended: (json['amountExpended'] as num?)?.toDouble(),
      amountSaved: (json['amountSaved'] as num?)?.toDouble(),
      timeStamp: DateTime.parse(json['timeStamp'] as String),
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$SavingsTransactionsToJson(
        SavingsTransactions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'timeStamp': instance.timeStamp.toIso8601String(),
      'savingsId': instance.savingsId,
      'amountSaved': instance.amountSaved,
      'amountExpended': instance.amountExpended,
    };
