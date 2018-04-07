 import com.leo.celox.tool { Expr }

 shared interface Visitor<out R> {

 shared formal R visitBinaryExpr( Binary visitor);

 shared formal R visitGroupingExpr( Grouping visitor);

 shared formal R visitLiteralExpr( Literal visitor);

 shared formal R visitUnaryExpr( Unary visitor);
 }

