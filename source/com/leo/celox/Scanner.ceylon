import ceylon.collection {
    LinkedList
}

import ceylon.language { Float {
    parse
} }

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
                while (isSameCharacter(peek(), '\n') && !isAtEnd()) {
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
        case('"'){
            string();
        }
        else {
            if(isDigit(character)){
                number();
            }else {
                ErrorManager.error(line, "Unexpected character");
            }
        }
    }

    void string(){
        while(!isSameCharacter(peek(), '"') && !isAtEnd()){
            if(isSameCharacter(peek(), '\n')) {
                line++;
            }
            advance();

            if(isAtEnd()){
                ErrorManager.error(line, "Unterminated string");
                return;
            }

            advance();

            value stringValue = source.substring(start + 1, current - 1);
            addToken(tokenType.string, stringValue);

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
        if (isSameCharacter(char, expected)) {
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

    Character? peekNext(){
        if(current + 1 >= source.size ) {
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

    Boolean isDigit(Character? character){
        if(exists character){
        return character >= '0' && character <= '9';
        }
        return false;
    }

    void number(){
        Float d = 10.99387838740;

        while(isDigit(peek())){
            advance();
        }
        
        if(isSameCharacter(peek(), '.') && isDigit(peekNext())){
            advance();

            while(isDigit(peek())){
                advance();
            }
        }
        
        addToken(tokenType.number, parse(source.substring(start, current)));
    }
}