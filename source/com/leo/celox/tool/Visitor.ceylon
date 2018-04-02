 import com.leo.celox.tool { Expr }

 shared interface Visitor<out R> {

 shared formal R visitBinaryExpr( Expr.Binary visitor);

 shared formal R visitGroupingExpr( Expr.Grouping visitor);

 shared formal R visitLiteralExpr( Expr.Literal visitor);

 shared formal R visitUnaryExpr( Expr.Unary visitor);
 }

