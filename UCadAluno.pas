unit UCadAluno;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Data.db, Permissions, DateUtils,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.TabControl,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.Edit, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.ScrollBox, FMX.Memo, FMX.ListBox;

type
  TFCadAluno = class(TFModelo)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    VertScrollBox2: TVertScrollBox;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    EditCpfCliente: TEdit;
    EditNomeCliente: TEdit;
    Layout5: TLayout;
    EditCelular: TEdit;
    Layout6: TLayout;
    EditEmail: TEdit;
    Layout7: TLayout;
    Rectangle2: TRectangle;
    RoundRect3: TRoundRect;
    BtnConfirmaAluno: TButton;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    ActionPhotoLibrary: TTakePhotoFromLibraryAction;
    CircleFotoCliente: TCircle;
    ListViewCliente: TListView;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    CircleAddAluno: TCircle;
    BindSourceDB1: TBindSourceDB;
    Layout8: TLayout;
    Memo1: TMemo;
    Layout9: TLayout;
    EditPeso: TEdit;
    Layout10: TLayout;
    Layout11: TLayout;
    EditDtNascimento: TEdit;
    Layout12: TLayout;
    EditAltura: TEdit;
    LabelIdade: TLabel;
    ComboBoxFaixa: TComboBox;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    procedure FormShow(Sender: TObject);
    procedure CircleAddAlunoClick(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure BtnConfirmaAlunoClick(Sender: TObject);
    procedure ListViewClienteDeleteItem(Sender: TObject; AIndex: Integer);
    procedure ListViewClienteItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ActionPhotoLibraryDidFinishTaking(Image: TBitmap);
    procedure FormActivate(Sender: TObject);
    procedure TabItem1Click(Sender: TObject);
    procedure EditDtNascimentoExit(Sender: TObject);
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
    procedure CalcNascimento;
  end;

var
  FCadAluno: TFCadAluno;

implementation

{$R *.fmx}

uses UDM, FMX.DialogService

{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    , UConfiguracao;
{$IFDEF ANDROID}

procedure TFCadAluno.LibraryPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 2 Permissoes: READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 2) and
    (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted) then
    ActionPhotoLibrary.Execute
  else
    TDialogService.ShowMessage('Você não tem permissão para acessar as fotos');
end;

procedure TFCadAluno.DisplayMessageLibrary(Sender: TObject;
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

procedure TFCadAluno.ActionPhotoLibraryDidFinishTaking(Image: TBitmap);
begin
  inherited;
  CircleFotoCliente.Fill.Bitmap.Bitmap := Image;
end;

procedure TFCadAluno.BtnConfirmaAlunoClick(Sender: TObject);
begin
  inherited;
  If not(dm.FDQAlunosALL.State in [dsEdit, dsInsert]) then
  begin
    dm.FDQAlunosALL.Append;
  end;
  dm.FDQAlunosALLAluno_cpf.AsString := EditCpfCliente.Text;
  dm.FDQAlunosALLAluno_nome.AsString := EditNomeCliente.Text;
  dm.FDQAlunosALLAluno_celular.AsString := EditCelular.Text;
  dm.FDQAlunosALLAluno_email.AsString := EditEmail.Text;
  StreamImg := TMemoryStream.Create;
  CircleFotoCliente.Fill.Bitmap.Bitmap.SaveToStream(StreamImg);
  dm.FDQAlunosALLAluno_img.LoadFromStream(StreamImg);
  dm.FDQAlunosALLaluno_observacao.AsString := Memo1.Text;
  // dm.FDQClientecliente_img.Assign(CircleFotoCliente.Fill.Bitmap.Bitmap);
  dm.FDQAlunosALLpeso.AsString := EditPeso.Text;
  dm.FDQAlunosALLaltrua.AsString := EditAltura.Text;
  dm.FDQAlunosALLdt_nascimento.AsString := EditDtNascimento.Text;
  dm.FDQAlunosALLfaixa.AsString := ComboBoxFaixa.Items[ComboBoxFaixa.ItemIndex];
  dm.FDQAlunosALL.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Salvo com sucesso!');
  dm.FDQAlunosALL.Close;
  dm.FDQAlunosALL.Open();
  TabControl1.TabIndex := 0;
  EditCpfCliente.Text := EmptyStr;
  EditNomeCliente.Text := EmptyStr;
  EditCelular.Text := EmptyStr;
  EditEmail.Text := EmptyStr;
  Memo1.Text := EmptyStr;
  TabItem2.Enabled := False;
end;

procedure TFCadAluno.CircleAddAlunoClick(Sender: TObject);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  EditCpfCliente.Text := EmptyStr;
  EditNomeCliente.Text := EmptyStr;
  EditCelular.Text := EmptyStr;
  EditEmail.Text := EmptyStr;
  EditPeso.Text := EmptyStr;
  EditDtNascimento.Text := EmptyStr;
  EditAltura.Text := EmptyStr;
  LabelIdade.Text := EmptyStr;
  Memo1.Text := EmptyStr;
  dm.FDQAlunosALL.Append;
end;

procedure TFCadAluno.EditDtNascimentoExit(Sender: TObject);
begin
  inherited;
  CalcNascimento;
end;

procedure TFCadAluno.CalcNascimento;
begin
  if EditDtNascimento.Text <> EmptyStr then
  begin
    LabelIdade.Text := IntToStr(DateUtils.YearsBetween(date,
      StrToDate(EditDtNascimento.Text)));
  end;
end;

procedure TFCadAluno.FormActivate(Sender: TObject);
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

procedure TFCadAluno.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQAlunosALL.Active := True;
  dm.FDQAlunosALL.Close;
  dm.FDQAlunosALL.Open();
  dm.FDQFaixa.Active := True;
  dm.FDQFaixa.Close;
  dm.FDQFaixa.Open();
  TabControl1.TabIndex := 0;
end;

procedure TFCadAluno.ListViewClienteDeleteItem(Sender: TObject;
AIndex: Integer);
var
  sql: string;
begin
  inherited;
  try
    sql := 'delete from aluno where aluno_id = ' +
      dm.FDQAlunosALLaluno_id.AsString;
    dm.FDConnection1.ExecSQL(sql);
    dm.FDConnection1.CommitRetaining;
    ShowMessage('Excluido com sucesso!');
  Except
    ShowMessage('Impossível excluir aluno com lançamento!');
  end;
end;

procedure TFCadAluno.ListViewClienteItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  dm.FDQAlunosALL.Edit;
  EditCpfCliente.Text := dm.FDQAlunosALLAluno_cpf.AsString;
  EditNomeCliente.Text := dm.FDQAlunosALLAluno_nome.AsString;
  EditCelular.Text := dm.FDQAlunosALLAluno_celular.AsString;
  EditEmail.Text := dm.FDQAlunosALLAluno_email.AsString;
  EditPeso.Text := dm.FDQAlunosALLpeso.AsString;
  EditAltura.Text := dm.FDQAlunosALLaltrua.AsString;
  EditDtNascimento.Text := dm.FDQAlunosALLdt_nascimento.AsString;
  CalcNascimento;
  ComboBoxFaixa.Items.IndexOf(dm.FDQAlunosALLfaixa.AsString);
  Memo1.Text := dm.FDQAlunosALLaluno_observacao.AsString;
  CalcNascimento;
  ComboBoxFaixa.ItemIndex := ComboBoxFaixa.Items.IndexOf
    (dm.FDQAlunosALLfaixa.AsString);
end;

procedure TFCadAluno.Rectangle2Click(Sender: TObject);
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

procedure TFCadAluno.TabItem1Click(Sender: TObject);
begin
  inherited;
  TabItem2.Enabled := False;
end;

end.
