{ 
1.? ????????? ???????,  ??????????? ?????? ??? ??????????
??????????     ???????,    ???????    ????????????    ???????.
?????????????? ??????? ?? ????  ???????.  ???  ???????  ??????
?????   ??????   ??????????   ?  ???????  ?  ??????????  ?????
?????????? ? ???????. ????? ?????????? ?????? ????? ??????????
?????  ?  ?????  ???????.  ???  ??????  ??? ??????-???? ??????
???????? ?????????? ????? ?????????? ? ???????, ?? ???????? ??
(????  ????  ?  ???? ?????? ??????? ????????) ? ???????????? ?
?????????. ??????? ???????? ?????????? ??????? ?? ????????(9)..
2.����� ������ ��-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - �������� ������������� 
  OUTPUT - �������� �������������
5.INPUT - ������ �������
  OUTPUT - �������� ����������
}




PROGRAM ListView;
CONST
  MaxAgent = 100;
TYPE
  Agent = RECORD
    Name: STRING;
    ObservationPeriod, TheTimeLimit: INTEGER
  END;
VAR
  Turn: ARRAY [1..MaxAgent] OF Agent;
  Bego, Endo: INTEGER;
  FIn, FOut: TEXT;
  NameFile: STRING;
  Ch: CHAR;
  N, I,  AllTime, ViewTime, MaxTime: INTEGER;  {ViewTime ���� ���������� �������� ������. 
                                                  AllTime ����� ����� ����������. N ���������� �������. MaxTime ������������ ������ ������� � �������}

//procedure Val(S: String; Var V; var Code : Integer);
//���:
//S - ���������� �� ��������� ����� (string). ������ ������������ ������������������ ��������, ����������� �������� ����� ����� - ��� �� ������, ������� �� ����� ���������������.
//V - ���������� ���� Real ��� Integer (����� ����� ����� ���������� ���������). � ���� ���������� ����� ����������� �����, ���� �������������� ������ �������
//Code - ���������� ���� Integer � �������, � ������� ��������� ������ ��� ��������������, ��� ����, ���� ������ �� ����. 

PROCEDURE ReadQueue();
VAR 
  AllStr, S1: STRING;
  Code: INTEGER;
  BEGIN
    WRITE('������� �������� �������� �����: ');
    READLN(NameFile);
    NameFile := NameFile + '.txt';
    ASSIGN(FIn, NameFile);
    {$I-} RESET(FIn); {$I+}
    IF IORESULT <> 0
    THEN
      BEGIN
        WRITELN('���� ', NameFile, ' �� ������!');
        WRITELN('������ ��������� ���������. ������� ENTER.');
        READ(Ch);
        EXIT;
      END;
    WRITE('������� �������� ��������� �����: ');
    READLN(NameFile);
    NameFile := NameFile + '.txt';
    ASSIGN(FOut, NameFile);
    REWRITE(FOut);
    N := 0;
    MaxTime := 0;
    WHILE NOT EOF(FIn) AND (N <= MaxAgent) 
    DO 
      BEGIN
        N := N + 1;
        WITH Turn[N]
        DO
          BEGIN
            READLN(FIn, AllStr);
            Name := COPY(AllStr, 1, POS(' ', AllStr) - 1); //��������� �� 1 ������� -���������� � Name           
            DELETE(AllStr, 1, POS(' ', AllStr)); //������� �� ����� ������ ��� 
            S1 := COPY(AllStr, 1, POS(' ', AllStr) - 1);
            VAL(S1, ObservationPeriod, Code); //��������� ��������� � ����� -���������� � ObservationPeriod           
            DELETE(AllStr, 1, POS(' ', AllStr)); //������� �� ����� ������ ObservationPeriod 
            VAL(AllStr, TheTimeLimit, Code); //���������� ��������� ��������� � ����� -���������� � TheTimeLimit           
            IF (ObservationPeriod > 0) 
            THEN
              MaxTime := MAX(MaxTime, TheTimeLimit); 
          END;
      END
  END;
  
 PROCEDURE CheckQueue(Time1, Time2: INTEGER);
 VAR
   I: INTEGER;
 BEGIN
   WHILE Time1 < Time2
   DO
     BEGIN
       FOR I := 1 TO N
       DO
         WITH Turn[I]
         DO
         IF Time1 = TheTimeLimit
         THEN
           WRITELN(FOUT, Time1, ': ', Name, '- ����� �� �������');
           Time1 := Time1 + 1;  
     END;          
  END; 
  BEGIN
    ReadQueue();
    AllTime := 0;
    WHILE AllTime < MaxTime
    DO
      FOR I := 1 TO N
      DO
        WITH Turn[I]
        DO
          BEGIN
            ViewTime := MIN(ObservationPeriod, TheTimeLimit - AllTime);
            ViewTime := MAX(ViewTime, 0);

            IF ViewTime > 0
            THEN
              BEGIN
                WRITELN(FOUT, AllTime, ': ', Name, '- ����� ����������');
                CheckQueue(AllTime, AllTime + ViewTime);
                WRITELN(FOUT, AllTime + ViewTime, ': ' ,Name , '- ������� ����������');
              END;  
            AllTime := AllTime + ViewTime;             
          END;
          CheckQueue(AllTime, AllTime + 1);          
  END.
