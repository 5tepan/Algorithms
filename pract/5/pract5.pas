Program repair(input, output);
Var
  Fin,Fout: Text;
  N,M,b,i,x,y,kol,Flag: INTEGER;
  Nstr: STRING;
 // Flag: BOOLEAN;
  List: array [1..1000] of INTEGER ;
  BEGIN
  ASSIGN(Fin, "Input.txt");
  RESET(Fin);
  ASSIGN(FOut, "Output.txt");
  REWRITE(FOut);

  READLN(Fin,Nstr);
  i:=Pos(' ',Nstr);
  VAL(Copy(Nstr,1,i-1),N,b);
  VAL(Copy(Nstr,i+1,Length(Nstr)),M,b);
  FOR i:=1 TO 1000 
  DO
     List[i]:=0;
  WHILE NOT EOLN(Fin)
  DO
    BEGIN
      READLN(Fin,Nstr);
      i:=Pos(' ',Nstr);
      VAL(Copy(Nstr,1,i-1),x,b);
      VAL(Copy(Nstr,i+1,Length(Nstr)),y,b);
//      WRITELN(x,y);
      FOR i:=x TO y
      DO 
        List[i]:=List[i]+1;
    END;
  kol :=0;
  Flag:=0;
  FOR i:=1 TO 1000 
  DO
    BEGIN    
      IF (List[i] < M)  AND (Flag>1)
      THEN
        kol := kol +1;
      IF (List[i] >= M)
      THEN
        Flag :=Flag+1
      ELSE
        Flag :=0;        
    END;
        
  WRITE(FOut,kol);
    
END.    
