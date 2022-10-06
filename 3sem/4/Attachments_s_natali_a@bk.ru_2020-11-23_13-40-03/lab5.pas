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

              

PROGRAM TheSecondMinPath(INPUT, OUTPUT);
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
  PMin, PMin2,P_: Pred; 
  Way, MinWay: LONGINT;
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
            S := S + Ch;
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
    WRITE(Fout, ' ',Name[I]);
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

PROCEDURE PrintWay(p : Pred; s1 : INTEGER; Way: LONGINT);
VAR
  i, j, v, min, z : longint;
  st, c : string;
BEGIN
  st := ''; //�������� ������������� � ������ ������ (�� �������� �� ���� �������� ����������� ���� �� s �� s1, �� ������ � �������� �������)
  z := p[s1]; //���� ���� �������� �������
  WHILE z <> 0
  DO
    BEGIN
      st := Name[z] + '->' + st; //������� � �������
      z := p[z]; //��������� � ��������� �������
    END;
    st := st + Name[s1];
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
end;
 
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
  //Print(A, N);
  
  S0 := 1;
  WHILE S0 <= N
  DO
    BEGIN
      WRITELN('������� ����� ������� ��� ������� ������ ���� ��� ������� ����� ������� ������ ', N, ' ��� ����, ����� ����� �� ���������');  
      READLN(S0);
      IF S0 > N
      THEN                       
        EXIT;
  //S0 :=1;  // ����� �������  
  FOR S1:=1 TO N
  DO
    IF S1<> S0 
    THEN
      BEGIN
        Deikstr(S0, S1, PMin,MinWay);  //����������� ����
        PrintWay(PMin, s1, MinWay);

        MinWay := INF;
        z1 := s1;
        z  := PMin[s1]; //���� ���� �������� �������
        WHILE z <> 0
        DO  //������� ���� �� �����
          BEGIN
            AUse[z,z1] := FALSE;
            Deikstr(S0, S1, P_, Way);
            AUse[z,z1] := TRUE;        
            IF MinWay > Way// ����������
            THEN
              BEGIN
                MinWay := Way;
                FOR j := 1 to N
                DO
                  PMin[j] := P_[j];
              END;    
            z1 := z;    //��������� � ��������� �������
            z := PMin[z]; 
      END;            
      IF MinWay < INF
      THEN // ����� ������ �� ������������� ����
        PrintWay(p_, s1, MinWay)
      ELSE
        WRITELN(Fout,' ��� ������� ������������ ��������'); //2 ����� ��� ��������?
      END;
    END;  
  CLOSE(Fin);
  CLOSE(Fout); 
END.   
