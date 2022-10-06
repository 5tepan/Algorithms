{ 
1.������� ���� ������������� �����. �� ������ ������ �����
�������� � ����� �����������. �������� ����� ���� �����. ���� ��
������� �������� ��������. ��������� ������� ������ ���� ������
�� ������������� ����� �� ������� � ������ ������.  �����������
����������� ����������� ����� (12).
2.����� ������ ��-21
3. Dev+GNU Pascal 1.9.4.13
4.INPUT - �������� ������������� 
  OUTPUT - �������� �������������
5.INPUT - ������� ��������� � ��������� �������
  OUTPUT - ������ ���� ������ �� ������������� ����� �� ������� � ������ ������
}





PROGRAM Graf(INPUT, OUTPUT);
CONST
  MaxN = 50;
  Inf = 1000000000; //"�������������"
 
TYPE
  Matrix = ARRAY[1..MaxN,1..MaxN] of LONGINT; //��� ������� ���������. M[i,j] = true, ���� ���������� �����, ������ �� ������� i � j
  MatrixUse = ARRAY[1..MaxN,1..MaxN] of BOOLEAN; // ���������/ ���������� �����
  Pred = ARRAY[1..MaxN] of INTEGER; 
  TypeName = ARRAY[1..MaxN] of STRING; 
VAR
  A: Matrix;
  AUse: MatrixUse;
  Name: TypeName;
  N, S0, S1: INTEGER;
  Fin, Fout: TEXT;
  NameFile: STRING;
  Ch: CHAR;
  PMin, PMin_, PMin2,P_: Pred; 
  Way, MinWay, MinWay_, MinLine: LONGINT;
  i, j, z, z1 : LONGINT;
PROCEDURE MakeGraf(VAR A : Matrix; VAR NMax : INTEGER);  
VAR
  S: STRING;
  Ch: CHAR;
  I, J, Way, Code: INTEGER;
  FName: BOOLEAN;
BEGIN
  I :=0;
  J :=0; 
  NMax :=0; 
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      S := "";
      WHILE NOT EOLN(Fin)
      DO
      BEGIN
        Read(Fin, Ch);
        IF EOLN(Fin)
        THEN 
          BEGIN
            S :=S + Ch;
            Ch := ' ';
          END;  
        IF Ch<>' '
        THEN
          S :=S + Ch
        ELSE
          BEGIN
            IF I = 0
            THEN 
              VAL(S,I,Code)
            ELSE
              IF J = 0 
              THEN  
                VAL(S,J,Code)
              ELSE
                BEGIN
                  VAL(S,Way,Code);
                  A[I,J] := Way;
                  A[J,I] := Way;
                  NMax := MAX(NMax, I);
                  NMax := MAX(NMax, J); 
                  I :=0;
                  J :=0; 
                END;  
            S := "";  
          END;
      END;  
      ReadLn(Fin);
    END;       
  FOR i := 1 TO NMax  // �������� ���������� ����������� ���� ��� �� ���������
  DO
    BEGIN
      FOR j := 1 TO NMax
      DO
        BEGIN
          IF (a[i,j] = 0) AND (i <> j)
          THEN
            a[i,j] := Inf; //�������, ������� �� ������� ������, ����� ��������� "��������������" ����� ����������� �� ��� ����
          AUse[i,j] :=TRUE;  
        END;
    END;    
END;
PROCEDURE MakeGraf_(VAR A : Matrix; VAR NMax : INTEGER);  
VAR
  S: STRING;
  Ch: CHAR;
  I, J, Way, Code: INTEGER;
  FName: BOOLEAN;
BEGIN
  I :=0;
  J :=0; 
  NMax :=0; 
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      J :=1;
      I := I + 1;
      S := "";
      FName := FALSE;
      WHILE NOT EOLN(Fin)
      DO
      BEGIN
        Read(Fin, Ch);
        IF EOLN(Fin)
        THEN 
          BEGIN
            S :=S + Ch;
            Ch := ' ';
          END;  
        IF Ch<>' '
        THEN
          S :=S + Ch
        ELSE
          BEGIN
            IF FName = FALSE
            THEN 
              Name[I] := S  
            ELSE
              BEGIN
                VAL(S,Way,Code);
                A[I,J] := Way;
                J := J + 1;
              END;  
            S := "";  
            FName := TRUE;
          END;
      END;     
      NMax := MAX(NMax, J-1);
      ReadLn(Fin);
    END;       
  NMax := MAX(NMax, I);
  FOR i := 1 TO NMax  // �������� ���������� ����������� ���� ��� �� ���������
  DO
    BEGIN
      FOR j := 1 TO NMax
      DO
        BEGIN
          IF (a[i,j] = 0) AND (i <> j)
          THEN
            a[i,j] := Inf; //�������, ������� �� ������� ������, ����� ��������� "��������������" ����� ����������� �� ��� ����
          AUse[i,j] :=TRUE;  
        END;
    END;    
END;

PROCEDURE Print(VAR A : Matrix; NMax : INTEGER);  
VAR
  I,J: INTEGER;
BEGIN
  FOR I := 1 TO NMax
  DO
    WRITE(Fout, ' ',I);
  WRITELN(Fout);    
  FOR I := 1 TO NMax 
  DO
    BEGiN
      FOR J := 1 TO NMax 
      DO
        WRITE(Fout, ' ',A[I,J]);
    WRITELN(Fout);  
   END;   
END;  

PROCEDURE PrintWay(p : Pred; s1 : INTEGER; Way: LONGINT; VAR MinLine: LONGINT; FlagCycle, FlagPrint : BOOLEAN);
VAR
  i, j, v, min, z : longint;
  st, c : string;
BEGIN
  st := ''; //�������� ������������� � ������ ������ (�� �������� �� ���� �������� ����������� ���� �� s �� s1, �� ������ � �������� �������)
  z := p[s1]; //���� ���� �������� �������
  IF FlagCycle AND (MinLine = A[z,s1])  //����������� �����  � �����
  THEN  
    BEGIN
      STR(z,c);
      st := c + '->' + st; //������� ����
      STR(s1,c);
      st := c + '->' + st; 
      FlagCycle := FALSE;
    END;
  IF MinLine= 0  //����������� ����� 
  THEN
    MinLine :=A[z,s1];
  WHILE z <> 0
  DO
    BEGIN
      STR(z,c);
      st := c + '->' + st; //������� � �������
      IF FlagCycle AND (p[z] > 0) AND (MinLine = A[z,p[z]])  //����������� �����  � �����
      THEN  
        BEGIN         
          STR(p[z],c);
          st := c + '->' + st; 
          STR(z,c);
          st := c + '->' + st; //������� ����
          FlagCycle := FALSE;
        END;
      IF (p[z] > 0) AND (MinLine > A[z,p[z]]) //����������� �����
      THEN
        MinLine := A[z,p[z]];
      z := p[z]; //��������� � ��������� �������

    END;
    STR(s1,c);
    st := st + c;
    IF FlagPrint
    THEN
      WRITELN(Fout,' ',st, ' = ',Way);
END; 

PROCEDURE Deikstr(s, s1 : INTEGER; VAR  P : Pred; VAR Way: LONGINT); //s, s1 - ������� ������� (���������� ����� ���� �� s �� s1)
VAR
  i, j, v, min, z : LONGINT;
  st, c : STRING;
  Visited : ARRAY[1..MaxN] OF BOOLEAN; //������ ������������ ������
  D : ARRAY[1..MaxN] of LONGINT; //������ ���������� ����������
BEGIN
  FOR i := 1 TO N 
  DO
    BEGIN
        p[i] := s;
        Visited[i] := FALSE;
    END;
  visited[s] := TRUE; //������� S ��������
  FOR i := 1 TO N 
  DO 
    IF AUse[s, i]  //����������� ������ ����������
    THEN
      D[i] := A[s, i]
    ELSE
      D[i] := INF;
  D[s] := 0;
  p[s] := 0; 
  FOR i := 1 TO N-1
  DO //�� ������ ���� ������� ����������� ������� � �������� ��� ��������
    BEGIN
      min := Inf;
      FOR j := 1 TO N
      DO
        IF (NOT Visited[j]) AND (D[j] < min)
        THEN
        BEGIN
          min := D[j]; //����������� ����������
          v := j; //��������� �������
        END;
        FOR j := 1 TO N
        DO
          IF (D[j] > D[v] + A[v, j]) AND (D[v] < INF) AND (A[v, j] < INF)  AND AUse[v, j]
          THEN
            BEGIN
              D[j] := D[v] + A[v, j]; //�������� �������� �������. ���� � ��� ���������� ������, ��� ����� ���������� �� ������� ������� � ����� �����, �� ��������� ���.
              p[j] := v;
            END;
        s := v; //����� ������� �������
        Visited[v] := TRUE; //� ��� ���������� ����������
    END;
    Way :=D[s1];
END;
 
BEGIN
 WRITE('������� �������� �������� �����: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fin, NameFile);
  {$I-} RESET(Fin); {$I+}
  IF IORESULT <> 0
  THEN
    BEGIN
      WRITELN('���� ', NameFile, ' �� ������!');
      WRITELN('������ ��������� ���������. ������� ENTER.');
      READ(Ch);
      EXIT;
    END;
  MakeGraf(A, N);
  
  WRITE('������� �������� ��������� �����: ');
  READLN(NameFile);
  NameFile := NameFile + '.txt';
  ASSIGN(Fout, NameFile);
  REWRITE(Fout); 
  S0 :=1;  // ����� �������  
  FOR S1:=1 TO N
  DO
    IF S1<> S0 
    THEN
      BEGIN
        Deikstr(S0, S1, PMin,MinWay);  //����������� ����
        MinLine :=0;
        PrintWay(PMin, s1, MinWay, MinLine, FALSE, FALSE);
        MinWay_ := INF;
        z1 := s1;
        z  := PMin[s1]; //���� ���� �������� �������
        WHILE z <> 0
        DO  //������� ���� �� �����
          BEGIN
            AUse[z,z1] := FALSE;
            Deikstr(S0, S1, P_, Way);
            AUse[z,z1] := TRUE;        
            IF MinWay_ > Way// ����������
            THEN
              BEGIN
                MinWay_ := Way;
                FOR j := 1 to N
                DO
                  PMin_[j] := P_[j];
              END;    
            z1 := z;    //��������� � ��������� �������
            z := PMin[z]; 
      END;            
      IF MinWay_ <= MinWay+ MinLine*2
      THEN // ����� ������ �� ������������� ����
        PrintWay(PMin_, s1, MinWay_, MinLine, FALSE, TRUE)
      ELSE
        BEGIN
   //       WRITELN(Fout,' ��� ������� ������������ ��������(���� ���� ������������ �����)'); //2 ����� ��� ��������?
          PrintWay(PMin, s1, MinWay+ MinLine*2, MinLine, TRUE, TRUE)
        END;  
      END;
  CLOSE(Fin);
  CLOSE(Fout);
END.   
