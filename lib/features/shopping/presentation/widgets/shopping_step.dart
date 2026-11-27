import 'package:mijoo/features/fridge/domain/rules/fridge_quantity_step.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_packs.dart';

double shoppingStep(ShoppingLine line) =>
    line.pack.match(() => fridgeQuantityStep(line.unit), (ShoppingPack pack) => packSize(pack).size);
