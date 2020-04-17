/* Definition section */
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define YY_NO_UNPUT
    #define YY_NO_INPUT

    int line_num = 0;
    int comment_num = 0;
    char s[100] = "";
    int flag=0;
    int incomment=0;
%}

/* Define regular expression label */
letter [a-zA-Z_]
digit [0-9]
id {letter}+({letter}|{digit})*
inumber {digit}+
fnumber ({digit}*\.{digit}+)
string \"([^\\\"]|\\.)*\"
comment1 ("//")[^\n\r]*
comment2  "/*"([^*]|\*+[^*/])*\*+"/"

/* Rules section */
%%

"+"         { printf("%-8s \t %s\n", yytext, "ADD"); }
"-"         { printf("%-8s \t %s\n", yytext, "SUB"); }
"*"         { printf("%-8s \t %s\n", yytext, "MUL"); }
"/"         { printf("%-8s \t %s\n", yytext, "QUO"); }
"%"         { printf("%-8s \t %s\n", yytext, "REM"); }
"++"        { printf("%-8s \t %s\n", yytext, "INC"); }
"--"        { printf("%-8s \t %s\n", yytext, "DEC"); }
">"         { printf("%-8s \t %s\n", yytext, "GTR"); }
"<"         { printf("%-8s \t %s\n", yytext, "LSS"); }
">="        { printf("%-8s \t %s\n", yytext, "GEQ"); }
"<="        { printf("%-8s \t %s\n", yytext, "LEQ"); }
"=="        { printf("%-8s \t %s\n", yytext, "EQL"); }
"!="        { printf("%-8s \t %s\n", yytext, "NEQ"); }
"="         { printf("%-8s \t %s\n", yytext, "ASSIGN"); }
"+="        { printf("%-8s \t %s\n", yytext, "ADD_ASSIGN"); }
"-="        { printf("%-8s \t %s\n", yytext, "SUB_ASSIGN"); }
"*="        { printf("%-8s \t %s\n", yytext, "MUL_ASSIGN"); }
"/="        { printf("%-8s \t %s\n", yytext, "QUO_ASSIGN"); }
"%="        { printf("%-8s \t %s\n", yytext, "REM_ASSIGN"); }
"&&"        { printf("%-8s \t %s\n", yytext, "LAND"); }
"||"        { printf("%-8s \t %s\n", yytext, "LOR"); }
"!"         { printf("%-8s \t %s\n", yytext, "NOT"); }
"("         { printf("%-8s \t %s\n", yytext, "LPAREN"); }
")"         { printf("%-8s \t %s\n", yytext, "RPAREN"); }
"["         { printf("%-8s \t %s\n", yytext, "LBRACK"); }
"]"         { printf("%-8s \t %s\n", yytext, "RBRACK"); }
"{"         { printf("%-8s \t %s\n", yytext, "LBRACE"); }
"}"         { printf("%-8s \t %s\n", yytext, "RBRACE"); }
";"         { printf("%-8s \t %s\n", yytext, "SEMICOLON"); }
","         { printf("%-8s \t %s\n", yytext, "COMMA"); }

{string}	{ printf("%-8c \t %s\n",yytext[0],"QUOTA");
			      int i = 0;
            char s[100]= "";
            int len=strlen(yytext);
			      for(i = 1;i<len-1;i++){
                s[i-1]=yytext[i];
			      }
			      printf("%-8s \t %s\n",s,"STRING");
            printf("%-8c \t %s\n",yytext[len-1],"QUOTA");
			    }

 /*COMMENT*/ 
{comment1}  {
              incomment=1;
	            printf("%-8s \t %s\n", yytext, "C++ Comment");
	          }
{comment2}  {
              incomment=1;
              int i=0;
              int j=0;
              int len=strlen(yytext);
              int front=0;
              int back=0;
			        for(i = 0;i<len-1;i++){
                if(yytext[i]=='\n'){
                  flag=1;
                  back=i;
                  char s[100]= "";
                  for(j = 0;j<(back-front);j++){
                    s[j]=yytext[j+front];
			            }
                  printf("%s\n",s);
                  printf("%-8s\t %s\n"," ","C Comment");
                  front=back+1;
                  line_num++;
                  comment_num++;
                }
			        }
              if(flag==1){
                char s[100]="";
                for(j = 0;j<(len-2-front);j++){
                  s[j]=yytext[j+front];
			          }
                printf("%s",s);
                printf("%-8s \t %s\n","*/","C Comment");
              }
              else{
                char s[100]="";
                int j=0;
                for(j = 0;j<(len-2);j++){
                  s[j]=yytext[j];
			          }
                printf("%s",s);
                printf("%-8s \t %s\n","*/", "C Comment");
              }
              flag=0;
            }
"\n"        { printf("%-8s \t %s\n"," ","NEWLINE");
              line_num++;
              if(incomment==1){
                comment_num++;
                incomment=0;
              }
            }

"print"     { printf("%-8s \t %s\n", yytext, "PRINT"); }
"println"   { printf("%-8s \t %s\n", yytext, "PRINTLN"); }
"if"        { printf("%-8s \t %s\n", yytext, "IF"); }
"else"      { printf("%-8s \t %s\n", yytext, "ELSE"); }
"for"       { printf("%-8s \t %s\n", yytext, "FOR"); }

{inumber}   { printf("%-8s \t %s\n", yytext, "INT_LIT"); }
{fnumber}   { printf("%-8s \t %s\n", yytext, "FLOAT_LIT"); }

"int32"	    { printf("%-8s \t %s\n", yytext, "INT");}
"float32"	  { printf("%-8s \t %s\n", yytext, "FLOAT");}
"string"	  { printf("%-8s \t %s\n", yytext, "STRING");}

"bool"      { printf("%-8s \t %s\n", yytext, "BOOL"); }
"true"      { printf("%-8s \t %s\n", yytext, "TRUE"); }
"false"     { printf("%-8s \t %s\n", yytext, "FALSE"); }
 "var"      { printf("%-8s \t %s\n", yytext, "VAR"); }

{id}        { printf("%-8s \t %s\n", yytext, "IDENT"); }

 <<EOF>>    { 
              line_num++; 
              if(incomment==1){
                comment_num++;
                incomment=0;
              }
              yyterminate(); 
            }
.           {;}

%%

/*  C Code section */
int yywrap(void)
{
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }
    yylex();
    printf("\nFinish scanning,\n");
    printf("total line: %d\n", line_num);
    printf("comment line: %d\n", comment_num);
    fclose(yyin);
    return 0;
}
