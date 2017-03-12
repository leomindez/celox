import java.lang {
    System
}

shared class ErrorManager {

    shared static variable Boolean hadError = false;


    shared static void report(Integer line, String where, String message) {
        System.err.println("[line `line`] Error `where`: `message`");
        hadError = true;
    }

    shared static void error(Integer line, String message) {
        report(line, "", message);
    }

    shared new () {}

}