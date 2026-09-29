unit uventana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, uvector;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    BUSQBIN: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    CARGAR: TButton;
    Label2: TLabel;
    ORDINTER: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    POS: TEdit;
    ELE: TEdit;
    Label1: TLabel;
    SG: TStringGrid;
    procedure BUSQBINClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure CARGARClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ORDINTERClick(Sender: TObject);
  private
     V:TVector;
     procedure updateSG();
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  V:=TVector.crear();
  updateSG();
  showMessage('Vector inicializado...');
end;

procedure TForm1.BUSQBINClick(Sender: TObject);
var                                          //boton busqBin
  posE:integer;
begin
  posE:= V.busqBin(StrToInt(ELE.Text));
  POS.Text:=IntToStr(posE);
  ELE.Text:='';
  SG.row:=0;
  SG.Col:=posE-1;
  SG.SetFocus;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  updateSG();
  ShowMessage('Vector actual: ' + V.comoString());
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  ShowMessage('Vector en String: ' + V.comoString());
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  if V.getDim() > 0 then
  begin
    V.invertir();
    updateSG(); // Refresca el StringGrid para que veas los cambios al instante
  end
  else
    ShowMessage('El vector está vacío. Carga o adiciona elementos primero.');
end;

procedure TForm1.Button13Click(Sender: TObject);
  begin
  if V.getDim() > 0 then
  begin
    V.rotarDerecha();
    updateSG();
  end
  else
    ShowMessage('El vector está vacío.');
end;

procedure TForm1.Button14Click(Sender: TObject);
  begin
    if V.getDim() > 0 then
    begin
      V.rotarIzquierda();
      updateSG();
    end
    else
      ShowMessage('El vector está vacío.');
  end;

procedure TForm1.Button15Click(Sender: TObject);
  var
  elemBuscado, posEncontrada: integer;
begin
  if ELE.Text <> '' then
  begin
    elemBuscado := StrToInt(ELE.Text);
    posEncontrada := V.busqSec(elemBuscado);

    if posEncontrada <> -1 then
    begin
      POS.Text := IntToStr(posEncontrada);
      ShowMessage('Elemento ' + IntToStr(elemBuscado) + ' encontrado en la posición: ' + IntToStr(posEncontrada));
    end
    else
      ShowMessage('El elemento ' + IntToStr(elemBuscado) + ' no existe en el vector.');
  end
  else
    ShowMessage('Ingresa el elemento a buscar en la casilla ELE.');
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  V.ordBurbuja();
  updateSG();
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  V.ordSeleccion();
  updateSG();
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  V.ordInsercion();
  updateSG();
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
  V.ordQuickSort();
  updateSG();
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  V.ordShell();
  updateSG();
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  if V.getDim() > 0 then
  begin
    V.eliminarRep();
    updateSG(); // Actualiza la grilla StringGrid
  end
  else
    ShowMessage('El vector está vacío.');
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  if V.getDim() > 0 then
  begin
    V.ordenarFrec();
    updateSG(); // Actualiza la grilla StringGrid
  end
  else
    ShowMessage('El vector está vacío.');
end;

procedure TForm1.CARGARClick(Sender: TObject);
var
  cant: integer;
begin
  if POS.Text <> '' then
  begin
    cant := StrToInt(POS.Text);

    V.cargar(cant, 1, 100);
    updateSG();

    POS.Text := '';
    ShowMessage('Vector cargado con ' + IntToStr(cant) + ' elementos aleatorios.');
  end
  else
    ShowMessage('Ingresa la cantidad de elementos en la casilla Posicion.');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  V.setDim(StrToInt(POS.Text));
  updateSG();
  POS.Text:='';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  POS.Text:=IntToStr(V.getDim());
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  V.setElem(strToInt(POS.Text),StrToInt(ELE.Text));
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ELE.Text:=IntToStr(V.getElem(StrToInt(POS.Text)));
  POS.Text:='';
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  V.addElem(StrToInt(ELE.Text));
  updateSG();
  ELE.Text:='';
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  V.insElem(strToInt(POS.Text),StrToInt(ELE.Text));
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  V.remElem(StrToInt(POS.Text));
  updateSG();
  POS.Text:='';
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  close();
end;

procedure TForm1.ORDINTERClick(Sender: TObject);
begin
  V.ord_inter();     //boton ordinter
  updateSG();
end;

procedure TForm1.updateSG();
var
  des:integer;
begin
  SG.ColCount:=V.getDim();
  for des:=1 to V.getDim() do
     SG.Cells[des-1,0]:=IntToStr(V.getElem(des));
end;

end.

