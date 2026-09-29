unit uvector;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;
const
  MAX_ELEM=1000;
type

    { TVector }

    TVector=class
      private
        elem:array[1..MAX_ELEM] of integer;
        dim:integer;
      public
        constructor crear();
        procedure setElem(pos,ele:integer);
        function getElem(pos:integer):integer;
        procedure setDim(dimen:integer);
        function getDim():integer;
        procedure addElem(ele:integer);
        procedure insElem(pos,ele:integer);
        procedure remElem(pos:integer);
        function busqBin(ele:integer):integer;
        function busqSec(x: integer): integer;
        procedure ord_inter();
        procedure ordBurbuja();
        procedure ordSeleccion();
        procedure ordInsercion();
        procedure ordQuickSort();
        procedure ordShell();
        procedure cargar(n, a, b: integer);
        function comoString(): string;
        procedure invertir();
        procedure rotarDerecha();
        procedure rotarIzquierda();
        procedure eliminarRep();
        procedure ordenarFrec();

      end;
implementation

{ TVector }

constructor TVector.crear();
var
  pos:integer;
begin
  pos:=1;
  while(pos<=MAX_ELEM)do
  begin
    elem[pos]:=0;
    pos:=pos+1;
  end;
  dim:=0;
end;

procedure TVector.setElem(pos, ele: integer);
begin
  if(pos>=1)and(pos<=dim)then
    elem[pos]:=ele
  else
    showMessage('TVector.setElem: Posicion fuera de rango... ');
end;

function TVector.getElem(pos: integer): integer;
begin
  if(pos>=1)and(pos<=dim)then
    result:=elem[pos]
  else
    result:=-999;
end;

procedure TVector.setDim(dimen: integer);
begin
  if(dimen>=1)and(dimen<=MAX_ELEM)then
    dim:=dimen
  else
    showMessage('TVector.setDim: Dimension fuera de rango... ');
end;

function TVector.getDim(): integer;
begin
  result:=dim;
end;

procedure TVector.addElem(ele: integer);
begin
  if(dim<MAX_ELEM)then
    begin
      dim:=dim+1;
      elem[dim]:=ele;
    end
  else
    showMessage('TVector.addElem: Almacenamiento lleno... ');
end;

procedure TVector.insElem(pos, ele: integer);
var
  d:integer;
begin
  if(dim<MAX_ELEM)then
    begin
      if(pos>=1)and(pos<=dim)then
        begin
          d:=dim;
          while(d>=pos)do
          begin
            elem[d+1]:=elem[d];
            d:=d-1;
          end;
          elem[pos]:=ele;
          dim:=dim+1;
        end
        else
          showMessage('TVector.insElem: Posicion fuera de rango...');
    end
    else
      showMessage('TVector.insElem: Almacenamiento lleno...');
end;

procedure TVector.remElem(pos: integer);
var
  d:integer;
begin
  if(pos>=1)and(pos<=dim)then
    begin
      d:=pos;
      while(d<dim)do
      begin
        elem[d]:=elem[d+1];
        d:=d+1;
      end;
      dim:=dim-1;
    end
    else
      showMessage('TVector.remElem: Posicion fuera de rango...');
end;

function TVector.busqBin(ele: integer): integer;
var
  ini,fin,medio:integer;
  sw:boolean;
begin
  ini:=1;
  fin:=dim;
  sw:=false;
  while(ini<=fin)and (not sw)do
    begin
      medio:=(fin+ini)div 2;
      if(elem[medio]=ele)then
        sw:=true
      else
        if(elem[medio]>ele)then
          fin:=medio-1
        else
          ini:=medio+1;
    end;
  if(sw)then
    result:=medio
  else
    result:=-1;
end;

procedure TVector.ord_inter();
var
  p,d,aux:integer;
begin
  for p:=1 to dim-1 do
    begin
      for d:=p+1 to dim do
        begin
          if(elem[d]<elem[p])then
            begin
              aux:=elem[d];
              elem[d]:=elem[p];
              elem[p]:=aux;
            end;
        end;
    end;
end;
procedure TVector.cargar(n, a, b: integer);
var
  i: integer;
begin
  Randomize;
  if (n >= 1) and (n <= MAX_ELEM) then
  begin
    dim := n;
    for i := 1 to dim do
      elem[i] := a + Random(b - a + 1);
  end
  else
    showMessage('TVector.cargar: Cantidad fuera de rango...');
end;
function TVector.comoString(): string;
var
  i: integer;
  s: string;
begin
  s := '[';
  for i := 1 to dim do
  begin
    s := s + IntToStr(elem[i]);
    if i < dim then
      s := s + ', ';
  end;
  s := s + ']';
  result := s;
end;
procedure TVector.invertir();
var
  i, aux: integer;
begin
  for i := 1 to (dim div 2) do
  begin
    aux := elem[i];
    elem[i] := elem[dim - i + 1];
    elem[dim - i + 1] := aux;
  end;
end;
procedure TVector.rotarDerecha();
var
  i, ultimo: integer;
begin
  if dim > 1 then
  begin
    ultimo := elem[dim];


    for i := dim downto 2 do
      elem[i] := elem[i - 1];

    elem[1] := ultimo;
  end;
end;


procedure TVector.rotarIzquierda();
var
  i, primero: integer;
begin
  if dim > 1 then
  begin
    primero := elem[1];

    for i := 1 to dim - 1 do
      elem[i] := elem[i + 1];

    elem[dim] := primero;
  end;
end;
function TVector.busqSec(x: integer): integer;
var
  i, pos: integer;
begin
  pos := -1;
  i := 1;

  while (i <= dim) and (pos = -1) do
  begin
    if elem[i] = x then
      pos := i;
    inc(i);
  end;

  result := pos;
end;
procedure TVector.ordBurbuja();
var
  i, j, aux: integer;
begin
  for i := 1 to dim - 1 do
  begin
    for j := 1 to dim - i do
    begin
      if elem[j] > elem[j + 1] then
      begin
        aux := elem[j];
        elem[j] := elem[j + 1];
        elem[j + 1] := aux;
      end;
    end;
  end;
end;

procedure TVector.ordSeleccion();
var
  i, j, minPos, aux: integer;
begin
  for i := 1 to dim - 1 do
  begin
    minPos := i;
    for j := i + 1 to dim do
    begin
      if elem[j] < elem[minPos] then
        minPos := j;
    end;
    if minPos <> i then
    begin
      aux := elem[i];
      elem[i] := elem[minPos];
      elem[minPos] := aux;
    end;
  end;
end;

procedure TVector.ordInsercion();
var
  i, j, clave: integer;
begin
  for i := 2 to dim do
  begin
    clave := elem[i];
    j := i - 1;
    while (j >= 1) and (elem[j] > clave) do
    begin
      elem[j + 1] := elem[j];
      dec(j);
    end;
    elem[j + 1] := clave;
  end;
end;

procedure TVector.ordQuickSort();
  procedure quick(izq, der: integer);
  var
    i, j, pivote, aux: integer;
  begin
    i := izq;
    j := der;
    pivote := elem[(izq + der) div 2];

    repeat
      while elem[i] < pivote do inc(i);
      while elem[j] > pivote do dec(j);

      if i <= j then
      begin
        aux := elem[i];
        elem[i] := elem[j];
        elem[j] := aux;
        inc(i);
        dec(j);
      end;
    until i > j;

    if izq < j then quick(izq, j);
    if i < der then quick(i, der);
  end;

begin
  // Llamada inicial al procedimiento interno
  if dim > 1 then
    quick(1, dim);
end;
procedure TVector.ordShell();
var
  i, j, salto, aux: integer;
begin
  salto := dim div 2;

  while salto > 0 do
  begin
    for i := salto + 1 to dim do
    begin
      aux := elem[i];
      j := i;

      while (j > salto) and (elem[j - salto] > aux) do
      begin
        elem[j] := elem[j - salto];
        j := j - salto;
      end;

      elem[j] := aux;
    end;

    salto := salto div 2; // Reducimos el salto a la mitad en cada ciclo
  end;
end;
procedure TVector.eliminarRep();
var
  i, j, k: integer;
begin
  i := 1;
  while i < dim do
  begin
    j := i + 1;
    while j <= dim do
    begin

      if elem[j] = elem[i] then
      begin

        for k := j to dim - 1 do
          elem[k] := elem[k + 1];

        dec(dim);
      end
      else
        inc(j);
    end;
    inc(i);
  end;
end;

procedure TVector.ordenarFrec();
  function contarFrecuencia(x: integer): integer;
  var
    k, cant: integer;
  begin
    cant := 0;
    for k := 1 to dim do
    begin
      if elem[k] = x then
        inc(cant);
    end;
    result := cant;
  end;

var
  i, j, aux: integer;
  frecI, frecJ: integer;
begin
  for i := 1 to dim - 1 do
  begin
    for j := i + 1 to dim do
    begin
      frecI := contarFrecuencia(elem[i]);
      frecJ := contarFrecuencia(elem[j]);

      if (frecJ > frecI) or ((frecJ = frecI) and (elem[j] < elem[i])) then
      begin
        aux := elem[i];
        elem[i] := elem[j];
        elem[j] := aux;
      end;
    end;
  end;
end;
end.

