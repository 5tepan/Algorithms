Program Inspection;
Type
  Array100100= array [1..100,0..100,0..1] of INTEGER;
  Array100= array [1..100] of INTEGER;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  Spisok: Array100100; 
  SpisokBest: Array100;  
  KolVrach,KolSprav,i,j,Best: INTEGER; 
PROCEDURE Sort(i: INTEGER);
VAR j,jj: INTEGER;
BEGIN
     Best:=0;
     FOR j:=1 to 100 
     DO
       BEGIN
         Spisok[i,0,1]:=1;
         IF (Spisok[i,j,0] > 0) AND (Spisok[i,j,1]<>1)      
         THEN
           Best:=i;
           
           Spisok[i,0,1]:=0;
         WRITE(Best);
       END;
     IF Spisok[i,0,1]=0 
     THEN 
        FOR j:=1 to 100 
        DO
         IF (SpisokBest[j]=0)      
         THEN
           BEGIN
             SpisokBest[j]:=i; 
             BREAK;
           END;  
     FOR j:=1 to 100 
     DO
       BEGIN
         IF (Spisok[i,j,0] > 0) AND (Spisok[i,j,1]=0)
         THEN
           BEGIN
             Spisok[i,j,1]:= Spisok[i,j,1]+1;
             Sort(j);
           END;
       END;    
END;
 BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  //1  
  READLN(Fin,KolSprav);
  //2 
  FOR i:=1  TO KolSprav
  DO
    BEGIN
      READ(Fin,KolVrach); 
      FOR j:=1  TO KolVrach
      DO
        READ(Fin,Spisok[i,j,0]);
      READLN(Fin);
    END;  
   FOR i:=1 to KolVrach 
   DO
    Sort(i); 
  FOR i:=1  TO 100
  DO
   IF (SpisokBest[j]<>0)      
   THEN
      WRITELN(SpisokBest[j]);   
END.
