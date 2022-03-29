class ProductList {
  String? serialNumber;
  String? userId;
  String? productId;
  String? productName;
  String? productDescription;
  String? price;
  String? imageUrl;

  ProductList({
    this.serialNumber,
    this.userId,
    this.productId,
    this.productName,
    this.productDescription,
    this.price,
    this.imageUrl,
  });

  // receiving data from the server
  factory ProductList.fromMap(map) {
    return ProductList(
      serialNumber: map['serialNumber'],
      userId: map['userId'],
      productId: map['productId'],
      productName: map['productName'],
      productDescription: map['productDescription'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }

// sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'serialNumber': serialNumber,
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
