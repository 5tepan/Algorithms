Program ClassList(INPUT, OUTPUT);
Type
  ukaz=^uzel;
  uzel=record
         name: string;     {��� �������}
         left,right: ukaz; {�������}
         fath: ukaz;       {���� � �������� ������}
         urov: integer;    {������� ��������� ������, ������� � 0}
       end;
Var
  t,kon,root,p: ukaz;
  i,k,m,Len, NumFac: integer;
  S,R, NameFac: string;
  Fin, Fout: text;
  FTree, BTree: ukaz;
  
PROCEDURE FSerch(t, r: ukaz);
Var
  j: integer;
  Father: ukaz;
Begin
  if t<>nil 
  then
    Begin
      IF r^.name = t^.name 
      THEN
        BEGIN
          Father := t^.fath;
          WHILE Father^.urov > 1
          DO
            Father := Father^.fath;
          IF POS('- ��������� ' + Father^.name + '.', NameFac) = 0
          THEN
            NumFac := NumFac + 1;
          IF NameFac <> ''
          THEN
            NameFac := NameFac + char(10);
          NameFac := NameFac + ' ��������� ' + r^.fath^.name + ' ������ ' + r^.fath^.fath^.name + ' ����� ���������� ' + r^.name + ' - ��������� ' + Father^.name + '.';  
        END;       
      FSerch(t^.left, r);
      FSerch(t^.right, r);
    end
End;
  
Procedure BSerch(t: ukaz);
Var
  j: integer;
  Str: string;
Begin
  Str := '';
  if t<>nil 
  then
    Begin
      IF t^.urov = 2
      THEN
        BEGIN  
          NameFac := '';
          NumFac := 0;
        END;
      IF t^.urov = 3
      THEN
        FSerch(FTree, t);   
      BSerch(t^.left);
      IF (t^.urov = 2) AND (NumFac > 1)
      THEN
        WRITE(Fout, NameFac);
      BSerch(t^.right);
    end
End;

Procedure PechPr(t:ukaz);
{������ � ���� � ������� ������ ����}
Var
  j: integer;
  St: string;   {��� ������������ ������ ������}
Begin
  if t<>nil then
    Begin
      St:=t^.name;
      p:=t;
      For j:=1 to t^.urov do  {������ � ����������� �� ������}
        begin
          p:=p^.fath;
          St:='+'+St;
        end;
      WriteLn(Fout,St);
      PechPr(t^.left);
      PechPr(t^.right);
    end
End;
PROCEDURE MakeTree(VAR root: ukaz);
BEGIN
  New(root);
  ReadLn(Fin,S);
  root^.name:=S;
  root^.urov:=0;
  root^.fath:=nil;  {����}
  m:=0;             {������� �������}
  t:=root;          {���������� ������� ��� ��������� � �����}
  While not Eof(Fin) do
    begin
      ReadLn(Fin,S);
      k:=0;
      Len:=Length(S);
      While S[k+1]='+' do k:=k+1;   {k-������� �������, ������� � 0}
      R:=Copy(S,k+1,Len-k);         {��� �������}
      New(kon);
      kon^.name:=R;
      kon^.left:=nil;
      kon^.right:=nil;
      kon^.urov:=k;
      if k>m then               {������� �� ��������� �������}
        begin
          t^.left:=kon;
          kon^.fath:=t;
        end
      else
        if k=m then             {��� �� �������}
          begin
            t^.right:=kon;
            kon^.fath:=t^.fath; {���� ��� ��, ��� � �����}
          end
        else                    {������ �� ������ �� m-k �������}
          begin
            p:=t;
            For i:=1 to m-k do
              p:=p^.fath;
            {p-���������� ������� ���� �� ������}
            kon^.fath:=p^.fath; {���� � �������� ������ ��� ��, ��� � �����}
            p^.right:=kon;
          end;
      m:=k;       {��������� ������� �������}
      t:=kon;     {��� ������ �� ��������� ��������}
    end;          {����� While}
END;
Begin
  Assign(Fin,'input.txt');
  Reset(Fin);
  FTree := NIL;
  MakeTree(FTree);
  Close(Fin);
  Assign(Fin,'input1.txt');
  Reset(Fin);
  BTree := NIL;
  MakeTree(BTree);
  Close(Fin);
  Assign(Fout,'output.txt');
  Rewrite(Fout);
  BSerch(BTree);
  PechPr(FTree);  {������ ������ � ����}
  PechPr(BTree);
  Close(Fout);
End.

