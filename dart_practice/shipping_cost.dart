import 'dart:io';

void main() {
  //input both weightInKg and destinationZone
  print('enter the weightInKg: ');
  double? weightInKg = double.parse(stdin.readLineSync()!);
  print('enter the destinationZone: ');
  String? destinationZone = stdin.readLineSync();
  double shippingCost = 0;
  if (destinationZone == 'XYZ' || destinationZone == 'xyz') {
    shippingCost = weightInKg * 5;
  } else if (destinationZone == 'ABC' || destinationZone == 'abc') {
    shippingCost = weightInKg * 7;
  } else if (destinationZone == 'PQR' || destinationZone == 'pqr') {
    shippingCost = weightInKg * 10;
  } else {
    print(
      'null/unknown destinationZone entered! enter the valid destinationZone....',
    );
    return;
  }
  print("the shipping cost : \$${shippingCost}");
}
