Program Grad(input, output);
var
  Fin: TEXT;
  NameFile: STRING;
  Ch: CHAR;
  Mat: ARRAY   [1..200,1..200] OF CHAR;
  N, M, b, i, j, NOM, NOM_, NOM_max: INTEGER;
  Nstr: STRING;
  
BEGIN
  Nstr:='';
  M:=0;
  N:=0;
  WHILE NOT EOLN(Fin)
  DO
    BEGIN
      READ(Fin, Ch);
      IF Ch = ' '
      THEN
        BEGIN
          VAL(Nstr, M, b);
          Nstr:='';
        END
        ELSE
          Nstr:=Nstr+Ch;
    END;
  VAL(Nstr, N, b);
  i:=1;
  j:=1;
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      WHILE NOT EOLN(Fin)
        DO
          BEGIN
            READ(Fin, Ch);
            Mat[i, j] := Ch;
            j:=j+1;
          END;
        READLN(Fin);
        i:=i+1;
     END;
     
  NOM:=1;
  FOR i:=1 to M
  DO
    BEGIN
      FOR j:=1 to M
        DO  
          BEGIN
            IF Mat[i, j] <> '.'
            THEN
              BEGIN
                VAL(Mat[i,j], NOM_, b);
                VAL(Mat[Max(i-1,1)], NOM_max, b);
                NOM_:=max(NOM_,NOM_max);
                VAL(Mat[i,Max(j-1,1)], NOM_max, b);
                NOM_:=max(NOM_,NOM_max);
                VAL(Mat[Min((i+1,M)] ,j], NOM_max, b);
                NOM_:=max(NOM_,NOM_max);
                VAL(Mat[(i,Min(j+1,N))], NOM_max, b);
                NOM_:=max(NOM_,NOM_max);
                IF NOM_=0
                THEN
                  BEGIN
                    Mat[i,j]:=str(NOM);
                    NOM:=NOM+1;
                  END;
              END;
          END;
    END;
END.  
