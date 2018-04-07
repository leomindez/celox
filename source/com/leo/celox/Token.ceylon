shared class Token(shared String type, shared String lexeme, shared Integer line, shared Object? literal = null) {
    shared actual String string => "Type ``type``  ``lexeme``  ``literal?.string else ""``";
}

shared object tokenType {
    // Single Character Token
    shared String leftParent = "LEFT_PAREN";
    shared String rightParent = "RIGHT_PAREN";
    shared String leftBrace = "LEFT_BRACE";
    shared String rightBrace = "RIGTH_PAREN";
    shared String comma = "COMMA";
    shared String dot = "DOT";
    shared String minus = "MINUS";
    shared String plus = "PLUS";
    shared String semicolon = "SEMICOLON";
    shared String slash = "SLASH";
    shared String star = "STAR";

    // One or Two Characters Token

    shared String bang = "BANG";
    shared String bang_equal = "BANG_EQUAL";
    shared String equal = "EQUAL";
    shared String equalEqual = "EQUAL_EQUAL";
    shared String greater = "GREATER";
    shared String greaterEqual = "GREATER_EQUAL";
    shared String less = "LESS";
    shared String lessEqual = "LESS_EQUAL";

    //Literal

    shared String identifier = "IDENTIFIER";
    shared String literalString = "STRING";
    shared String number = "NUMBER";

    // Keywords

    shared String keywordAnd = "AND";
    shared String keywordClass = "CLASS";
    shared String keywordElse = "ELSE";
    shared String keywordFalse = "FALSE";
    shared String keywordFun = "FUN";
    shared String keywordFor = "FOR";
    shared String keywordIf = "IF";
    shared String keywordNil = "NIL";
    shared String keywordOr = "OR";
    shared String keywordPrint = "PRINT";
    shared String keywordReturn = "RETURN";
    shared String keywordSuper = "SUPER";
    shared String keywordThis = "THIS";
    shared String keywordTrue = "TRUE";
    shared String keywordVar = "VAR";
    shared String keywordWhile = "WHILE";
    shared String keywordEof = "EOF";

}
