import com.leo.celox.tool {
    Visitor,
    Expr
}

shared class AstPrinter() satisfies Visitor<String>{

    shared actual String visitBinaryExpr(Expr.Binary expr) => nothing;

    shared actual String visitGroupingExpr(Expr.Grouping expr) => nothing;

    shared actual String visitLiteralExpr(Expr.Literal expr) => nothing;

    shared actual String visitUnaryExpr(Expr.Unary expr) => nothing;

}