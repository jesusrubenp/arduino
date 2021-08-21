import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_esp/widgets/background.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

//     class Screen extends StatelessWidget {
//     
//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           body: Stack(
//             children: [ 
//               Background()
//     
//           ],),
//         );
//       }
//     }

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: WebSocketLed(),
    
    
    );
  }
}


//    class Screen extends StatelessWidget {
//  
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        body: Stack(
//          children: [ 
//            Background()
//  
//        ],),
//      );
//    }
//  }
//

//apply this class on home: attribute at MaterialApp()
class WebSocketLed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebSocketLed();
  }
}

class _WebSocketLed extends State<WebSocketLed> {
  bool servo; 
  IOWebSocketChannel channel;
  bool connected; 

  @override
  void initState() {
    servo = false; 
    connected = false; 

    Future.delayed(Duration.zero, () async {
      channelconnect(); 
    });

    super.initState();
  }

  channelconnect() {
  
    try {
      channel =
          IOWebSocketChannel.connect("ws://192.168.0.1:81"); 
      channel.stream.listen(
        (message) {
          print(message);
          setState(() {
            if (message == "conectado") {
              connected = true; 
            } else if (message == "poweron:success") {
              servo = true;
            } else if (message == "poweroff:success") {
              servo = false;
            }
          });
        },
        onDone: () {
          
          print("Web socket desconectado");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error al concetar a websocket.");
    }
  }

  Future<void> sendcmd(String cmd) async {
    if (connected == true) {
      if (servo == false && cmd != "cerrado" && cmd != "abierto") {
        print("envia comando valido");
      } else {
        channel.sink.add(cmd); 
      }
    } else {
      channelconnect();
      print("Websocket no conectado.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Mano Arduino"),
          backgroundColor: Colors.blueAccent),



      body: Container(
              
          alignment: Alignment.topCenter, 
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Background(),
              Container(
                  child: connected  
                      ? Text("WEBSOCKET: Conectado")
                      : Text("Desconectado")),
              Container(
                  child: servo ? Text("cerrado") : Text("Abierto")),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      
                      color: Colors.redAccent,
                      colorBrightness: Brightness.dark,
                      onPressed: () {
                        
                        if (servo) {
                          


                          sendcmd("Abierto");
                          servo = false;
                        } else {
                    
                  
                          sendcmd("cerrado");
                          servo = true;
                        }
                        setState(() {});
                      },
                      child: servo
                          ? Text("Cerrado")
                          : Text("Abierto")))
            ],
          )),
    )
    ;
  }





}
