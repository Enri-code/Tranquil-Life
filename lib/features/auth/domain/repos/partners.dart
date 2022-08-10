import 'package:tranquil_life/app/domain/repos/items_repo.dart';
import 'package:tranquil_life/features/auth/domain/entities/partner.dart';

abstract class PartnersRepo extends ItemsRepo<Partner> {
  const PartnersRepo();
}
