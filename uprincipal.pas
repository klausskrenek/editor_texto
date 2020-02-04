unit uprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, StdCtrls, Printers;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    ColorDialogEditorTexto: TColorDialog;
    FontDialogEditorTexto: TFontDialog;
    ImageListMenu: TImageList;
    ImageListToolbar: TImageList;
    MainMenuPrincipal: TMainMenu;
    MemoTexto: TMemo;
    MenuItemSobre: TMenuItem;
    MenuItemAjuda: TMenuItem;
    MenuItemQuebrarLinha: TMenuItem;
    N4: TMenuItem;
    MenuItemAlinharCentro: TMenuItem;
    MenuItemAlinharEsquerda: TMenuItem;
    MenuItemAlinharDireita: TMenuItem;
    N3: TMenuItem;
    MenuItemCorFundo: TMenuItem;
    MenuItemCorFonte: TMenuItem;
    MenuItemFonte: TMenuItem;
    MenuItemFormatar: TMenuItem;
    MenuItemSelecionarTudo: TMenuItem;
    N2: TMenuItem;
    MenuItemColar: TMenuItem;
    MenuItemCopiar: TMenuItem;
    MenuItemRecortar: TMenuItem;
    MenuItemEditar: TMenuItem;
    MenuItemSair: TMenuItem;
    N1: TMenuItem;
    MenuItemImprimir: TMenuItem;
    MenuItemAbrir: TMenuItem;
    MenuItemSalvar: TMenuItem;
    MenuItemNovo: TMenuItem;
    MenuItemArquivo: TMenuItem;
    OpenDialogEditorTexto: TOpenDialog;
    PanelEditorTexto: TPanel;
    SaveDialogEditorTexto: TSaveDialog;
    StatusBarPrincipal: TStatusBar;
    ToolBar1: TToolBar;
    ToolButtonNovo: TToolButton;
    ToolButtonSeparador3: TToolButton;
    ToolButtonSair: TToolButton;
    ToolButtonAbrir: TToolButton;
    ToolButtonSalvar: TToolButton;
    ToolButtonSeparador1: TToolButton;
    ToolButtonImprimir: TToolButton;
    ToolButtonSeparador2: TToolButton;
    ToolButtonRecortar: TToolButton;
    ToolButtonCopiar: TToolButton;
    ToolButtonColar: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure MemoTextoChange(Sender: TObject);
    procedure MenuItemAbrirClick(Sender: TObject);
    procedure MenuItemAlinharCentroClick(Sender: TObject);
    procedure MenuItemAlinharDireitaClick(Sender: TObject);
    procedure MenuItemAlinharEsquerdaClick(Sender: TObject);
    procedure MenuItemColarClick(Sender: TObject);
    procedure MenuItemCopiarClick(Sender: TObject);
    procedure MenuItemCorFonteClick(Sender: TObject);
    procedure MenuItemCorFundoClick(Sender: TObject);
    procedure MenuItemFonteClick(Sender: TObject);
    procedure MenuItemImprimirClick(Sender: TObject);
    procedure MenuItemNovoClick(Sender: TObject);
    procedure MenuItemQuebrarLinhaClick(Sender: TObject);
    procedure MenuItemRecortarClick(Sender: TObject);
    procedure MenuItemSairClick(Sender: TObject);
    procedure MenuItemSalvarClick(Sender: TObject);
    procedure MenuItemSelecionarTudoClick(Sender: TObject);
    procedure MenuItemSobreClick(Sender: TObject);
  private

  public

  end;

var
  FormPrincipal: TFormPrincipal;
  modificado: boolean;

implementation

uses
  usobre;

{$R *.lfm}

{ TFormPrincipal }

procedure TFormPrincipal.MenuItemNovoClick(Sender: TObject);
begin
  if modificado then
  begin
    if MessageDlg('Novo', 'O Arquivo foi modificado. ' + #13 +
      'Deseja criar novo documento de texto?', mtConfirmation, mbYesNo, '') <> 6 then
      Exit;
  end;

  MemoTexto.Clear;
  StatusBarPrincipal.Panels[0].Text := 'Novo Documento';

  modificado := False;
end;

procedure TFormPrincipal.MenuItemQuebrarLinhaClick(Sender: TObject);
begin
  if MemoTexto.WordWrap then
  begin
    MemoTexto.WordWrap := False;
    MenuItemQuebrarLinha.Checked := False;
  end
  else
  begin
    MemoTexto.WordWrap := True;
    MenuItemQuebrarLinha.Checked := True;
  end;
end;

procedure TFormPrincipal.MenuItemRecortarClick(Sender: TObject);
begin
  MemoTexto.CutToClipboard;
end;

procedure TFormPrincipal.MenuItemSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.MenuItemSalvarClick(Sender: TObject);
begin
  if SaveDialogEditorTexto.Execute then
  begin
    MemoTexto.Lines.SaveToFile(SaveDialogEditorTexto.FileName);

    modificado := False;
    StatusBarPrincipal.Panels[0].Text := OpenDialogEditorTexto.FileName;
  end;

end;

procedure TFormPrincipal.MenuItemSelecionarTudoClick(Sender: TObject);
begin
  MemoTexto.SelectAll;
end;

procedure TFormPrincipal.MenuItemSobreClick(Sender: TObject);
begin
  FormSobre.ShowModal;
end;

procedure TFormPrincipal.MenuItemAbrirClick(Sender: TObject);
begin
  if modificado then
  begin
    if MessageDlg('Abrir', 'O Arquivo foi modificado. ' + #13 +
      'Deseja abrir o documento de texto?', mtConfirmation, mbYesNo, '') <> 6 then
      Exit;
  end;

  if OpenDialogEditorTexto.Execute then
  begin
    MemoTexto.Lines.LoadFromFile(OpenDialogEditorTexto.FileName);
    StatusBarPrincipal.Panels[0].Text := OpenDialogEditorTexto.FileName;

    modificado := False;
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  {$IFDEF LINUX}
  MemoTexto.Font.Name := 'Monospace';
  MemoTexto.Font.Size := 10;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  MenuItemCorFonte.Visible := False;
  MemoTexto.Font.Name := 'Courier New';
  MemoTexto.Font.Size := 10;
  {$ENDIF}
end;

procedure TFormPrincipal.MemoTextoChange(Sender: TObject);
begin
  modificado := True;
  StatusBarPrincipal.Panels[0].Text := 'Modificado';
end;

procedure TFormPrincipal.MenuItemAlinharCentroClick(Sender: TObject);
begin
  MemoTexto.Alignment := taCenter;
end;

procedure TFormPrincipal.MenuItemAlinharDireitaClick(Sender: TObject);
begin
  MemoTexto.Alignment := taRightJustify;
end;

procedure TFormPrincipal.MenuItemAlinharEsquerdaClick(Sender: TObject);
begin
  MemoTexto.Alignment := taLeftJustify;
end;

procedure TFormPrincipal.MenuItemColarClick(Sender: TObject);
begin
  MemoTexto.PasteFromClipboard;
end;

procedure TFormPrincipal.MenuItemCopiarClick(Sender: TObject);
begin
  MemoTexto.CopyToClipboard;
end;

procedure TFormPrincipal.MenuItemCorFonteClick(Sender: TObject);
begin
  ColorDialogEditorTexto.Color := MemoTexto.Font.Color;

  if ColorDialogEditorTexto.Execute then
    MemoTexto.Font.Color := ColorDialogEditorTexto.Color;
end;

procedure TFormPrincipal.MenuItemCorFundoClick(Sender: TObject);
begin
  ColorDialogEditorTexto.Color := MemoTexto.Color;

  if ColorDialogEditorTexto.Execute then
  begin
    MemoTexto.Color := ColorDialogEditorTexto.Color;
    PanelEditorTexto.Color := ColorDialogEditorTexto.Color;
  end;
end;

procedure TFormPrincipal.MenuItemFonteClick(Sender: TObject);
begin
  FontDialogEditorTexto.Font := MemoTexto.Font;

  if FontDialogEditorTexto.Execute then
    MemoTexto.Font := FontDialogEditorTexto.Font;
end;

procedure TFormPrincipal.MenuItemImprimirClick(Sender: TObject);
begin
  // TODO: Implementar a impressão.
end;

end.
