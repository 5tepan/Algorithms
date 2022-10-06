Program pract15;
CONST 
  MaxKol=10000;
Type
  ArrayProc= array [1..MaxKol] of INTEGER;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  Ch: CHAR;
  i, j, Kol, KolAr, Flag: INTEGER;
  Processes:ArrayProc;

PROCEDURE Sort(Kol: INTEGER); //возрастание
VAR i,j,Math_: INTEGER;
BEGIN
  FOR i:=1 to Kol 
   DO
     FOR j:=i+1 to Kol 
     DO
       IF (Processes[j] < Processes[i])
         THEN
           BEGIN
             Math_:=Processes[j];
             Processes[j]:=Processes[i];
             Processes[i]:=Math_;
           END;
  Math_:=Processes[2]-Processes[1];
  FOR i:=1 to Kol-1 
   DO 
    IF (Processes[i+1]<>Processes[i]+ Math_)
    THEN
      BEGIN
        Flag:=0;
        EXIT;
      END;  

             
END;  
BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  READLN(Fin,KolAr);
  FOR i:=1 TO KolAr
  DO
    BEGIN
      READLN(Fin,Kol);    
      FOR j:=1 TO Kol
      DO
       Processes[i]:=0;

      FOR j:=1 TO Kol
      DO
        READ(Fin,Processes[j]);
        
     Flag:=1;   
     Sort(Kol);
     IF Flag=1
     THEN
       WRITELN(FOUT,"Yes")
     ELSE
       WRITELN(FOUT,"No");  
   END;           
END.  
