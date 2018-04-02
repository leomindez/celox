 import com.leo.celox {Token}
 import com.leo.celox.tool { Visitor }

 shared abstract class Expr() { 
 shared formal Type accept<out Type>(Visitor<Type> visitor);

 shared class Binary(Expr left, Token operator, Expr right) extends Expr() {

 shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitBinaryExpr (this);}
 }

 shared class Grouping(Expr expression) extends Expr() {

 shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitGroupingExpr (this);}
 }

 shared class Literal(Object val) extends Expr() {

 shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitLiteralExpr (this);}
 }

 shared class Unary(Token operator, Expr right) extends Expr() {

 shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitUnaryExpr (this);}
 }


 }

