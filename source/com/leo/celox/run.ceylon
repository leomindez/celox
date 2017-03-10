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
    },
    JString = String
}

import ceylon.language { String }

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

void start(String|JString string) {

}

void runFile(String? path) {
    value fileBytes = Files.readAllBytes(Paths.get(path));
    value fileString = JString(fileBytes, Charset.defaultCharset());
    start(fileString);
}

void runPrompt(){
    value inputStream = InputStreamReader(System.\iin);
    value reader = BufferedReader(inputStream);

    while (true){
        print("> ");
        start(reader.readLine());
    }
}
