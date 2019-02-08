{
module HappyParser where
import Lexer
}

%name parseCalc
%tokentype { Token }
%error { parseError }

%token
    '='               { TokenEq }
    clear             { TokenClear }
    copy              { TokenCopy }
    decr              { TokenDecr }
    do                { TokenDo }
    end               { TokenEnd }
    incr              { TokenIncr }
    init              { TokenInit }
    not               { TokenNot }
    to                { TokenTo }
    while             { TokenWhile }
    int               { TokenInt $$ }
    var               { TokenVar $$ }

%right in

%%

ExpList : Exp ExpList                             { ExpList $1 $2 }
        | Exp                                     { Exp $1 }

Exp : while Variable not Number do ExpList end    { WhileLoop $2 $4 $6 }
    | copy Variable to Variable                   { CopyVar $2 $4 }
    | init Variable '=' Number                    { InitVar $2 $4 }
    | incr Variable                               { IncrVar $2 }
    | decr Variable                               { DecrVar $2 }
    | clear Variable                              { ClearVar $2 }

Number : int                                      { Int $1 }

Variable : var                                    { Var $1 }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

data ExpList
    = ExpList Exp ExpList
    | Exp Exp
    deriving Show

data Exp
      = WhileLoop Variable Number ExpList
      | CopyVar Variable Variable
      | InitVar Variable Number
      | IncrVar Variable
      | DecrVar Variable
      | ClearVar Variable
      deriving Show

data Number
      = Int Int
      deriving Show

data Variable
      = Var String
      deriving Show
}
