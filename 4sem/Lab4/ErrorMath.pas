{
1. 7.7. ?????? 2(7)
?????????????????? ??????? ?????? ???????? ??????????, ???? ????? ???????? ? ??? ????? ? ????? ?????????????? ???????? ???, ??? ?????????? ?????????????? ????????? ?????? ??????????. ????????, ????????? ?????????????????? (())() ???????? ??????????, ? (())) ? ())(() ?????? ?? ????????. 
??????? ???? ?? ??????? ?????? ???????????. ?????????????? ? ??????????? ?????????? ???????????????????? ?? ??????? ??????, ?? ??? ?? ???????? ?????????? ?? ? ????????????, ?????? ?????? ?????? ??????. ???? ??????? ??? ????? ???????? ?????? ???????? ????? 2N (1 = N = 105), ???????????? ?????????? ????????? ??????????????????, ????? ?????????? ????? ????????? ???????? ???????? ????? ?? 1 ?? 2N ? 1, ????? ?????????????????? ?????????? ????????????. ????????? ????????? ???????????? ??????????? ???????? ? ?????? ?? ??????? ? ?????????? ???????. ???????? ????.
2.????? ?????? ??-21
3. Dev+GNU Pascal 1.9.4.13
   ????????? - 1251
4.INPUT - input.txt
  OUTPUT - output.txt
5.INPUT - ???? ?? ????? INPUT.TXT. ? ?????? ?????? ?????? ???????? N. ?? ?????? ?????? ????????? ?????????? ????????? ?????????????????? ????? 2N.
  OUTPUT - ????? ? ???? OUTPUT.TXT. ??????? ???????????? ????????: ?????????? ????????? ?????????? ??????????????.

}





Program ErrorMath;
CONST 
  MaxKol=105;
Type
  ArrayWord= array [1..MaxKol*2] of INTEGER;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  Ch: CHAR;
  i,j,Kol,KolError: INTEGER; 
  Words:ArrayWord;
FUNCTION Error(i,j: INTEGER): BOOLEAN;
VAR
  ii,Sum: INTEGER; 
BEGIN
  Sum:=0;
  Error:=TRUE;  
  FOR ii:=i TO j
  DO
    Sum:=Sum+Words[ii];
  IF Sum=0
  THEN
      Error:=FALSE;  
  
END;
BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  READLN(Fin,Kol);
  KolError:=0;
  FOR i:=1 TO Kol*2
  DO
    BEGIN
      READ(Fin,Ch);
      IF  Ch="(" 
      THEN
        Words[i]:=1
      ELSE  
        Words[i]:=-1;      
    END;  
  FOR i:=1 TO Kol*2
  DO
    FOR j:=i TO Kol*2  
    DO
    IF  Error(i,j)
    THEN
      KolError:=KolError+1;
  WRITELN(FOut,KolError);         
END.  
