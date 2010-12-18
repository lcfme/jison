
%x mu

%%

.+?/("{{")                   { this.begin('mu'); return 'CONTENT'; }
/("{{")                      { this.begin('mu'); }
.+                           { return 'CONTENT'; }

<mu>"{{>"                    { return 'OPEN_PARTIAL'; }
<mu>"{{#"                    { return 'OPEN_BLOCK'; }
<mu>"{{/"                    { return 'OPEN_ENDBLOCK'; }
<mu>"{{^"                    { return 'OPEN_INVERSE'; }
<mu>"{{{"                    { return 'OPEN_UNESCAPED'; }
<mu>"{{&"                    { return 'OPEN_UNESCAPED'; }
<mu>"{{!".*?"}}"             { yytext = yytext.substr(3,yyleng-5); this.begin('INITIAL'); return 'COMMENT'; }
<mu>"{{"                     { return 'OPEN'; }

<mu>"/"                      { return 'SEP'; }
<mu>\s+                      { /*ignore whitespace*/ }
<mu>"}}}"                    { this.begin('INITIAL'); return 'CLOSE'; }
<mu>"}}"                     { this.begin('INITIAL'); return 'CLOSE'; }
<mu>'"'("\\"["]|[^"])*'"'    { yytext = yytext.substr(1,yyleng-2); return 'STRING'; }
<mu>[a-zA-Z0-9_.]+/[} /]     { return 'ID'; }
<mu>.                        { return 'INVALID'; }

