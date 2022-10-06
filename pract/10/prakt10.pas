Program prakt10;
CONST 
  MaxKol=10000;
Type
  ArrayWord= array [1..MaxKol] of STRING;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  Word,WordFromSlov: STRING;
  i,Kol,KolBal: INTEGER; 
  Words:ArrayWord;

PROCEDURE Sort(); //возрастание
VAR i,j: INTEGER;
   Word_: STRING;
BEGIN
  FOR i:=1 to Kol 
   DO
     FOR j:=i+1 to Kol 
     DO
       IF (LENGTH(Words[j]) > LENGTH(Words[i]))
         THEN
           BEGIN
             Word_:=Words[j];
             Words[j]:=Words[i];
             Words[i]:=Word_;
           END;
END;
Function WordInWord(Word1, Word2: STRING): BOOLEAN; 
VAR i,j: INTEGER;
BEGIN
  WordInWord:=True;
  FOR i:=1 TO  LENGTH(Word1) 
  DO
    IF  Pos(Word1[i],Word2)<>0
    THEN
      BEGIN
        j:=Pos(Word1[i],Word2);
        Delete(Word2,j,1);          
      END         
    ELSE
      BEGIN
        WordInWord:=FALSE;
        EXIT;
      END;  
END;

BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  Kol:=0; 
  KolBal:=0;      
  READLN(Fin,Word);
  WHILE NOT EOF(Fin)
  DO                   
    BEGIN
      READLN(Fin,WordFromSlov);  
      IF WordInWord(WordFromSlov,Word)
      THEN
        BEGIN
           Kol:=Kol+1;
           Words[Kol]:=WordFromSlov;
           KolBal:=KolBal+LENGTH(WordFromSlov);
        END;
    END;

  IF Kol>0                    
  THEN
    Sort();

  WRITELN(FOut,KolBal);           
  FOR i:=1 TO  Kol
  DO
    WRITELN(FOut,Words[i]);   
END.
