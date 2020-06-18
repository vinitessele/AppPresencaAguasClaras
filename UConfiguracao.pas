unit UConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Permissions,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFConfiguracao = class(TFModelo)
    Layout4: TLayout;
    ActionList1: TActionList;
    ActionPhotoLibrary: TTakePhotoFromLibraryAction;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    VertScrollBox2: TVertScrollBox;
    Layout2: TLayout;
    Layout10: TLayout;
    RectangleFotoConfiguracao: TRectangle;
    RectangleConfiguracaoLibrary: TRectangle;
    CircleFotoLogo: TCircle;
    Layout11: TLayout;
    RoundRect4: TRoundRect;
    btnConfiguracao: TButton;
    Layout5: TLayout;
    EditNome: TEdit;
    Layout8: TLayout;
    EditMensagem: TEdit;
    Layout9: TLayout;
    EditTotalPontos: TEdit;
    Layout3: TLayout;
    TabControl2: TTabControl;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    ListViewFaixa: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    CircleAddFaixa: TCircle;
    Layout6: TLayout;
    Layout7: TLayout;
    EditFaixa: TEdit;
    Layout12: TLayout;
    RoundRect1: TRoundRect;
    btnConfirmarFaixa: TButton;
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure RectangleConfiguracaoLibraryClick(Sender: TObject);
    procedure ActionPhotoLibraryDidFinishTaking(Image: TBitmap);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CircleAddFaixaClick(Sender: TObject);
    procedure btnConfirmarFaixaClick(Sender: TObject);
    procedure ListViewFaixaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
{$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage: string;
    procedure LibraryPermissionRequestResult(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageLibrary(Sender: TObject;
      const APermissions: TArray<string>; const APostProc: TProc);

{$ENDIF}
  public
    { Public declarations }
    StreamImg: TStream;
  end;

var
  FConfiguracao: TFConfiguracao;

implementation

{$R *.fmx}

uses
  FMX.DialogService
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    , UDM, USobre;

{$IFDEF ANDROID}

procedure TFConfiguracao.LibraryPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 2 Permissoes: READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 2) and
    (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted) then
    ActionPhotoLibrary.Execute
  else
    TDialogService.ShowMessage('Voc� n�o tem permiss�o para acessar as fotos');
end;

procedure TFConfiguracao.DisplayMessageLibrary(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage
    ('O app precisa acessar as fotos do seu dispositivo',
    procedure(const AResult: TModalResult)
    begin
      APostProc;
    end);
end;
{$ENDIF}

procedure TFConfiguracao.ActionPhotoLibraryDidFinishTaking(Image: TBitmap);
begin
  inherited;
  CircleFotoLogo.Fill.Bitmap.Bitmap := Image;
end;

procedure TFConfiguracao.btnConfiguracaoClick(Sender: TObject);
begin
  inherited;
  if dm.FDQParametro.RecordCount > 0 then
  begin
    dm.FDQParametro.Edit;
  end
  else
  begin
    dm.FDQParametro.Append;
  end;

  dm.FDQParametroparametro_nome.AsString := EditNome.Text;
  dm.FDQParametroparametro_totalpontos.AsString := EditTotalPontos.Text;
  dm.FDQParametroparametro_premio.AsString := EditMensagem.Text;
  if StreamImg <> nil then
  begin
    CircleFotoLogo.Fill.Bitmap.Bitmap.SaveToStream(StreamImg);
    dm.FDQParametroparametro_logo.LoadFromStream(StreamImg);
  end;

  dm.FDQParametro.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Salvo com sucesso!');
  dm.FDQParametro.Close;
  dm.FDQParametro.Open();
  // Application.Terminate;
end;

procedure TFConfiguracao.btnConfirmarFaixaClick(Sender: TObject);
begin
  inherited;
  TabItem4.Enabled := False;
  TabControl2.TabIndex := 0;
  dm.FDQFaixafaixa_descricao.AsString := EditFaixa.Text;
  dm.FDQFaixa.Post;
  dm.FDConnection1.CommitRetaining;
  EditFaixa.Text := EmptyStr;
end;

procedure TFConfiguracao.CircleAddFaixaClick(Sender: TObject);
begin
  inherited;
  TabItem4.Enabled := True;
  TabControl2.TabIndex := 1;
  dm.FDQFaixa.Append;
end;

procedure TFConfiguracao.FormActivate(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  PermissaoCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  PermissaoReadStorage := JStringToString
    (TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissaoWriteStorage := JStringToString
    (TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
{$ENDIF}
end;

procedure TFConfiguracao.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQFaixa.Active := True;
  dm.FDQFaixa.Close;
  dm.FDQFaixa.Open();
  TabControl1.TabIndex := 0;
  TabControl2.TabIndex := 0;
  dm.FDQParametro.Active := True;
  dm.FDQParametro.Close;
  dm.FDQParametro.Open();
  if dm.FDQParametro.RecordCount > 0 then
  begin
    EditNome.Text := dm.FDQParametroparametro_nome.AsString;
    EditMensagem.Text := dm.FDQParametroparametro_premio.AsString;
    EditTotalPontos.Text := dm.FDQParametroparametro_totalpontos.AsString;
  end;
end;

procedure TFConfiguracao.ListViewFaixaItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  inherited;
  TabItem4.Enabled := True;
  TabControl2.TabIndex := 1;
  EditFaixa.Text := dm.FDQFaixafaixa_descricao.Text;
  dm.FDQFaixa.Edit;
end;

procedure TFConfiguracao.RectangleConfiguracaoLibraryClick(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoReadStorage,
    PermissaoWriteStorage], LibraryPermissionRequestResult,
    DisplayMessageLibrary);
{$ENDIF}
{$IFDEF IOS}
  ActionPhotoLibrary.Execute;
{$ENDIF}
end;

end.
