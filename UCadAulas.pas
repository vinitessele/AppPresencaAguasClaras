unit UCadAulas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.TabControl, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Edit, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFAula = class(TFModelo)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListViewListaAulas: TListView;
    CircleAddAulas: TCircle;
    Layout3: TLayout;
    EditAulas: TEdit;
    Layout2: TLayout;
    RoundRect3: TRoundRect;
    BtnConfirmaAula: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    StyleBook1: TStyleBook;
    procedure CircleAddAulasClick(Sender: TObject);
    procedure TabItem1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnConfirmaAulaClick(Sender: TObject);
    procedure ListViewListaAulasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAula: TFAula;

implementation

{$R *.fmx}

uses UDM;

procedure TFAula.BtnConfirmaAulaClick(Sender: TObject);
begin
  inherited;
  dm.FDQAulasAllaula_descricao.AsString := EditAulas.Text;
  dm.FDQAulasAll.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Cadastro realizado com sucesso!');
  TabItem2.Enabled := False;
  TabControl1.TabIndex := 0;
end;

procedure TFAula.CircleAddAulasClick(Sender: TObject);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  dm.FDQAulasAll.Append;
end;

procedure TFAula.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQAulasAll.Active := True;
  TabControl1.TabIndex := 0;
end;

procedure TFAula.ListViewListaAulasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  EditAulas.Text := dm.FDQAulasAllaula_descricao.AsString;
  dm.FDQAulasAll.Edit;
end;

procedure TFAula.TabItem1Click(Sender: TObject);
begin
  inherited;
  TabItem2.Enabled := False;
end;

end.
