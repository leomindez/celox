 import com.leo.celox {Token}
 import com.leo.celox.tool { Visitor }


 shared abstract class Expr() { 
 shared formal Type accept<out Type>(Visitor<Type> visitor);
 }

 shared class Binary(shared Expr left, shared Token operator, shared Expr right) extends Expr() {
  shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitBinaryExpr (this);}
 }

 shared class Grouping(shared Expr expression) extends Expr() {
  shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitGroupingExpr (this);}
 }


 shared class Unary(shared Token operator, shared Expr right) extends Expr() {
  shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitUnaryExpr (this);}
 }

 shared class Literal(shared Object?|Integer val) extends Expr() {
  shared actual Type accept<Type>(Visitor<Type> visitor)  { return visitor.visitLiteralExpr (this);}
 }
