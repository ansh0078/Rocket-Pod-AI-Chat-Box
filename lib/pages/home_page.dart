import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pod/bloc/chat_bloc.dart';
import 'package:space_pod/models/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> message = (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(image: DecorationImage(opacity: 0.5, image: AssetImage("assets/image/rocket_background.jpg"), fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 25,
                      margin: const EdgeInsets.only(top: 40),
                      child: const Row(
                        children: [
                          Text(
                            'Rocket Pod',
                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Sixtyfour', fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: message.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.amber.withOpacity(0.1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message[index].role == "user" ? "User" : "Rocket Pod",
                                        style: TextStyle(color: message[index].role == "user" ? Colors.amber : Colors.purple.shade200, fontSize: 25),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        message[index].parts.first.text,
                                        style: const TextStyle(height: 1.2, fontSize: 25),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          SizedBox(height: 100, width: 100, child: Lottie.asset('assets/animination/Loading_animation.json')),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('Loading...')
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                  controller: textEditingController,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      fillColor: Colors.transparent,
                                      hintText: "Ask something from AI",
                                      hintStyle: TextStyle(color: Colors.grey.shade300),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Colors.white))))),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 31,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Center(
                                  child: Icon(Icons.send, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
