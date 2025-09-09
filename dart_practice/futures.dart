// import 'dart:async';

Future<void> main() async {
  print("print1");
  print("print2");
  await returnAfter2Sec().then((val) {
    print(val);
  });
  print("hello1");
  print("hello2");
}

Future<String> returnAfter2Sec() {
  return Future.delayed(Duration(seconds: 2), () {
    return "print this after 2 sec";
  });
}
