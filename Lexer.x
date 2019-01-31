{
module Lexer where
}

%wrapper "basic"

$digit = [0-9]
$alpha = [a-zA-Z]

tokens :-
  $white+             ;
  "--".*              ;
  "="                 { \s -> TokenEq }
  clear               { \s -> TokenClear }
  copy                { \s -> TokenCopy }
  decr                { \s -> TokenDecr }
  do                  { \s -> TokenDo }
  end                 { \s -> TokenEnd }
  incr                { \s -> TokenIncr }
  init                { \s -> TokenInit }
  not                 { \s -> TokenNot }
  to                  { \s -> TokenTo }
  while               { \s -> TokenWhile }
  $alpha[$alpha $digit]* { \s -> TokenVar s }
  $digit+             { \s -> TokenInt (read s) }

{
data Token
  = TokenClear
  | TokenCopy
  | TokenDecr
  | TokenDo
  | TokenEnd
  | TokenIncr
  | TokenInit
  | TokenNot
  | TokenTo
  | TokenWhile
  | TokenEq
  | TokenVar String
  | TokenInt Int
  deriving (Eq, Show)

scanTokens = alexScanTokens

}
