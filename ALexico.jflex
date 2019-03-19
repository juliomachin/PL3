//Area de codigo, importaciones y paquetes

import java.io.*;
%%
//Area de opciones y declaraciones
%class StateLexer
%int
%standalone
%line
%column
%{
//Preparo un objeto String para almacenar el contenido de las cadenas de texto
String tempCadena = new String("");
String initJava = new String("");
%}
%state JAVA, PHP, JAVA_NEUTRO, PHP_NEUTRO

Digito = [0-9]
Numero = {Digito} {Digito}*
Finlinea = \n|\r\|\r\n
Blanco = {Finlinea}|[ \t\f]

%%
//Area de reglas y acciones
<YYINITIAL>{
"BeginJava" {System.out.print("JAVA_INIT"); yybegin(JAVA);}
"BeginPHP" {System.out.print("PHP_INIT"); yybegin(PHP);}
} 

<JAVA>{
"EndJava" {System.out.print("JAVA_FIN"); yybegin(YYINITIAL);}
"if" | "else if" | "else" {System.out.println("JAVA_CONDICIONAL");}
[>] {System.out.println("JAVA_OPERADOR_MAYOR_QUE");}
[<] {System.out.println("JAVA_OPERADOR_MENOR_QUE");}
"==" {System.out.println("JAVA_OPERADOR_IGUAL_QUE");}
">=" {System.out.println("JAVA_OPERADOR_MAYOR_O_IGUAL_QUE");}
"<=" {System.out.println("JAVA_OPERADOR_MENOR_O_IGUAL_QUE");}
"="  {System.out.println("JAVA_ASING");}
";" {System.out.print("JAVA_FIN_INS");}
([a-zA-Z]|[_])+([a-zA-Z]|[0-9]|[_])* {System.out.println("JAVA_ID("+yytext()+")");}
"\"" {System.out.print("JAVA_CAD_INI"); yybegin(JAVA_NEUTRO);}
{Blanco} {}
[.] {System.out.println("JAVA_PUNTO");}
[(] {System.out.println("JAVA_ABRE_PAR");}
[)] {System.out.println("JAVA_CIERRA_PAR");}
[{] {System.out.println("JAVA_ABRE_LLAVE");}
[}] {System.out.println("JAVA_CIERRA_LLAVE");}
. {System.out.println("Error en JAVA la linea " + yyline);}
}


<JAVA_NEUTRO>{
([a-zA-Z]|[_])+([a-zA-Z]|[0-9]|[_] | [ ])* {System.out.println(" ");}
"\"" {System.out.println("JAVA_CAD_FIN"); yybegin(JAVA); }
"\n" {System.out.println("Error Java"+ yyline);}


}


<PHP>{
"EndPHP" {System.out.println("PHP_FIN"); yybegin(YYINITIAL);}
"if" | "elseif" | "else" {System.out.println("PHP_CONDICIONAL");}
[>] {System.out.println("PHP_OPERADOR_MAYOR_QUE");}
[<] {System.out.println("PHP_OPERADOR_MENOR_QUE");}
"==" {System.out.println("PHP_OPERADOR_IGUAL_QUE");}
">=" {System.out.println("PHP_OPERADOR_MAYOR_O_IGUAL_QUE");}
"<=" {System.out.println("PHP_OPERADOR_MENOR_O_IGUAL_QUE");}
"="  {System.out.println("PHP_ASING");}
";" {System.out.print("PHP_FIN_INS");}
([$])+([a-zA-Z]|[0-9]|[_])* {System.out.println("PHP_ID("+ yytext().substring(1)+")");}
([a-zA-Z]|[_])+([a-zA-Z]|[0-9]|[_])* {System.out.println("PHP_ID("+ yytext()+")");}
"\"" {System.out.print("PHP_CAD_INI"); yybegin(PHP_NEUTRO);}
{Blanco} {System.out.print("");}
. {System.out.println("Error en PHP la linea " + yyline);}
}


<PHP_NEUTRO>{
([a-zA-Z]|[_])+([a-zA-Z]|[0-9]|[_] | [ ])* {System.out.println(" ");}
"\"" {System.out.println("PHP_CAD_FIN"); yybegin(PHP); }
"\n" {System.out.println("Error PHP"+ yyline);}


}


 

