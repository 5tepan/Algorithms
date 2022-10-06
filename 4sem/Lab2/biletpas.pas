Var
  i,kol,Rezalt: INTEGER;
  str,strmax: STRING;
Procedure Add(Var str:STRING);
VAR
  i,ii: INTEGER;
BEGIN  
  FOR i:=kol DOWNTO 0
  DO
    IF str[i]<>'9'
    THEN
      BEGIN
        str[i]:=CHR(ORD(str[i])+1);
        BREAK;
      END
    ELSE
      FOR ii:=i TO kol
      DO
        str[ii]:="0";
END;
Function Correct(str:STRING): BOOLEAN;
VAR
  i,ORDstr,sum1,sum2,k,d: INTEGER; 
BEGIN  
  Correct:=TRUE;
  ORDstr:= ORD(str[1]);
  VAL(str[1],sum1,d);
  sum2:=0;
  
  FOR i:=2 TO kol
  DO
    BEGIN
      IF not (ORD(str[i]) in [ORDstr,ORDstr+1,ORDstr-1])
      THEN        
        BEGIN
          Correct:=FALSE;
          BREAK;
      END;
      VAL(str[i],k,d);
      IF i<=kol/2
      THEN
        sum1:=sum1+ k
      ELSE
        sum2:=sum2+ k;
      ORDstr:= ORD(str[i]);  
    END;
    IF  sum1<>sum2
    THEN
      Correct:=FALSE;
    
END;

BEGIN
  WRITE("Введите количество знаков: ");
  READLN(kol);

  IF (kol<=0) OR (kol>30)
  THEN
    BEGIN
      WRITELN("Не корректный ввод.");
      EXIT;
    END;     
  kol:=kol*2;
  str:="";
  strmax:="";
  Rezalt:=1; // сразу посчитаем 99  
  FOR i:=1 TO kol
  DO 
    BEGIN
      str:=str+"0";  
      strmax:=strmax+"9";        
    END;
  WHILE str <> strmax
  DO
    BEGIN
      IF Correct(str)
      THEN
        Rezalt:=Rezalt+1;
      Add(str);
    END;
  WRITELN(Rezalt);  
END.         
  
