import java.lang {
    System
}
import java.io {
    PrintWriter
}
import ceylon.collection {
    LinkedList
}


shared void run() {


    value outputDir = process.arguments[0];

    value types = LinkedList<String>({
        "Binary:Expr left, Token operator, Expr right",
        "Grouping:Expr expression",
        "Literal:Object val",
        "Unary:Token operator, Expr right"
    });
    defineAst(outputDir, "Expr", types);
}


void defineAst(String? output, String baseName, LinkedList<String> types) {

    value path = "``if (exists output) then output else ""``/``baseName``.ceylon";
    value printWritter = PrintWriter(path, "UTF-8");
    printWritter.println("import com.leo.celox {Token}");
    printWritter.println();
    printWritter.println("shared abstract class ``baseName``() { ");

    for (value type in types) {
        value splitted = type.split((Character ch) => ch.equals(':'));
        value className = splitted.first;
        value fields = splitted.getFromFirst(1) else " ";
        defineType(printWritter, baseName, className, fields);
    }

    printWritter.println("}");
    printWritter.close();
}

void defineType(PrintWriter printWritter, String baseName, String? className, String? fields) {
    printWritter.println(" shared class ``if (exists className) then className else " "
    ``(``if (exists fields) then fields else " "``) extends ``baseName``() { }");
    printWritter.println();
}
