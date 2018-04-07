import com.leo.celox.tool {
    Visitor,
    Expr,
    Binary,
    Grouping,
    Literal,
    Unary
}

shared class AstPrinter() satisfies Visitor<String>{

    shared actual String visitBinaryExpr(Binary expr) =>
            parenthesize(expr.operator.lexeme, {expr.left,expr.right});

    shared actual String visitGroupingExpr(Grouping expr) => parenthesize("group", {expr.expression});

    shared actual String visitLiteralExpr(Literal expr) {
        if (exists it = expr.val) {
            return it.string;
        } else {
            return "nil";
        }
    }

    shared actual String visitUnaryExpr(Unary expr) => parenthesize(expr.operator.lexeme, {expr.right});

    shared String print(Expr expr) => expr.accept(this);

    String parenthesize(String name, {Expr+} exprs) {

        value stringBuilder = StringBuilder();
        stringBuilder.append("(``name``");

        for(expr in exprs) {
            stringBuilder.append(" ");
            stringBuilder.append(expr.accept(this));
        }
        stringBuilder.append(")");
        return stringBuilder.string;
    }
}
