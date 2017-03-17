import java.nio.file {
    Files,
    Paths
}
import java.nio.charset {
    Charset
}
import java.io {
    InputStreamReader,
    BufferedReader
}
import java.lang {
    System {
        \iin
    }
}
import ceylon.buffer.charset {
    utf8
}

shared void run(){
  startCommands(*process.arguments);
}

shared void startCommands(String* arguments){
    value argSize = arguments.size;
    if(argSize > 1){
        print("Usage: celox [script]");
    } else if(argSize == 0){
        runFile(arguments.get(0));
    }else {
        runPrompt();
    }
}

void start(String source) {
        value scanner = Scanner(source);

}

void runFile(String? path) {
    value fileBytes = Files.readAllBytes(Paths.get(path)).byteArray;
    value fileString = utf8.decode(fileBytes);
    start(fileString);
    if(ErrorManager.hadError){
        System.exit(65);
    }

}

void runPrompt(){
    value inputStream = InputStreamReader(System.\iin);
    value reader = BufferedReader(inputStream);

    while (true){
        print("> ");
        start(reader.readLine());
        ErrorManager.hadError = false;
    }
}
