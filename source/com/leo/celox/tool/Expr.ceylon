import com.leo.celox {
    Token
}

shared abstract class Expr() {
    shared class Binary(Expr left, Token operator, Expr right) extends Expr() {}

    shared class Grouping(Expr expression) extends Expr() {}

    shared class Literal(Object val) extends Expr() {}

    shared class Unary(Token operator, Expr right) extends Expr() {}

}
