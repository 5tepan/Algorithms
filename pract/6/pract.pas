Program pract6(input, output);
Var
  Fin,Fout: Text;
  i,ii,b,x1,y1,x2,y2,x3,y3,kol,kol_lev,kol_90,x1x2,x2x3,y1y2,y2y3,tgx,tgy: INTEGER;
  Nstr: STRING;
  List: array [1..1000] of INTEGER ;
BEGIN
  ASSIGN(Fin, "Input.txt");
  RESET(Fin);
  ASSIGN(FOut, "Output.txt");
  REWRITE(FOut);
  READLN(Fin,Nstr);
  VAL(Nstr,kol,b);
  IF kol<=0
  THEN
    BEGIN
      WRITELN(FOut,0," ",0);
    END;
  READLN(Fin,Nstr);
  i:=Pos(' ',Nstr);
  VAL(Copy(Nstr,1,i-1),x1,b);
  VAL(Copy(Nstr,i+1,Length(Nstr)),y1,b);
  READLN(Fin,Nstr);
  i:=Pos(' ',Nstr);
  VAL(Copy(Nstr,1,i-1),x2,b);
  VAL(Copy(Nstr,i+1,Length(Nstr)),y2,b);
  kol_lev:=0;
  kol_90:=0;
  FOR ii:=3 TO kol
  DO
    BEGIN
      READLN(Fin,Nstr);
      i:=Pos(' ',Nstr);
      VAL(Copy(Nstr,1,i-1),x2,b);
      VAL(Copy(Nstr,i+1,Length(Nstr)),y2,b);
      //отрезки
      x1x2:=x2-x1;
      y1y2:=y2-y1;
      x2x3:=x3-x2;
      y2y3:=y3-y2;
      //тангенс
      tgx := x1x2*y2y3 - x2x3*y1y2;
      tgy := x1x2*x2x3 - y1y2*y2y3;      
      IF ARCTAN(tgx / tgy) > 0 //Поворот налево
      THEN
        kol_lev:=kol_lev+1;
      WRITELN(ARCTAN(tgy / tgx));
      IF Round(ARCTAN(tgy / tgx)*10)/10 = 1 //90
      THEN
        kol_90:=kol_90+1;
      x1:=x2;
      y1:=y2;
      x2:=x3;
      y2:=y3;
    END;    
  WRITELN(FOut,kol_lev," ",kol_90);
END.    
