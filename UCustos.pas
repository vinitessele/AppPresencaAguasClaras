unit UCustos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFCustos = class(TFModelo)
    Layout2: TLayout;
    EditDescricao: TEdit;
    EditValor: TEdit;
    ComboBoxTipo: TComboBox;
    Layout3: TLayout;
    Layout4: TLayout;
    ListViewCustos: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    RoundRect4: TRoundRect;
    btnConfiguracao: TButton;
    StyleBook1: TStyleBook;
    procedure FormShow(Sender: TObject);
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure ListViewCustosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCustos: TFCustos;

implementation

{$R *.fmx}

uses UDM;

procedure TFCustos.btnConfiguracaoClick(Sender: TObject);
begin
  inherited;
  dm.FDQCustos.Append;
  dm.FDQCustoscustofixo_descricao.AsString := EditDescricao.Text;
  dm.FDQCustoscustofixo_valor.Text := EditValor.Text;
  dm.FDQCustoscustofixo_tipo.Text := ComboBoxTipo.Items[ComboBoxTipo.ItemIndex];
  dm.FDQCustos.Post;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFCustos.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQCustos.Active := True;
end;

procedure TFCustos.ListViewCustosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  dm.FDQCustos.Edit;
  dm.FDQCustoscustofixo_descricao.AsString := EditDescricao.Text;
  dm.FDQCustoscustofixo_valor.Text := EditValor.Text;
  dm.FDQCustoscustofixo_tipo.Text := ComboBoxTipo.Items[ComboBoxTipo.ItemIndex];
  dm.FDQCustos.Post;
  dm.FDConnection1.CommitRetaining;
end;

end.
