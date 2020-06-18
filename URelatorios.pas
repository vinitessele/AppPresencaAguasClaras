unit URelatorios;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.TabControl, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ListBox, FMX.DateTimeCtrls, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Ani, FMX.Edit,
  MultiDetailAppearanceU;

type
  TFRelatorios = class(TFModelo)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    LayoutFiltrosFaltas: TLayout;
    LayoutFiltrosMensalidade: TLayout;
    LayoutDetalhes: TLayout;
    LayoutDetalhesmensalidade: TLayout;
    ComboBoxAula: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    RoundRect3: TRoundRect;
    BtnPesquisa: TButton;
    ComboBox1: TComboBox;
    RoundRect1: TRoundRect;
    btnPesquisaMensalidade: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkListControlToField2: TLinkListControlToField;
    LabelAulas: TLabel;
    ListViewFaltas: TListView;
    EditCompetencia: TEdit;
    LayoutDetalheMensalidadeAluno: TLayout;
    ListViewListMensalidade: TListView;
    BtnSair: TButton;
    BindSourceDB5: TBindSourceDB;
    LinkListControlToField6: TLinkListControlToField;
    StyleBook1: TStyleBook;
    LayoutDetalhesFaltas: TLayout;
    FloatAnimation1: TFloatAnimation;
    btnFechar: TSpeedButton;
    ListViewDetalhasFaltas: TListView;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField4: TLinkListControlToField;
    FloatAnimation2: TFloatAnimation;
    ListViewMensalidade: TListView;
    BindSourceDB4: TBindSourceDB;
    LinkListControlToField5: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    procedure FormShow(Sender: TObject);
    procedure BtnPesquisaClick(Sender: TObject);
    procedure btnPesquisaMensalidadeClick(Sender: TObject);
    procedure ListViewFaltasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure btnfecharClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure ListViewMensalidadeItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelatorios: TFRelatorios;

implementation

{$R *.fmx}

uses UDM;

procedure TFRelatorios.btnfecharClick(Sender: TObject);
begin
  inherited;
  FloatAnimation1.Inverse := True;
  FloatAnimation1.Start;
  LayoutDetalhesFaltas.Visible := False;
end;

procedure TFRelatorios.BtnPesquisaClick(Sender: TObject);
begin
  inherited;
  dm.FDQAulasGetDescricao.Active := True;
  dm.FDQAulasGetDescricao.Close;
  dm.FDQAulasGetDescricao.ParamByName('descricao').AsString :=
    ComboBoxAula.Items[ComboBoxAula.ItemIndex];
  dm.FDQAulasGetDescricao.Open();

  dm.FDQCountAulas.Active := True;
  dm.FDQCountAulas.Close;
  dm.FDQCountAulas.ParamByName('dataIni').AsDate := DateEdit1.Date;
  dm.FDQCountAulas.ParamByName('dataFim').AsDate := DateEdit2.Date;
  dm.FDQCountAulas.ParamByName('aula').AsInteger :=
    dm.FDQAulasGetDescricaoaula_id.AsInteger;
  dm.FDQCountAulas.Open();
  LabelAulas.Text := 'Aulas: ' + IntToStr(dm.FDQCountAulasqteAulas.AsInteger);

  dm.FDQFalta.Active := True;
  dm.FDQFalta.Close;
  dm.FDQFalta.ParamByName('dataIni').AsDate := DateEdit1.Date;
  dm.FDQFalta.ParamByName('dataFim').AsDate := DateEdit2.Date;
  dm.FDQFalta.ParamByName('Aula').AsInteger :=
    dm.FDQAulasGetDescricaoaula_id.AsInteger;
  dm.FDQFalta.Open();

end;

procedure TFRelatorios.btnPesquisaMensalidadeClick(Sender: TObject);
begin
  inherited;
  dm.FDQAulasGetDescricao.Active := True;
  dm.FDQAulasGetDescricao.Close;
  dm.FDQAulasGetDescricao.ParamByName('descricao').AsString :=
    ComboBoxAula.Items[ComboBoxAula.ItemIndex];
  dm.FDQAulasGetDescricao.Open();

  dm.FDQListMensalidade.Active;
  dm.FDQListMensalidade.Close;
  dm.FDQListMensalidade.ParamByName('Aula').AsInteger :=
    dm.FDQAulasGetDescricaoaula_id.AsInteger;
  dm.FDQListMensalidade.ParamByName('competencia').AsString :=
    EditCompetencia.Text;
  dm.FDQListMensalidade.Open();

end;

procedure TFRelatorios.BtnSairClick(Sender: TObject);
begin
  inherited;
  LayoutDetalheMensalidadeAluno.Visible := False;
end;

procedure TFRelatorios.FloatAnimation1Finish(Sender: TObject);
begin
  inherited;
  if FloatAnimation1.Inverse = True then
    LayoutDetalhesFaltas.Visible := False;
end;

procedure TFRelatorios.FloatAnimation2Finish(Sender: TObject);
begin
  inherited;
  if FloatAnimation2.Inverse = True then
    LayoutDetalheMensalidadeAluno.Visible := False;
end;

procedure TFRelatorios.FormCreate(Sender: TObject);
begin
  inherited;
  LayoutDetalheMensalidadeAluno.Visible := False;
end;

procedure TFRelatorios.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQAulasAll.Active := True;
  dm.FDQAulasAll.Close;
  dm.FDQAulasAll.Open();
  TabControl1.TabIndex := 0;
  DateEdit1.Date := Date - 90;
  DateEdit2.Date := Date;
  LayoutDetalhesFaltas.Visible := False;
  // PanelDatas.Margins.Top := FRelatorios.Height + 50;

end;

procedure TFRelatorios.ListViewFaltasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  LayoutDetalhesFaltas.Position.Y := FRelatorios.Height + 20;
  LayoutDetalhesFaltas.Visible := True;
  FloatAnimation1.Inverse := False;
  FloatAnimation1.StartValue := FRelatorios.Height + 20;
  FloatAnimation1.StopValue := 0;
  FloatAnimation1.Start;

  dm.FDQListFaltasPorAluno.Active := True;
  dm.FDQListFaltasPorAluno.Close;
  dm.FDQListFaltasPorAluno.ParamByName('aluno').AsInteger :=
    dm.FDQFaltachamada_aluno_id.AsInteger;
  dm.FDQListFaltasPorAluno.Open();

end;

procedure TFRelatorios.ListViewMensalidadeItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  LayoutDetalheMensalidadeAluno.Position.Y := FRelatorios.Height + 20;
  LayoutDetalheMensalidadeAluno.Visible := True;
  FloatAnimation2.Inverse := False;
  FloatAnimation2.StartValue := FRelatorios.Height + 20;
  FloatAnimation2.StopValue := 0;
  FloatAnimation2.Start;
  dm.FDQListMensPorAluno.Active := True;
  dm.FDQListMensPorAluno.Close;
  dm.FDQListMensPorAluno.ParamByName('Aula').AsInteger :=
    dm.FDQAulasGetDescricaoaula_id.AsInteger;
  dm.FDQListMensPorAluno.ParamByName('Aluno').AsInteger :=
    dm.FDQListMensalidadealuno_id.AsInteger;
  dm.FDQListMensPorAluno.Open();
end;

end.

