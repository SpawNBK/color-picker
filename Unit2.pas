unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Clipbrd, ShellApi, Menus, ImgList, Buttons;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    Edit1: TEdit;
    Label2: TLabel;
    ColorDialog1: TColorDialog;
    Bevel1: TBevel;
    Label3: TLabel;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ImageList1: TImageList;
    SpeedButton1: TSpeedButton;
    Image2: TImage;
    Image4: TImage;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    img3: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  cancl:boolean;
  colorshow:boolean;
  colorflash:integer;

implementation

{$R *.dfm}
Function GetPix: Cardinal;
Var
Dc: HDC;
Cp: TPoint;
Pix: Cardinal;
Begin
Dc:=GetDC(0);
GetCursorPos(Cp);
Pix:=GetPixel(Dc,Cp.X,Cp.Y);
ReleaseDC(0,Dc);
GetPix:=Pix;
End;

procedure pickAndCopy;
var
str:string;
str2:string;
begin
str:=IntToHex(GetPix,1);
str2:=inttostr(GetPix);
form2.edit1.Text:=str;
form2.Image1.Width:=41;
form2.Image1.Height:=35;
form2.Image1.Picture.Bitmap.Width:=41;
form2.Image1.Picture.Bitmap.Height:=35;
form2.Image1.Picture.Bitmap.Canvas.Brush.Color:=strtoint(str2);
form2.Image1.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,35));
Clipboard.AsText:='#'+form2.edit1.Text;
//перемещаем 2 на 3
    form2.Edit4.Text:=form2.edit3.Text;
    form2.Image4.Width:=41;
    form2.Image4.Height:=17;
    form2.Image4.Picture.Bitmap.Width:=41;
    form2.Image4.Picture.Bitmap.Height:=17;
    form2.Image4.Picture.Bitmap.Canvas.Brush.Color:=form2.Img3.Picture.Bitmap.Canvas.Brush.Color;
    form2.Image4.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,17));
//перемещаем 1 на 2
    form2.Edit3.Text:=form2.edit2.Text;
    form2.Img3.Width:=41;
    form2.Img3.Height:=17;
    form2.Img3.Picture.Bitmap.Width:=41;
    form2.Img3.Picture.Bitmap.Height:=17;
    form2.Img3.Picture.Bitmap.Canvas.Brush.Color:=form2.Image2.Picture.Bitmap.Canvas.Brush.Color;
    form2.Img3.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,17));
//Заполняем 1-й
    form2.Edit2.Text:=form2.edit1.Text;
    form2.Image2.Width:=41;
    form2.Image2.Height:=17;
    form2.Image2.Picture.Bitmap.Width:=41;
    form2.Image2.Picture.Bitmap.Height:=17;
    form2.Image2.Picture.Bitmap.Canvas.Brush.Color:=strtoint(str2);
    form2.Image2.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,17));
{colorflash:=colorflash+1;
if colorflash>3 then
 colorflash:=1;
case colorflash of
  1: begin
    form2.Edit2.Text:=form2.edit1.Text;
    form2.Image2.Width:=41;
    form2.Image2.Height:=17;
    form2.Image2.Picture.Bitmap.Width:=41;
    form2.Image2.Picture.Bitmap.Height:=17;
    form2.Image2.Picture.Bitmap.Canvas.Brush.Color:=strtoint(str2);
    form2.Image2.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,17));
    exit;
  end;
 2: begin
    form2.Edit3.Text:=form2.edit1.Text;
    form2.Img3.Width:=41;
    form2.Img3.Height:=17;
    form2.Img3.Picture.Bitmap.Width:=41;
    form2.Img3.Picture.Bitmap.Height:=17;
    form2.Img3.Picture.Bitmap.Canvas.Brush.Color:=strtoint(str2);
    form2.Img3.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,17));
  end;
  3: begin
    form2.Edit4.Text:=form2.edit1.Text;
    form2.Image4.Width:=41;
    form2.Image4.Height:=17;
    form2.Image4.Picture.Bitmap.Width:=41;
    form2.Image4.Picture.Bitmap.Height:=17;
    form2.Image4.Picture.Bitmap.Canvas.Brush.Color:=strtoint(str2);
    form2.Image4.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,17));
  end;
end;   }
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if cancl=false then
begin
 form2.Hide;
 canclose:=false;
end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
cancl:=false;
SpeedButton1.Caption:='последние'+#13#10+'цвета';
colorshow:=false;
colorflash:=0;
end;

procedure TForm2.Image1Click(Sender: TObject);
var
str:string;
begin
if colordialog1.Execute then
 begin
 form2.Image1.Width:=41;
 form2.Image1.Height:=35;
 form2.Image1.Picture.Bitmap.Width:=41;
 form2.Image1.Picture.Bitmap.Height:=35;
 form2.Image1.Picture.Bitmap.Canvas.Brush.Color:=colordialog1.Color;
 form2.Image1.Picture.Bitmap.Canvas.FillRect(Rect(0,0,41,35));
 str:=IntToHex(colordialog1.Color,1);
 edit1.Text:=str;
 Clipboard.AsText:='#'+form2.edit1.Text;
 end;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
form2.Show;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
cancl:=true;
application.Terminate;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
if colorshow=false then
  begin
    form2.Width:=497;
    Image1.Width:=41;
    Image1.Height:=35;
    Bevel1.Width:=41;
    Bevel1.Height:=35;
    colorshow:=true;
  end
  else
  begin
    form2.Width:=253;
    Image1.Width:=41;
    Image1.Height:=35;
    Bevel1.Width:=41;
    Bevel1.Height:=35;
    colorshow:=false;
  end;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
Clipboard.AsText:='#'+form2.edit2.Text;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
Clipboard.AsText:='#'+form2.edit3.Text;
end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
Clipboard.AsText:='#'+form2.edit4.Text;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
if (getasynckeystate($11)) AND (getasynckeystate($53))<>0 then
begin
form2.Show;
form2.SetFocus;
pickAndCopy;
sleep(100);
end;
end;

end.
