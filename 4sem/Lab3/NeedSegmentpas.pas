  {
1. 10.3. ??????? (6)
???? N ???????? ??????? ?????? L1, L2, ..., LN ???????????. ????????? ? ??????? ?????????? ???????? ?? ??? K ?????? ???????? ??? ????? ??????? ?????, ???????????? ????? ?????? ???????????. ???? ?????? ???????? K ???????? ?????? ???? 1 ??, ??????? 0.
???????????: 1 = N = 10 000, 1 = K = 10 000, 100 = Li = 10 000 000, ??? ????? ?????, ????? 1 ?.
2.����� ������ ��-21
3. Dev+GNU Pascal 1.9.4.13
   ��������� - 1251
4.INPUT - input.txt
  OUTPUT - output.txt
5.INPUT - ???? ?? ????? INPUT.TXT. ? ?????? ?????? ????????? ????? ?????? ????? N ? ?. ? ????????? N ??????? - L1, L2, ..., LN, ?? ?????? ????? ? ??????.
  OUTPUT - ????? ? ???? INPUT.TXT. ??????? ???? ????? - ?????????? ????? ????????.

}






Program NeedSegmentpas;
CONST 
  MaxKol=10000;
Type
  ArraySegment= array [1..MaxKol] of LONGINT;
Var
  Fin,Fout: Text;
  NameFile: STRING;
  ArrayOfSegments: ArraySegment; 
  BestSegment,Low,High,Mid: LONGINT;
  KolSegments,NeedSegments,Segments,i: INTEGER; 

BEGIN
  ASSIGN(Fin, 'input.txt');
  RESET(Fin);
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  READLN(Fin,KolSegments,NeedSegments);

  IF  (KolSegments<1) OR (KolSegments>10000)
  THEN
    BEGIN  
      WRITELN(FOut,"NOT 1 < KolSegments < 10000");   
      EXIT;
    END;
  IF  (NeedSegments<1) OR (NeedSegments>10000)
  THEN
    BEGIN  
      WRITELN(FOut,"NOT 1 < NeedSegments < 10000");   
      EXIT;
    END;

  High:=0;       
  FOR i:=1 TO KolSegments             
  DO
    BEGIN
      READLN(Fin,ArrayOfSegments[i]);
      High:=High+ArrayOfSegments[i];
    END;
    
  BestSegment:=0;
  Low:=0;
  High:=(High div NeedSegments)+1;
  WHILE (High-Low>1)
  DO
    BEGIN
      Segments :=0;
      Mid:=(Low+High) div 2;
      FOR i:=1 TO KolSegments 
      DO             
        BEGIN
          Segments:=Segments+(ArrayOfSegments[i] div Mid);
          IF  Segments>=NeedSegments
          THEN
            BREAK;
        END;
      IF  Segments<NeedSegments
      THEN
        High := Mid      
      ELSE
        Low := Mid;
      IF  (Segments>=NeedSegments) AND (BestSegment< Mid)
      THEN
        BestSegment := Mid;
    END;
  WRITELN(FOut,BestSegment);   
END.
