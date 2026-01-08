class ChefListDataModel {
  final Data? data;
  final String? message;
  final int? responseCode;
  final String? status;

  ChefListDataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory ChefListDataModel.fromJson(Map<String, dynamic> json) {
    return ChefListDataModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      responseCode: json['responseCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'responseCode': responseCode,
      'status': status,
    };
  }
}

class Data {
  final bool? last;
  final int? pageNo;
  final int? pageSize;
  final List<Result>? results;
  final int? totalElement;
  final int? totalPage;

  Data({
    this.last,
    this.pageNo,
    this.pageSize,
    this.results,
    this.totalElement,
    this.totalPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      last: json['last'],
      pageNo: json['pageNo'],
      pageSize: json['pageSize'],
      results: json['results'] != null ? List<Result>.from(json['results'].map((x) => Result.fromJson(x))) : null,
      totalElement: json['totalElement'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'results': results?.map((x) => x.toJson()).toList(),
      'totalElement': totalElement,
      'totalPage': totalPage,
    };
  }
}

class Result {
  final String? address;
  final String? email;
  final int? id;
  final dynamic? imageId;
  final List<dynamic>? imageResponse;
  final String? name;
  final String? phoneNumber;
  final dynamic? rating;
  final int? recipeCount;
  final dynamic? thumbnailImageId;
  final String? uuid;

  Result({
    this.address,
    this.email,
    this.id,
    this.imageId,
    this.imageResponse,
    this.name,
    this.phoneNumber,
    this.rating,
    this.recipeCount,
    this.thumbnailImageId,
    this.uuid,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      address: json['address'],
      email: json['email'],
      id: json['id'],
      imageId: json['imageId'],
      imageResponse: json['imageResponse'] != null ? List<dynamic>.from(json['imageResponse']) : null,
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      rating: json['rating'],
      recipeCount: json['recipeCount'],
      thumbnailImageId: json['thumbnailImageId'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'email': email,
      'id': id,
      'imageId': imageId,
      'imageResponse': imageResponse,
      'name': name,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'recipeCount': recipeCount,
      'thumbnailImageId': thumbnailImageId,
      'uuid': uuid,
    };
  }
}
