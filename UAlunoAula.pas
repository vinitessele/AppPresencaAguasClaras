unit UAlunoAula;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.ListBox,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TFAlunoAula = class(TFModelo)
    LayoutPesquisaAula: TLayout;
    ComboBoxAula: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LayoutAlunos: TLayout;
    ListViewAlunos: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    btnpesquisa: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnpesquisaClick(Sender: TObject);
    procedure ListViewAlunosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAlunoAula: TFAlunoAula;

implementation

{$R *.fmx}

uses UDM, UPrincipal;

procedure TFAlunoAula.btnpesquisaClick(Sender: TObject);
begin
  inherited;
  dm.FDQMatricula.Close;
  dm.FDQMatricula.ParamByName('aula').AsString :=
    dm.FDQAulasAllaula_id.AsString;
  dm.FDQMatricula.Open();
end;

procedure TFAlunoAula.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQAlunosALL.Active := True;
  dm.FDQAulasAll.Active := True;
  dm.FDQAulasAll.Close;
  dm.FDQAulasAll.Open();
  dm.FDQMatricula.Active := True;
  dm.FDQMatricula.Close;
  dm.FDQMatricula.Open();
  dm.FDQAlunoXAulaAll.Active := True;

end;

procedure TFAlunoAula.ListViewAlunosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  dm.FDQAlunoXAulaAll.Append;
  dm.FDQAlunoXAulaAllalunoXaula_aluno_id.AsInteger :=
    dm.FDQMatriculaaluno_id.AsInteger;
  dm.FDQAlunoXAulaAllalunoXaula_aula_id.AsInteger :=
    dm.FDQAulasAllaula_id.AsInteger;
  dm.FDQAlunoXAulaAll.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Salvo com sucesso!');
  dm.FDQMatricula.Close;
  dm.FDQMatricula.Open();
end;

end.
