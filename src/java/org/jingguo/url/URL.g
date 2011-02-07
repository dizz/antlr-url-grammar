grammar URL;

options {
  language = Java;
}

//XXX No support for:
//opaque_part: uric_no_slash uric+;
//uric_no_slash: unreserved | escaped | ~('/');

url: abs_url | rel_url;

abs_url: scheme ':' hier_part;
scheme: ALPHA ( ALPHA | DIGIT | '+' | '-' | '.' )*;

rel_url: ( net_path | abs_path | rel_path ) ('?' query)?;

hier_part: net_path ('?' query)? ('#' fragment_)?;
net_path: '//' server (abs_path)?;
abs_path: ('/' segment)+;
rel_path: rel_segment ( abs_path )?;
rel_segment: ( unreserved | escaped | reserved)+;

segment: (pchar)+;
pchar: escaped | unreserved | ':' | '@' | '&' | '=' | '+' | '$' | ',';

server: host (':' port)?;

port: (DIGIT)+;
host: hostname | ipV4Address;

hostname: (domainlabel '.')* toplabel;
domainlabel: alphanum ((alphanum | '-')* alphanum)?;
toplabel: ALPHA ((alphanum | '-')? alphanum)?;

ipV4Address: (DIGIT)+ '.' (DIGIT)+ '.' (DIGIT)+ '.' (DIGIT)+;
fragment_: (uric)*;

query: param ('&' param)*;
param: pname '=' pvalue;
pname: (qc)+;
pvalue: (qc)+;

qc: escaped | Q_RESERVED | unreserved;
uric: escaped | reserved | unreserved;

unreserved: alphanum | MARK;
escaped: '%' hex hex;
hex: DIGIT | HEX_LETTER;
alphanum: DIGIT | ALPHA;
reserved: Q_RESERVED | '=' | '&';

Q_RESERVED: ';' | '/' | '?' | ':' | '@' | '+' | '$' | ',';
MARK: '-' | '_' | '.' | '!' | '~' | '*' | '\'' | '(' | ')';
DIGIT: '0'..'9';
ALPHA: 'a'..'z' | 'A'..'Z' ;
fragment HEX_LETTER: 'a'..'f' | 'A'..'F';
