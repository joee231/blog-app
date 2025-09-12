import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';

abstract interface class UseCase<SuccessType , parametersType>
{
  Future<Either<Failure, SuccessType>> call( parametersType parameters);
}

class noParams{}