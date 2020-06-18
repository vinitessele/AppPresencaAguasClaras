unit ULancMensalidade;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.ListBox,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TFMensalidade = class(TFModelo)
    Layout2: TLayout;
    ComboBoxAula: TComboBox;
    btnpesquisa: TSpeedButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Layout3: TLayout;
    EditMensalidade: TEdit;
    EditMes: TEdit;
    Layout4: TLayout;
    ListViewAluno: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    Layout5: TLayout;
    RoundRect4: TRoundRect;
    btnConfiguracao: TButton;
    StyleBook1: TStyleBook;
    procedure btnpesquisaClick(Sender: TObject);
    procedure ListViewAlunoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMensalidade: TFMensalidade;

implementation

{$R *.fmx}

uses UDM;

procedure TFMensalidade.btnConfiguracaoClick(Sender: TObject);
begin
  inherited;
  dm.FDQAulasGetDescricao.Active := True;
  dm.FDQAulasGetDescricao.Close;
  dm.FDQAulasGetDescricao.ParamByName('descricao').AsString :=
    ComboBoxAula.Items[ComboBoxAula.ItemIndex];
  dm.FDQAulasGetDescricao.Open();

  dm.fdqvalidaMensalidade.Close;
  dm.fdqvalidaMensalidade.ParamByName('aluno').AsString :=
    dm.FDQAlunoMatriculaaluno_id.AsString;
  dm.fdqvalidaMensalidade.ParamByName('aula').AsString :=
    dm.FDQAulasGetDescricaoaula_id.AsString;
  dm.fdqvalidaMensalidade.ParamByName('competencia').AsString := EditMes.Text;
  dm.fdqvalidaMensalidade.Open();
  if dm.fdqvalidaMensalidade.RecordCount = 0 then
  begin
    dm.FDQMensalidade.Append;
    dm.FDQMensalidademensalidade_aluno_id.AsInteger :=
      dm.FDQAlunoMatriculaaluno_id.AsInteger;
    dm.FDQMensalidademensalidade_aula_id.AsInteger :=
      dm.FDQAulasGetDescricaoaula_id.AsInteger;
    dm.FDQMensalidademensalidade_valor.AsFloat :=
      StrToFloat(EditMensalidade.Text);
    dm.FDQMensalidademensalidade_data.AsDateTime := Date;
    dm.FDQMensalidademensalidade_hora.AsDateTime := Time;
    dm.FDQMensalidademensalidade_competencia.AsString := EditMes.Text;
    dm.FDQMensalidade.Post;
    dm.FDConnection1.CommitRetaining;
    ShowMessage('Mensalidade confirmada!');
  end
  else
  begin
    ShowMessage('Mensalidade já lançada');
  end;
end;

procedure TFMensalidade.btnpesquisaClick(Sender: TObject);
begin
  inherited;
  dm.FDQAlunoMatricula.Close;
  dm.FDQAlunoMatricula.ParamByName('aula').AsString :=
    dm.FDQAulasAllaula_id.AsString;
  dm.FDQAlunoMatricula.Open();
end;

procedure TFMensalidade.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQMensalidade.Active := True;
  dm.fdqvalidaMensalidade.Active := True;
  dm.FDQAulasAll.Active := True;
end;

procedure TFMensalidade.ListViewAlunoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  EditMensalidade.SetFocus;
end;

end.
