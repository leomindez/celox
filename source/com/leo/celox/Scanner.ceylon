import ceylon.collection {
    LinkedList
}


shared class Scanner(String source) {

    LinkedList<Token> tokens = LinkedList<Token>();
    variable Integer start = 0;
    variable Integer current = 0;
    variable Integer line = 1;


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
            addToken(tokenType.start);
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
                while (comparableCharacter(peek(), '\n') && !isAtEnd()) {
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
        else {
            ErrorManager.error(line, "Unexpected character");
        }
    }

    Boolean isAtEnd() => current>=source.size;

    Character? advance() {
        current++;
        return source.get(current - 1);
    }

    void addToken(String tokenType, Object? literal = null) {
        value text = source.substring(start, current);
        tokens.add(Token(tokenType, text, line));
    }

    Boolean match(Character expected) {

        Character? char = source.get(current);
        if (isAtEnd()) {
            return false;
        }
        if (comparableCharacter(char, expected)) {
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

    Boolean comparableCharacter(Character? target, Character comparable) {
        switch (target?.compare(comparable))
        case (equal) {
            return true;
        }
        else {
            return false;
        }
    }
}