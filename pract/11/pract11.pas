Program pract11;
CONST 
  MaxKol=1000000;
  CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
Type
  ArrayWord= array [0..MaxKol] of CHAR;
Var
  Fin,Fout: Text;
  NameFile, CHARS_, BestWord,Word_: STRING;
  Ch: CHAR;
  i: LONGINT;
  Kol,KolError: LONGINT; 
  Words:ArrayWord;
  
BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  READLN(Fin,Kol);
  BestWord:="";
  Word_:="";
  CHARS_:= CHARS;
  
  FOR i:=1 TO Kol
  DO
     READ(Fin,Words[i]);

  FOR i:=1 TO Kol
  DO
    IF Pos(Words[i],CHARS_)>0
    THEN
      BEGIN
        DELETE(CHARS_,Pos(Words[i],CHARS_),1);
        Word_:=Word_+ Words[i];
      END
    ELSE
      BEGIN      
        IF (LENGTH(Word_)>LENGTH(BestWord)) OR ((LENGTH(Word_)=LENGTH(BestWord)) AND ((Word_<BestWord)))
        THEN 
          BestWord:=Word_;
        IF (Pos(Words[i],CHARS_)>0) 
        THEN
          BEGIN
            CHARS_:= CHARS+Copy(Word_,1,Pos(Words[i],CHARS_)); 
            DELETE(Word_,1,Pos(Words[i],CHARS_));
          END  
        ELSE  
          BEGIN        
            CHARS_:=CHARS;
            DELETE(CHARS_,Pos(Words[i],CHARS_),1);
            Word_:= Words[i];
          END;
      END;
  IF (LENGTH(Word_)>LENGTH(BestWord)) OR ((LENGTH(Word_)=LENGTH(BestWord)) AND ((Word_<BestWord)))
  THEN
    BestWord:=Word_;
      
  WRITELN(FOut,BestWord);         
END.  
