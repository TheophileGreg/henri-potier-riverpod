import 'package:dio/dio.dart';
import 'package:henri_potier_riverpod/features/cart/data/models/commercial_offer_response_model.dart';
import 'package:retrofit/retrofit.dart';

import 'package:henri_potier_riverpod/core/network.dart';

part 'commercial_offer_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CommercialOfferApi {
  factory CommercialOfferApi(Dio dio, {String baseUrl}) = _CommercialOfferApi;

  @GET('/books/{isbns}/commercialOffers')
  Future<CommercialOffersResponse> getCommercialOffers(
      @Path('isbns') String isbns);
}
