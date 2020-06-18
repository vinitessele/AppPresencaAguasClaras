unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.JSON, IOUtils, DateUtils, Data.Db,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.MultiView, FMX.Ani,
  FMX.TabControl, FMX.Layouts, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Client, REST.Types, REST.Authenticator.Basic, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.SQLite;

type
  TFPrincipal = class(TForm)
    ToolBar1: TToolBar;
    bntMenu: TSpeedButton;
    RectBarra: TRectangle;
    Image1: TImage;
    MultiView1: TMultiView;
    LabelMenu: TLabel;
    btnInf: TSpeedButton;
    RectangleMenu: TRectangle;
    Label28: TLabel;
    GradientAnimation1: TGradientAnimation;
    StyleBook1: TStyleBook;
    VertScrollBox1: TVertScrollBox;
    RectCadCliente: TRectangle;
    Circle3: TCircle;
    BtnCadCli: TButton;
    RectConfiguracao: TRectangle;
    Circle10: TCircle;
    bntConfiguracao: TButton;
    RectCustos: TRectangle;
    Circle2: TCircle;
    BtnCustos: TButton;
    LabelEmpresa: TLabel;
    LabelVersao: TLabel;
    LayoutUpdate: TLayout;
    rect_botao: TRectangle;
    btnAtualizar: TSpeedButton;
    RectUpadate: TRectangle;
    Layout2: TLayout;
    lbl_titulo: TLabel;
    lbl_texto: TLabel;
    ImageCirclo: TImage;
    img_seta: TImage;
    ImageBase: TImage;
    RectBkp: TRectangle;
    Circle12: TCircle;
    BtnBkp: TButton;
    RectRestaurar: TRectangle;
    Circle13: TCircle;
    btnRestaurar: TButton;
    LayoutLogo: TLayout;
    RectangleLogoEmpresa: TRectangle;
    RectMensalidade: TRectangle;
    Circle1: TCircle;
    bntMensalidade: TButton;
    Circle4: TCircle;
    RectCadastroAulas: TRectangle;
    Circle5: TCircle;
    btnAulas: TButton;
    RectaFaltas: TRectangle;
    Circle6: TCircle;
    btnPresenca: TButton;
    RectMatricula: TRectangle;
    Circle7: TCircle;
    BtnAlunoAula: TButton;
    RectRelatorio: TRectangle;
    Circle8: TCircle;
    btnRelatorio: TButton;
    RectFaixa: TRectangle;
    Circle9: TCircle;
    btnFaixa: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure BtnCadCliClick(Sender: TObject);
    procedure bntConfiguracaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnAtualizarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnAtualizarClick(Sender: TObject);
    procedure BtnBkpClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure btnInfClick(Sender: TObject);
    procedure btnAulasClick(Sender: TObject);
    procedure BtnAlunoAulaClick(Sender: TObject);
    procedure btnPresencaClick(Sender: TObject);
    procedure bntMensalidadeClick(Sender: TObject);
    procedure BtnCustosClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    versao_app, versao_server: string;
  public
    { Public declarations }
    procedure OnFinishUpdate(Sender: TObject);
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

uses uOpenViewUrl, UDM, USobre, UCadAluno, UConfiguracao, UCadAulas, UAlunoAula,
  ULancamentoFalta, ULancMensalidade, UCustos, URelatorios, UCadFaixa;

procedure TFPrincipal.OnFinishUpdate(Sender: TObject);
begin
  // Ocorreu algum erro na Thread...
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(Sender).FatalException).Message);
    exit;
  end;

  if versao_app < versao_server then
  begin
    // Exibe o painel de update...
    LayoutLogo.Visible := False;
    LayoutUpdate.Visible := true;
    img_seta.Position.Y := 0;
    img_seta.Opacity := 0.5;
    lbl_titulo.Opacity := 0;
    lbl_texto.Opacity := 0;
    rect_botao.Opacity := 0;

    LayoutUpdate.BringToFront;
    LayoutUpdate.AnimateFloat('Margins.Top', 0, 0.8, TAnimationType.InOut,
      TInterpolationType.Circular);

    img_seta.AnimateFloatDelay('Position.Y', 50, 0.5, 1, TAnimationType.Out,
      TInterpolationType.Back);
    img_seta.AnimateFloatDelay('Opacity', 1, 0.4, 0.9);

    lbl_titulo.AnimateFloatDelay('Opacity', 1, 0.7, 1.3);
    lbl_texto.AnimateFloatDelay('Opacity', 1, 0.7, 1.6);
    rect_botao.AnimateFloatDelay('Opacity', 1, 0.7, 1.9);
  end;

end;

procedure TFPrincipal.bntConfiguracaoClick(Sender: TObject);
begin
  if not Assigned(FConfiguracao) then
    FConfiguracao := TFConfiguracao.Create(nil);
  FConfiguracao.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.bntMensalidadeClick(Sender: TObject);
begin
  if not Assigned(FMensalidade) then
    FMensalidade := TFMensalidade.Create(nil);
  FMensalidade.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.BtnAlunoAulaClick(Sender: TObject);
begin
  if not Assigned(FAlunoAula) then
    FAlunoAula := TFAlunoAula.Create(nil);
  FAlunoAula.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnAtualizarClick(Sender: TObject);
var
  url: string;
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/drive/folders/1lXLfF-gRGKGtSkbrDO24c-iQSMeQKgiF?usp=sharing';
{$ELSE}
  url := 'https://drive.google.com/drive/folders/1lXLfF-gRGKGtSkbrDO24c-iQSMeQKgiF?usp=sharing';
{$ENDIF}
  OpenURL(url, False);
  Application.Terminate;
end;

procedure TFPrincipal.btnAtualizarMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  rect_botao.Opacity := 0.5;
end;

procedure TFPrincipal.btnAtualizarMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Single);
begin
  rect_botao.Opacity := 1;
end;

procedure TFPrincipal.btnAulasClick(Sender: TObject);
begin
  if not Assigned(FAula) then
    FAula := TFAula.Create(nil);
  FAula.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.BtnBkpClick(Sender: TObject);
var
  strPath: string;
  strDestino: string;
  AppPath: string;
  I: integer;
begin
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('C:\Users\vinic\Documents\Embarcadero\Studio\Projects\AppPresencaAguasClaras\Bd\',
    'Bd.db3');
  AppPath := IOUtils.TPath.GetHomePath;
  strDestino := IOUtils.TPath.Combine(AppPath, 'smyFile.db3');

  for I := 0 to 100 do
  begin
    Sleep(100);
  end;

  If not FileExists(strDestino) Then
  Begin
    TFile.Copy(strPath, strDestino);
  End
  else
  begin
    Sleep(2000);
    DM.FDConnection1.Connected := False;
    TFile.Delete(strDestino);
    Sleep(2000);
    TFile.Copy(strPath, strDestino);
  end;
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'Bd.db3');
  AppPath := IOUtils.TPath.GetDownloadsPath;
  strDestino := IOUtils.TPath.Combine(AppPath, 'smyFile.db3');
  for I := 0 to 100 do
  begin
    Sleep(100);
  end;
  If not FileExists(strDestino) Then
  Begin
    TFile.Copy(strPath, strDestino);
  End
  else
  begin
    Sleep(2000);
    DM.FDConnection1.Connected := False;
    TFile.Delete(strDestino);
    Sleep(2000);
    TFile.Copy(strPath, strDestino);
  end;

{$ENDIF}
end;

procedure TFPrincipal.BtnCadCliClick(Sender: TObject);
begin
  if not Assigned(FCadAluno) then
    FCadAluno := TFCadAluno.Create(nil);
  FCadAluno.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.BtnCustosClick(Sender: TObject);
begin
  if not Assigned(FCustos) then
    FCustos := TFCustos.Create(nil);
  FCustos.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnInfClick(Sender: TObject);
begin
  if not Assigned(FSobre) then
    FSobre := TFSobre.Create(nil);
  FSobre.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnPresencaClick(Sender: TObject);
begin
  if not Assigned(FLanctFalta) then
    FLanctFalta := TFLanctFalta.Create(nil);
  FLanctFalta.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnRelatorioClick(Sender: TObject);
begin
  if not Assigned(FRelatorios) then
    FRelatorios := TFRelatorios.Create(nil);
  FRelatorios.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnRestaurarClick(Sender: TObject);
begin
  if not Assigned(FFaixa) then
    FFaixa := TFFaixa.Create(nil);
  FFaixa.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
var
  vFoto: TStream;
begin
  versao_app := '1,0';
  versao_server := '0.0';
  LabelVersao.Text := 'Versão ' + versao_app;
  LayoutUpdate.Margins.Top := FPrincipal.Height + 50;
  DM.FDQParametro.Close;
  DM.FDQParametro.Open();
  // Lendo a imagem do campo BLOB para a Memória
  vFoto := DM.FDQParametro.CreateBlobStream
    (DM.FDQParametro.FieldByName('parametro_logo'), bmRead);
  if vFoto.Size > 0 then
  begin
    RectangleLogoEmpresa.Fill.Bitmap.Bitmap.LoadFromStream(vFoto);
  end;
end;

procedure TFPrincipal.FormShow(Sender: TObject);
var
  t: TThread;
begin
  t := TThread.CreateAnonymousThread(
    procedure
    var
      JsonObj: TJSONObject;
    begin
      Sleep(2000);
      try
        RESTRequest1.Execute;
      except
        on ex: Exception do
        begin
          raise Exception.Create('Erro ao acessar o servidor' + ex.Message);
          exit
        end;
      end;
      try
        JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
          (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

        versao_server := TJSONObject(JsonObj).GetValue('Versao').Value;
      finally
        JsonObj.DisposeOf;
      end;
    end);
  t.OnTerminate := OnFinishUpdate;
  t.Start;
end;

end.
