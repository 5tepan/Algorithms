Program pract8;
Var
  Fin,Fout: Text;
  NameFile,Way: STRING;
  N,M,Kol,i,j,ii,jj,Time: INTEGER;
  Pole:array [1..500,1..500] of INTEGER; 
PROCEDURE ADDKol(ii,jj:INTEGER);
BEGIN
  IF  Pole[ii][jj]=0
  THEN
    Kol:=Kol+1;
END;
 BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  READLN(Fin,N,M);
  Kol:=0;
  FOR i:=1 TO M
  DO
    BEGIN
      READLN(Fin,ii,jj);
      ADDKol(ii,jj);
      Pole[ii][jj]:=1;
    END; 
  Time:=1;
  WRITELN(N*N);
  WRITELN(Kol);
  WHILE (Kol<N*N)
  DO  
    BEGIN
      FOR i:=1 TO N    
      DO
        BEGIN
          FOR j:=1 TO N 
          DO           
            BEGIN        
              IF  (Pole[i][j]=Time)
              THEN
                BEGIN
                 IF i>1
                 THEN             
                   BEGIN
                     ADDKol(i-1,j);
                     Pole[i-1][j]:=Time+1;
                   END;
                 IF j>1 
                 THEN             
                   BEGIN
                     ADDKol(i,j-1);
                     Pole[i][j-1]:=Time+1;                    
                   END;
                 IF i<N
                 THEN             
                   BEGIN
                     ADDKol(i+1,j);
                     Pole[i+1][j]:=Time+1;                    
                   END;
                 IF j<N 
                 THEN             
                   BEGIN
                     ADDKol(i,j+1);
                     Pole[i][j+1]:=Time+1;
                   END;
                END;   
            END; 
        END;
      Time:=Time+1;  
    END;
  WRITELN(FOut,Time-1);
END.
