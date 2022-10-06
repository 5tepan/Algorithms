Program ClassList(INPUT, OUTPUT);
Type
  ukaz=^uzel;
  uzel=record
         name: string;     {имя вершины}
         left,right: ukaz; {сыновья}
         fath: ukaz;       {отец в исходном дереве}
         urov: integer;    {уровень исходного дерева, начиная с 0}
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
          IF POS('- факультет ' + Father^.name + '.', NameFac) = 0
          THEN
            NumFac := NumFac + 1;
          IF NameFac <> ''
          THEN
            NameFac := NameFac + char(10);
          NameFac := NameFac + ' аудитория ' + r^.fath^.name + ' корпус ' + r^.fath^.fath^.name + ' номер компьютера ' + r^.name + ' - факультет ' + Father^.name + '.';  
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
{выдача в файл в порядке сверху вниз}
Var
  j: integer;
  St: string;   {для формирования строки выдачи}
Begin
  if t<>nil then
    Begin
      St:=t^.name;
      p:=t;
      For j:=1 to t^.urov do  {отступ в зависимости от уровня}
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
  root^.fath:=nil;  {отец}
  m:=0;             {уровень вершины}
  t:=root;          {предыдущая вершина для следующей в файле}
  While not Eof(Fin) do
    begin
      ReadLn(Fin,S);
      k:=0;
      Len:=Length(S);
      While S[k+1]='+' do k:=k+1;   {k-уровень вершины, начиная с 0}
      R:=Copy(S,k+1,Len-k);         {имя вершины}
      New(kon);
      kon^.name:=R;
      kon^.left:=nil;
      kon^.right:=nil;
      kon^.urov:=k;
      if k>m then               {переход на следующий уровень}
        begin
          t^.left:=kon;
          kon^.fath:=t;
        end
      else
        if k=m then             {тот же уровень}
          begin
            t^.right:=kon;
            kon^.fath:=t^.fath; {отец тот же, что у брата}
          end
        else                    {подъем по дереву на m-k уровней}
          begin
            p:=t;
            For i:=1 to m-k do
              p:=p^.fath;
            {p-предыдущая вершина того же уровня}
            kon^.fath:=p^.fath; {отец в исходном дереве тот же, что у брата}
            p^.right:=kon;
          end;
      m:=k;       {запомнили текущий уровень}
      t:=kon;     {для работы со следующей вершиной}
    end;          {конец While}
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
  PechPr(FTree);  {выдача дерева в файл}
  PechPr(BTree);
  Close(Fout);
End.

