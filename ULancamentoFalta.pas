unit ULancamentoFalta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.ListBox,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Calendar,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.TabControl, FMX.DateTimeCtrls;

type
  TFLanctFalta = class(TFModelo)
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    LayoutListbox: TLayout;
    ListViewAlunos: TListView;
    VertScrollBox2: TVertScrollBox;
    LayoutPesquisaAula: TLayout;
    ComboBoxAula: TComboBox;
    btnpesquisa: TSpeedButton;
    LayoutCalendar: TLayout;
    Calendar1: TCalendar;
    Label1: TLabel;
    RoundRect3: TRoundRect;
    BtnProximo: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    Label2: TLabel;
    TabItem1: TTabItem;
    Layout2: TLayout;
    LayoutFiltro: TLayout;
    DateEdit1: TDateEdit;
    btnAjuste: TSpeedButton;
    LayoutAjuste: TLayout;
    ListViewAjuste: TListView;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    ComboBoxAulaAjuste: TComboBox;
    LinkListControlToField4: TLinkListControlToField;
    TabItem4: TTabItem;
    Layout3: TLayout;
    Label3: TLabel;
    ListViewPresenca: TListView;
    LinkListControlToField5: TLinkListControlToField;
    procedure btnpesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewAlunosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Calendar1DayClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure btnAjusteClick(Sender: TObject);
    procedure ListViewAjusteDeleteItem(Sender: TObject; AIndex: Integer);
    procedure ListViewPresencaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLanctFalta: TFLanctFalta;

implementation

{$R *.fmx}

uses UDM;

procedure TFLanctFalta.btnAjusteClick(Sender: TObject);
begin
  inherited;
  dm.FDQAulasGetDescricao.Active := True;
  dm.FDQAulasGetDescricao.Close;
  dm.FDQAulasGetDescricao.ParamByName('descricao').AsString :=
    ComboBoxAulaAjuste.Items[ComboBoxAula.ItemIndex];
  dm.FDQAulasGetDescricao.Open();

  dm.FDQAjuste.Active := True;
  dm.FDQAjuste.Close;
  dm.FDQAjuste.ParamByName('Aula').AsInteger :=
    dm.FDQAulasGetDescricaoaula_id.AsInteger;
  dm.FDQAjuste.ParamByName('data').AsDate := DateEdit1.Date;
  dm.FDQAjuste.Open();

end;

procedure TFLanctFalta.btnpesquisaClick(Sender: TObject);
begin
  inherited;
  dm.FDQAlunoMatricula.Close;
  dm.FDQAlunoMatricula.ParamByName('aula').AsString :=
    dm.FDQAulasAllaula_id.AsString;
  dm.FDQAlunoMatricula.Open();
end;

procedure TFLanctFalta.BtnProximoClick(Sender: TObject);
begin
  inherited;
  dm.FDQAlunoMatricula.Close;
  dm.FDQAlunoMatricula.ParamByName('aula').AsString :=
    dm.FDQAulasAllaula_id.AsString;
  dm.FDQAlunoMatricula.Open();
  TabItem3.Enabled := True;
  TabItem4.Enabled := True;
  TabControl1.TabIndex := 1;
end;

procedure TFLanctFalta.Calendar1DayClick(Sender: TObject);
begin
  inherited;
  dm.FDQAulasGetDescricao.Active := True;
  dm.FDQAulasGetDescricao.Close;
  dm.FDQAulasGetDescricao.ParamByName('descricao').AsString :=
    ComboBoxAula.Items[ComboBoxAula.ItemIndex];
  dm.FDQAulasGetDescricao.Open();

  MessageDlg('Aula dada?', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const BotaoPressionado: TModalResult)
    begin
      case BotaoPressionado of
        mrYes:
          begin
            // dm.FDQValidaAulasDadas.Active := True;
            // dm.FDQValidaAulasDadas.Close;
            // dm.FDQValidaAulasDadas.ParamByName('data').AsDate := Calendar1.Date;
            // dm.FDQValidaAulasDadas.ParamByName('aula').AsInteger :=
            // dm.FDQAulasGetDescricaoaula_id.AsInteger;
            // dm.FDQValidaAulasDadas.Open();

            // if dm.FDQValidaAulasDadas.RecordCount < 1 then
            // begin
            dm.fdqauladada.Active := True;

            dm.fdqauladada.Append;
            dm.FDQAulaDadaaulasdadas_date.AsDateTime := Calendar1.Date;
            if dm.FDQAlunoMatriculaalunoXaula_aula_id.AsInteger = 0 then
            begin
              dm.FDQAulaDadaaulasdadas_aula_id.AsInteger :=
                dm.FDQAulasGetDescricaoaula_id.AsInteger;
            end
            else
            begin
              dm.FDQAulaDadaaulasdadas_aula_id.AsInteger :=
                dm.FDQAlunoMatriculaalunoXaula_aula_id.AsInteger;
            end;
            dm.fdqauladada.Post;
            dm.FDConnection1.CommitRetaining;
            ShowMessage('Agora já pode inserir os alunos presentes!');
            // end
            // else
            // begin
            // ShowMessage('Aula já lançada!');
            // end;
          end;

        mrNo:
          begin
            ShowMessage('Você respondeu não');
          end;
      end;
    end);
end;

procedure TFLanctFalta.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQAlunosALL.Active := True;
  dm.FDQAulasAll.Active := True;
  dm.FDQChamada.Active := True;
  dm.FDQAulasAll.Close;
  dm.FDQAulasAll.Open();
  Calendar1.Date := Date;
  TabControl1.TabIndex := 0;
  DateEdit1.Date := Date;
end;

procedure TFLanctFalta.ListViewAjusteDeleteItem(Sender: TObject;
AIndex: Integer);
begin
  inherited;
  dm.FDQAjuste.Delete;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFLanctFalta.ListViewAlunosItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  inherited;
  dm.FDQValidaChamda.Active := True;
  dm.FDQValidaChamda.Close;
  dm.FDQValidaChamda.ParamByName('Aluno').AsInteger :=
    dm.FDQAlunoMatriculaaluno_id.AsInteger;
  dm.FDQValidaChamda.ParamByName('Aula').AsInteger :=
    dm.FDQAlunoMatriculaalunoXaula_aula_id.AsInteger;
  dm.FDQValidaChamda.ParamByName('data').AsDateTime := Calendar1.Date;
  dm.FDQValidaChamda.Open();

  if dm.FDQValidaChamda.RecordCount = 0 then
  begin
    dm.FDQChamada.Append;
    dm.FDQChamadachamada_aluno_id.AsInteger :=
      dm.FDQAlunoMatriculaaluno_id.AsInteger;
    dm.FDQChamadachamada_data.AsDateTime := Calendar1.Date;
    dm.FDQChamadachamada_hora.AsDateTime := Time;
    dm.FDQChamadachamada_aula_id.AsInteger :=
      dm.FDQAlunoMatriculaalunoXaula_aula_id.AsInteger;
    dm.FDQChamada.Post;
    dm.FDConnection1.CommitRetaining;
    ShowMessage('Falta Lançada!');
  end
  else
  begin
    ShowMessage('Falta já Lançada!');
  end;
end;

procedure TFLanctFalta.ListViewPresencaItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  inherited;
  dm.fdqpresenca.Active := True;
  dm.fdqpresenca.Append;
  dm.FDQPresencaaluno_id.AsInteger := dm.FDQAlunoMatriculaaluno_id.AsInteger;
  dm.FDQPresencadata.AsDateTime := Calendar1.Date;
  dm.FDQPresencaaula_id.AsInteger :=
    dm.FDQAlunoMatriculaalunoXaula_aula_id.AsInteger;
  dm.fdqpresenca.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('1 Presença lançada');
end;

end.
