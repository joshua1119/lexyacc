%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#define EOI 0
#define NAME 1 /* identifier */
#define STRING 2 /* string constant “......”*/
#define ICON 3 /* integer or character constant*/
#define FCON 4 /* floating point constant */
#define PLUS 5 /* + */
#define MINUS 6 /* - */
#define STAR 7 /* * */
#define AND 8 /* & */
#define QUEST 9 /* ? */
#define COLON 10 /* : */
#define ANDAND 11 /* && */
#define OROR 12 /* || */
#define RELOP 13 /* < <= > >= */
#define EQUOP 14 /* == != */
#define DIVOP 15 /* / % */
#define OR 16 /* | */
#define XOR 17 /* ^ */
#define SHIFTOP 18 /* >> << */
#define INCOP 19 /* ++-- */
#define UNOP 20 /* ! ~ */
#define STRUCTOP 21 /* . -> */
#define TYPE 22 /* int, long, etc. */
#define CLASS 23 /* extern,static, typedef,etc. */
#define STRUCT 24/* struct, union*/
#define RETURN 25 /* return */
#define GOTO 26 /* goto */
#define IF 27 /* if */
#define ELSE 28 /* else */
#define SWITCH 29 /* switch */
#define BREAK 30 /* break */
#define CONTINUE 31 /* continue */
#define WHILE 32 /* while */
#define DO 33 /* do */
#define FOR 34 /* for */
#define DEFAULT 35 /* default */
#define CASE 36 /* case */
#define SIZEOF 37 /* sizeof */
#define LP 38 /* ( left prenthesis */
#define RP 39 /* ) */
#define LC 40 /* { */
#define RC 41 /* } */
#define LB 42 /* \[ */
#define RB 43 /* \] */
#define COMMA 44 /* , */
#define SEMI 45 /* ; */
#define EQUAL 46 /* = */
#define ASSIGNOP 47 /* += -= etc. */
/* The following definitions are used for preprocess symbols */
#define JINGHAO 48/* # */
#define INCLUDE 49/* include */
#define DEFINE 50/* define */
#define IFDEF 51/* ifdef */
#define IFNDEF 52/* ifndef */
#define ENDIF 53/* endif */
/* The following definitions are used for ′ ′,′＼t′,′＼n′ etc. */
#define WHITE 200
#define ERRORCHAR 300/* error characters */
int idorkeyword(char *lx);
%}

65. /* The following definitions are macros */
66. letter\[A-Za-z\]
67. alnum\[A-Za-z0-9\]
68. h\[0-9a-fA-F\]
69. o\[0-7\]
70. d\[0-9\]
71. suffix\[UuLl\]
72. white\[＼t＼n＼040\]
73. %startCOMMENT/* used for comment lines */
74. %%
75. /******** THE RECOGNISING RULES ******************/
76. "/*"{printf("%s",yytext);BEGIN COMMENT;}
77. <COMMENT>＼n{printf("%s",yytext);}
78. <COMMENT>"*/"{printf("%s",yytext);BEGIN 0;}
79. <COMMENT>.{printf("%s",yytext);}
80. ＼"(＼＼.|\[^＼"\])*＼"return STRING;
81. ＼"(＼＼.|\[^＼"\])*\[＼r＼n\] {printf("Adding missing＼"to string constant＼n");
82. return STRING;}
83. ′.′return ICON; 
84. ′＼＼.′return ICON;
85. ′＼＼{o}({o}{o}?)?′return ICON;
86. ′＼＼\[xX\]{h}({h}{h}?)?′return ICON;
87. 0{o}*{suffix}?return ICON; 
88. 0\[xX\]{h}+{suffix}?return ICON;
89. \[1-9\]{d}*{suffix}?return ICON; 
90. (\[1-9\]{d}*|{d}+＼.{d}*|{d}*＼.{d}+)(\[eE\]\[-+\]?{d}+)?\[fF\]? return FCON;
91. "("return LP;
92. ")"return RP;
93. "{"return LC;
94. "}"return RC;
95. "\["return LB;
96. "\]"return RB;
97. ("->")|(".")return STRUCTOP;
98. ("++")|("--")return INCOP;
99. \[/%\]return DIVOP;
100. \[~!\]return UNOP;
101. ＼<＼<|＼>＼>return SHIFTOP;
102. \[<>\]=?return RELOP;
103. \[!=\]=return EQUOP;
104. \[-+*/%&|＼^\]=return ASSIGNOP;
105. (＼<＼<|＼>＼>)=return ASSIGNOP;
106. "*"return STAR;
107. "+"return PLUS;
108. "-"return MINUS;
109. "="return EQUAL;
110. "&"return AND;
111. "^"return XOR;
112. "|"return OR;
113. "&&"return ANDAND;
114. "||"return OROR;
115. "?"return QUEST;
116. ":"return COLON;
117. ","return COMMA;
118. ";"return SEMI;
119. {letter}{alnum}*return idorkeyword(yytext);
120. "#"return JINGHAO;
121. {white}+return WHITE;/* Ignore white space */
122. .{printf(" Invalid char %s＼n",yytext);
123. return ERRORCHAR;}
124. %%
125. /* beginning of auxiliary functions */
126. typedef struct{char *name; int val;} KWRDSTRUCT;
127. KWRDSTRUCT Ktab\[\]=
128. {
129. {"auto",CLASS},
130. {"break",BREAK},
131. {"case",CASE},
132. {"char",TYPE},
133. {"continue",CONTINUE},
134. {"default",DEFAULT},
135. {"do",DO},
136. {"double",TYPE},
137. {"else",ELSE},
138. {"extern",CLASS},
139. {"float",TYPE},
140. {"for",FOR},
141. {"goto",GOTO},
142. {"if",IF},
143. {"int",TYPE},
144. {"long",TYPE},
145. {"register",CLASS},
146. {"return",RETURN},
147. {"short",TYPE},
148. {"sizeof",SIZEOF},
149. {"static",CLASS},
150. {"struct",STRUCT},
151. {"switch",SWITCH},
152. {"typedef",CLASS},
153. {"union",STRUCT},
154. {"unsigned",TYPE},
155. {"void",TYPE},
156. {"while",WHILE},
157. /****************************************
158. The following definitions are used for preprocess *
159. ****************************************/
160. {"include",INCLUDE},
161. {"define",DEFINE},
162. {"ifdef",IFDEF},
163. {"ifndef",IFNDEF},
164. {"endif",ENDIF}
165. } ;
166. /* bsrch(): check if a is member of tab */
167. KWRDSTRUCT *bsrch(KWRDSTRUCT *a,KWRDSTRUCT *tab,int number)
168. {
169. int i;
170. for(i=0;i<number;i++)
171. if(!strcmp(a->name,tab\[i\].name))return &tab\[i\]; /* it is a keyword */
172. return NULL; /*It is a identifier*/
173. }
174. /* idorkeyword(): Do a binary search for a possible Keyword in Ktab.
175. Return the token if it's in the table;return NAME otherwise */
176. int idorkeyword(char *lx) 
177. {
178. KWRDSTRUCT *p;
179. KWRDSTRUCT dummy;
180. static int number=sizeof(Ktab)/sizeof(KWRDSTRUCT);
181. dummy.name=lx;
182. p=bsrch(&dummy,Ktab,number);
183. return(p ? p->val:NAME);
184. }
185. /* The following functions are used only for testing */
186. writeout(int c,char *text)
187. {
188. printf("(");
189. switch(c)
190. {
191. case 0: printf("EOI, %s ) ",text); break;
192. case 1: printf("NAME, %s ) ",text); break;
193. case 2: printf("STRING, %s ) ",text); break;
194. case 3: printf("ICON, %s ) ",text); break; 
195. case 4: printf("FCON, %s ) ",text); break; 
196. case 5: printf("PLUS, %s ) ",text); break; 
197. case 6: printf("MINUS, %s ) ",text); break;
198. case 7: printf("STAR, %s ) ",text); break; 
199. case 8: printf("AND, %s ) ",text); break; 
200. case 9: printf("QUEST, %s ) ",text); break; 
201. case 10: printf("COLON, %s ) ",text); break; 
202. case 11: printf("ANDAND, %s ) ",text); break;
203. case 12: printf("OROR, %s ) ",text); break;
204. case 13: printf("RELOP, %s ) ",text); break;
205. case 14: printf("EQUOP, %s ) ",text); break; 
206. case 15: printf("DIVOP, %s ) ",text); break; 
207. case 16: printf("OR, %s ) ",text); break; 
208. case 17: printf("XOR, %s ) ",text); break; 
209. case 18: printf("SHIFTOP, %s ) ",text); break; 
210. case 19: printf("INCOP, %s ) ",text); break; 
211. case 20: printf("UNOP, %s ) ",text); break; 
212. case 21: printf("STRUCTOP, %s ) ",text); break; 
213. case 22: printf("TYPE, %s ) ",text); break; 
214. case 23: printf("CLASS, %s ) ",text); break; 
215. case 24: printf("STRUCT, %s ) ",text); break; 
216. case 25: printf("RETURN, %s ) ",text); break; 
217. case 26: printf("GOTO, %s ) ",text); break; 
218. case 27: printf("IF, %s ) ",text); break; 
219. case 28: printf("ELSE, %s ) ",text); break; 
220. case 29: printf("SWITCH, %s ) ",text); break; 
221. case 30: printf("BREAK, %s ) ",text); break; 
222. case 31: printf("CONTINUE, %s ) ",text); break; 
223. case 32: printf("WHILE, %s ) ",text); break; 
224. case 33: printf("DO, %s ) ",text); break; 
225. case 34: printf("FOR, %s ) ",text); break; 
226. case 35: printf("DEFAULT, %s ) ",text); break;
227. case 36: printf("CASE, %s ) ",text); break; 
228. case 37: printf("SIZEOF, %s ) ",text); break; 
229. case 38: printf("LP, %s ) ",text); break; 
230. case 39: printf("RP, %s ) ",text); break; 
231. case 40: printf("LC, %s ) ",text); break; 
232. case 41: printf("RC, %s ) ",text); break; 
233. case 42: printf("LB, %s ) ",text); break; 
234. case 43: printf("RB, %s ) ",text); break; 
235. case 44: printf("COMMA, %s ) ",text); break;
236. case 45: printf("SEMI, %s ) ",text); break; 
237. case 46: printf("EQUAL, %s ) ",text); break; 
238. case 47: printf("ASSIGNOP, %s ) ",text); break; 
239. /* The following definitions are used for preprocess symbols */
240. case 48: printf("JINGHAO, %s ) ",text); break;
241. case 49: printf("INCLUDE, %s ) ",text); break;
242. case 50: printf("DEFINE, %s ) ",text); break; 
243. case 51: printf("IFDEF, %s ) ",text); break;
244. case 52: printf("IFNDEF, %s ) ",text); break; 
245. case 53: printf("ENDIF, %s ) ",text); break; 
246. default:break;
247. }
248. }
249. void main(int argc,char **argv)
250. {
251. int c;
252. if(argc>=2)
253. { 
254. if((yyin=fopen(argv\[1\],"r"))==NULL)
255. {printf("Can't open file %s＼n",argv\[1\]);exit(0);}
256. }
257. while(c=yylex())
258. {static j=0;
259. if(c<200){writeout(c,yytext);j++;}
260. else continue;
261. if(j == j/4*4)printf("＼n");
262. }
263. return;
264. }