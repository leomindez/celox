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
        "Literal:Object? val",
        "Unary:Token operator, Expr right"
    });
    defineAst(outputDir, "Expr", types);
    defineVisitor(outputDir, "Visitor", types);

}


void defineAst(String? output, String baseName, LinkedList<String> types) {

    value path = "``if (exists output) then output else ""``/``baseName``.ceylon";
    value printWritter = PrintWriter(path, "UTF-8");

    printWritter.println(" import com.leo.celox {Token}");
    printWritter.println(" import com.leo.celox.tool { Visitor }");
    printWritter.println();
    printWritter.println(" shared abstract class ``baseName``() { ");
    printWritter.println(" shared formal Type accept<out Type>(Visitor<Type> visitor);");
    printWritter.println(" }");

    for (value type in types) {
        value splitted = type.split((Character ch) => ch.equals(':'));
        value className = splitted.first;
        value fields = splitted.getFromFirst(1) else " ";
        defineType(printWritter, baseName, className, fields);
    }

    printWritter.println();

    printWritter.println();
    printWritter.close();
}

void defineVisitor(String? output, String baseName, LinkedList<String> types) {
    value path = "``if (exists output) then output else ""``/``baseName``.ceylon";
    value printWritter = PrintWriter(path, "UTF-8");
    printWritter.println(" import com.leo.celox.tool { Expr }");
    printWritter.println();
    printWritter.println(" shared interface Visitor<out R> {");

    for (value type in types) {
        value splitted = type.split((Character ch) => ch.equals(':'));
        value className = splitted.first;
        printWritter.println();
        printWritter.println(" shared formal R visit``className``Expr( Expr.``className`` ``baseName.lowercased``);");
    }
    printWritter.println(" }");
    printWritter.println();
    printWritter.close();
}

void defineType(PrintWriter printWritter, String baseName, String? className, String? fields) {
    printWritter.println();
    printWritter.println(" shared class ``if (exists className) then className else " "
    ``(shared ``if (exists fields) then fields else " "``) extends ``baseName``() {");
    printWritter.println();
    printWritter.println(" shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visit``if (exists className) then className else " "````baseName`` (this);}");
    printWritter.println(" }");
    printWritter.println();
}
