Program pract9;
CONST
  MaxPole=10000;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  Kol,i,j: INTEGER;
  Pole:array [1..MaxPole,1..MaxPole] of INTEGER; 
  Variants:array [1..5,1..2] of INTEGER; 
  
 BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  READLN(Fin,Kol);
  FOR i:=1 TO  Kol
  DO
    READLN(Fin,Variants[i][1],Variants[i][2]);

  Pole[1][1]:=1;
  FOR i:=2 TO MaxPole    
    DO
      FOR j:=2 TO MaxPole 
      DO
        IF (Pole[i-1][j]=0) AND (Pole[i][j-1]=0)  AND (Pole[i-1][j-1]=0)         
        THEN  
           Pole[i][j]:=1;
           
 FOR i:=1 TO  Kol 
 DO 
  // это первая клетка или можно перейти на выигрышную
   IF ((Variants[i][1]=1) AND (Variants[i][2]=1)) OR (Pole[Variants[i][1]-1][Variants[i][2]]=1) OR (Pole[Variants[i][1]][Variants[i][2]-1]=1)  OR (Pole[Variants[i][1]-1][Variants[i][2]-1]=1) 
   THEN
     WRITELN(FOut,1)
   ELSE
    WRITELN(FOut,2); 
END.    
    

