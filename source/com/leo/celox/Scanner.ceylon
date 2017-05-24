import ceylon.collection {
    LinkedList,
    HashMap
}

import ceylon.language {
    Float {
        parse
    }
}

shared class Scanner(String source) {

    LinkedList<Token> tokens = LinkedList<Token>();
    variable Integer start = 0;
    variable Integer current = 0;
    variable Integer line = 1;

    value keywords = HashMap {
        "and"->tokenType.keywordAnd,
        "class"->tokenType.keywordClass,
        "else"->tokenType.keywordElse,
        "false"->tokenType.keywordFalse,
        "for"->tokenType.keywordFor,
        "fun"->tokenType.keywordFun,
        "if"->tokenType.keywordIf,
        "nil"->tokenType.keywordNil,
        "or"->tokenType.keywordOr,
        "print"->tokenType.keywordPrint,
        "return"->tokenType.keywordReturn,
        "super"->tokenType.keywordSuper,
        "this"->tokenType.keywordThis,
        "true"->tokenType.keywordTrue,
        "var"->tokenType.keywordVar,
        "while"->tokenType.keywordWhile
    };

    shared LinkedList<Token> scanTokens() {
        while (!isAtEnd()) {
            start = current;
            scanToken();
        }

        tokens.add(Token(tokenType.keywordEof, "", line));
        return tokens;
    }


    void scanToken() {
        value character = advance();
        switch (character)
        case ('(') {
            addToken(tokenType.leftParent);
        }
        case (')') {
            addToken(tokenType.rightParent);
        }
        case ('{') {
            addToken(tokenType.leftBrace);
        }
        case ('}') {
            addToken(tokenType.rightBrace);
        }
        case (',') {
            addToken(tokenType.comma);
        }
        case ('.') {
            addToken(tokenType.dot);
        }
        case ('-') {
            addToken(tokenType.minus);
        }
        case ('+') {
            addToken(tokenType.plus);
        }
        case (';') {
            addToken(tokenType.semicolon);
        }
        case ('*') {
            addToken(tokenType.star);
        }
        case ('!') {
            addToken(if (match('=')) then tokenType.bang_equal else tokenType.bang);
        }
        case ('=') {
            addToken(if (match('=')) then tokenType.equalEqual else tokenType.equal);
        } case ('<') {
            addToken(if (match('=')) then tokenType.lessEqual else tokenType.less);
        } case ('>') {
            addToken(if (match('=')) then tokenType.greaterEqual else tokenType.greater);
        }
        case ('/') {
            if (match('/')) {
                while (!isSameCharacter(peek(), '\n') && !isAtEnd()) {
                    advance();
                }
            } else {
                addToken(tokenType.slash);
            }
        }
        case (' '|'\r'|'\t') {
        }
        case ('\n') {
            line++;
        }
        case ('"') {
            string();
        }
        else {
            if (isDigit(character)) {
                number();
            } else if (isAlpha(character)) {
                identifier();
            } else {
                ErrorManager.error(line, "Unexpected character");
            }
        }
    }

    void string() {
        while (!isSameCharacter(peek(), '"')&& !isAtEnd()) {
            if (isSameCharacter(peek(), '\n')) {
                line++;
            }
            advance();
        }
            if (isAtEnd()) {
                ErrorManager.error(line, "Unterminated string");
                return;
            }

            advance();

            value stringValue = source.substring(start + 1, current - 1);
            addToken(tokenType.string, stringValue);

    }

    Boolean isAtEnd() => current >= source.size;

    Character? advance() {
        current++;
        return source.get(current - 1);
    }

    void addToken(String? tokenType, Object? literal = null) {
        if (exists tokenType) {
            value text = source.substring(start, current);
            tokens.add(Token(tokenType, text, line,literal));
        }
    }

    Boolean match(Character expected) {

        Character? char = source.get(current);
        if (isAtEnd()) {
            return false;
        }
        if (!isSameCharacter(char, expected)) {
            return false;
        }

        current++;
        return true;
    }

    Character? peek() {
        if (current>=source.size) {
            return '\0';
        }
        return source.get(current);
    }

    Character? peekNext() {
        if (current + 1>=source.size) {
            return '\0';
        }
        return source.get(current + 1);
    }

    Boolean isSameCharacter(Character? target, Character comparable) {
        switch (target?.compare(comparable))
        case (equal) {
            return true;
        }
        else {
            return false;
        }
    }

    Boolean isDigit(Character? character) {
        if (exists character) {
            return character>='0' && character<='9';
        }
        return false;
    }

    void number() {
        while (isDigit(peek())) {
            advance();
        }

        if (isSameCharacter(peek(), '.') &&isDigit(peekNext())) {
            advance();

            while (isDigit(peek())) {
                advance();
            }
        }

        addToken(tokenType.number, parse(source.substring(start, current)));
    }

    Boolean isAlpha(Character? character) {
        if (exists character) {
            return (character>='a' && character<='z') ||
            (character>='A' && character<='Z')
            ||isSameCharacter(character, '_');
        } else {
            return false;
        }
    }

    Boolean isAlphaNumeric(Character? character) => isAlpha(character) ||isDigit(character);

    void identifier() {
        while (isAlphaNumeric(peek())) {
            advance();
        }
        value text = source.substring(start, current);
        value type = keywords.get(text);
        if (!exists type) {
            addToken(tokenType.identifier);
        } else {
            addToken(type);
        }
    }

}