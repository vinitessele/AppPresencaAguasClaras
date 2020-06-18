unit UCadFaixa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListBox, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.ListView, FMX.TabControl,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFFaixa = class(TFModelo)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    ListViewFaixa: TListView;
    CircleAddAluno: TCircle;
    TabItem2: TTabItem;
    VertScrollBox2: TVertScrollBox;
    Layout2: TLayout;
    RoundRect3: TRoundRect;
    BtnConfirmaAluno: TButton;
    Layout8: TLayout;
    StyleBook1: TStyleBook;
    EditFaixa: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure ListViewFaixaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure CircleAddAlunoClick(Sender: TObject);
    procedure BtnConfirmaAlunoClick(Sender: TObject);
    procedure ListViewFaixaDeleteItem(Sender: TObject; AIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFaixa: TFFaixa;

implementation

{$R *.fmx}

uses UDM;

procedure TFFaixa.BtnConfirmaAlunoClick(Sender: TObject);
begin
  inherited;
  dm.FDQFaixafaixa_descricao.AsString := EditFaixa.Text;
  dm.FDQFaixa.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Confirmado');
  TabItem2.Enabled := False;
  TabControl1.TabIndex := 0;
end;

procedure TFFaixa.CircleAddAlunoClick(Sender: TObject);
begin
  inherited;
  dm.FDQFaixa.Append;
  EditFaixa.Text := EmptyStr;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
end;

procedure TFFaixa.ListViewFaixaDeleteItem(Sender: TObject; AIndex: Integer);
begin
  inherited;
  dm.FDQFaixa.Delete;
  dm.FDConnection1.CommitRetaining;
  dm.FDQFaixa.Close;
  dm.FDQFaixa.Open();
end;

procedure TFFaixa.ListViewFaixaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  dm.FDQFaixa.Edit;
  EditFaixa.Text := dm.FDQFaixafaixa_descricao.AsString;
end;

end.
