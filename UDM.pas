unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQAlunosALL: TFDQuery;
    FDQParametro: TFDQuery;
    FDQParametroparametro_nome: TStringField;
    FDQParametroparametro_logo: TBlobField;
    FDQParametroparametro_login: TStringField;
    FDQParametroparametro_totalpontos: TIntegerField;
    FDQParametroparametro_premio: TStringField;
    FDQParametroparametro_senha: TStringField;
    FDQAulasAll: TFDQuery;
    FDQAulasAllaula_id: TFDAutoIncField;
    FDQAulasAllaula_descricao: TStringField;
    FDQMatricula: TFDQuery;
    FDQMatriculaaluno_id: TFDAutoIncField;
    FDQMatriculaaluno_cpf: TStringField;
    FDQMatriculaaluno_nome: TStringField;
    FDQMatriculaaluno_celular: TStringField;
    FDQMatriculaaluno_email: TStringField;
    FDQMatriculaaluno_observacao: TStringField;
    FDQMatriculaaluno_img: TBlobField;
    FDQAlunoXAulaAll: TFDQuery;
    FDQAlunoXAulaAllalunoXaula_id: TFDAutoIncField;
    FDQAlunoXAulaAllalunoXaula_aluno_id: TIntegerField;
    FDQAlunoXAulaAllalunoXaula_aula_id: TIntegerField;
    FDQAlunoMatricula: TFDQuery;
    FDQAlunoMatriculaaluno_id: TFDAutoIncField;
    FDQAlunoMatriculaaluno_cpf: TStringField;
    FDQAlunoMatriculaaluno_nome: TStringField;
    FDQAlunoMatriculaaluno_celular: TStringField;
    FDQAlunoMatriculaaluno_email: TStringField;
    FDQAlunoMatriculaaluno_observacao: TStringField;
    FDQAlunoMatriculaaluno_img: TBlobField;
    FDQAlunoMatriculaalunoXaula_id: TIntegerField;
    FDQAlunoMatriculaalunoXaula_aluno_id: TIntegerField;
    FDQAlunoMatriculaalunoXaula_aula_id: TIntegerField;
    FDQChamada: TFDQuery;
    FDQChamadachamada_id: TFDAutoIncField;
    FDQChamadachamada_aluno_id: TIntegerField;
    FDQChamadachamada_aula_id: TIntegerField;
    FDQChamadachamada_data: TDateField;
    FDQChamadachamada_hora: TTimeField;
    FDQValidaChamda: TFDQuery;
    FDQValidaChamdachamada_id: TFDAutoIncField;
    FDQValidaChamdachamada_aluno_id: TIntegerField;
    FDQValidaChamdachamada_aula_id: TIntegerField;
    FDQValidaChamdachamada_data: TDateField;
    FDQValidaChamdachamada_hora: TTimeField;
    FDQMensalidade: TFDQuery;
    FDQMensalidademensalidade_id: TFDAutoIncField;
    FDQMensalidademensalidade_aluno_id: TIntegerField;
    FDQMensalidademensalidade_aula_id: TIntegerField;
    FDQMensalidademensalidade_data: TDateField;
    FDQMensalidademensalidade_hora: TTimeField;
    FDQMensalidademensalidade_competencia: TWideStringField;
    FDQMensalidademensalidade_valor: TWideStringField;
    FDQValidaMensalidade: TFDQuery;
    FDAutoIncField1: TFDAutoIncField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    DateField1: TDateField;
    TimeField1: TTimeField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    FDQCustos: TFDQuery;
    FDQCustoscustofixo_id: TFDAutoIncField;
    FDQCustoscustofixo_descricao: TStringField;
    FDQCustoscustofixo_valor: TFMTBCDField;
    FDQCustoscustofixo_rateio: TStringField;
    FDQCustoscustofixo_tipo: TStringField;
    FDQAulaDada: TFDQuery;
    FDQAulaDadaaulasdadas_id: TFDAutoIncField;
    FDQAulaDadaaulasdadas_date: TDateField;
    FDQAulaDadaaulasdadas_aula_id: TIntegerField;
    FDQValidaAulasDadas: TFDQuery;
    FDQValidaAulasDadasaulasdadas_id: TFDAutoIncField;
    FDQValidaAulasDadasaulasdadas_date: TDateField;
    FDQValidaAulasDadasaulasdadas_aula_id: TIntegerField;
    FDQAulasGetDescricao: TFDQuery;
    FDQAulasGetDescricaoaula_id: TFDAutoIncField;
    FDQAulasGetDescricaoaula_descricao: TStringField;
    FDQCountAulas: TFDQuery;
    FDQCountAulasqteAulas: TLargeintField;
    FDQListFaltasPorAluno: TFDQuery;
    FDQListFaltasPorAlunochamada_id: TFDAutoIncField;
    FDQListFaltasPorAlunochamada_aluno_id: TIntegerField;
    FDQListFaltasPorAlunochamada_aula_id: TIntegerField;
    FDQListFaltasPorAlunochamada_data: TDateField;
    FDQListFaltasPorAlunochamada_hora: TTimeField;
    FDQListMensalidade: TFDQuery;
    FDQListMensalidadevalor: TWideStringField;
    FDQListMensalidadealuno_nome: TStringField;
    FDQListMensPorAluno: TFDQuery;
    FDQListMensPorAlunovalor: TWideStringField;
    FDQListMensPorAlunoaluno_nome: TStringField;
    FDQListMensPorAlunomensalidade_data: TDateField;
    FDQListMensPorAlunomensalidade_competencia: TWideStringField;
    FDQListMensalidadealuno_id: TFDAutoIncField;
    FDQAjuste: TFDQuery;
    FDQAjustealuno_nome: TStringField;
    FDQAjustechamada_data: TDateField;
    FDQAjustechamada_id: TFDAutoIncField;
    FDQAlunosALLaluno_id: TFDAutoIncField;
    FDQAlunosALLaluno_cpf: TStringField;
    FDQAlunosALLaluno_nome: TStringField;
    FDQAlunosALLaluno_celular: TStringField;
    FDQAlunosALLaluno_email: TStringField;
    FDQAlunosALLaluno_observacao: TStringField;
    FDQAlunosALLaluno_img: TBlobField;
    FDQFaixa: TFDQuery;
    FDQFaixafaixa_id: TFDAutoIncField;
    FDQFaixafaixa_descricao: TStringField;
    FDQPresenca: TFDQuery;
    FDQPresencapresenca_id: TFDAutoIncField;
    FDQPresencaaluno_id: TIntegerField;
    FDQPresencadata: TDateField;
    FDQPresencaaula_id: TIntegerField;
    FDQFalta: TFDQuery;
    FDQFaltafalta: TWideStringField;
    FDQFaltachamada_aluno_id: TIntegerField;
    FDQFaltaaluno_nome: TStringField;
    FDQAlunosALLdt_nascimento: TStringField;
    FDQAlunosALLpeso: TLargeintField;
    FDQAlunosALLaltrua: TLargeintField;
    FDQAlunosALLfaixa: TStringField;
    FDQAlunosALLstatus: TStringField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin

  strSQL := //
    ' CREATE TABLE IF NOT EXISTS parametro( ' + //
    ' parametro_nome varchar(60),   ' + //
    ' parametro_logo blob,          ' + //
    ' parametro_login varchar(100), ' + //
    ' parametro_totalpontos integer,' + //
    ' parametro_premio varchar(100),' + //
    ' parametro_senha varchar(10))  ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS aulasdadas(  ' + //
    ' aulasdadas_id integer not null primary key autoincrement,' + //
    ' aulasdadas_date date,' + //
    ' aulasdadas_aula_id integer) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS custofixo(    ' + //
    ' custofixo_id integer not null primary key autoincrement,   ' + //
    ' custofixo_descricao varchar(50),    ' + //
    ' custofixo_valor numeric(4,8),   ' + //
    ' custofixo_rateio varchar(10),   ' + //
    ' custofixo_tipo varchar(10))  ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS aluno(   ' + //
    ' aluno_id integer not null primary key autoincrement, ' + //
    ' aluno_cpf varchar(11),       ' + //
    ' aluno_nome varchar(60),   ' + //
    ' aluno_celular varchar(12),   ' + //
    ' aluno_email varchar(100),    ' + //
    ' aluno_observacao varchar(200),  ' + //
    ' dt_nascimento varchar(10),  ' + //
    ' peso decimal ,  ' + //
    ' altrua decimal, ' + //
    ' faixa varchar(15),' + //
    ' status char(1), ' + //
    ' aluno_img blob) ';
  FDConnection1.ExecSQL(strSQL);
  // 'alter table aluno add dt_nascimento varchar(10);
  // 'alter table aluno add peso decimal;
  // 'alter table aluno add altrua decimal;
  // 'alter table aluno add faixa varchar(15);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS faixa(' + //
    ' faixa_id integer not null primary key autoincrement,' + //
    ' faixa_descricao varchar(15))';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS aula( ' + //
    ' aula_id integer not null primary key autoincrement,' + //
    ' aula_descricao varchar(20))';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS chamada(  ' + //
    ' chamada_id integer not null primary key autoincrement, ' + //
    ' chamada_aluno_id integer not null, ' + //
    ' chamada_aula_id integer not null, ' + //
    ' chamada_data date,      ' + //
    ' chamada_hora time) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS mensalidade(   ' + //
    ' mensalidade_id integer not null primary key autoincrement,' + //
    ' mensalidade_aluno_id integer not null,   ' + //
    ' mensalidade_aula_id integer not null,  ' + //
    ' mensalidade_data date,          ' + //
    ' mensalidade_hora time,     ' + //
    ' mensalidade_competencia,     ' + //
    ' mensalidade_valor) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS custofixo(  ' + //
    ' custofixo_id integer not null primary key autoincrement, ' + //
    ' custofixo_descricao varchar(50),  ' + //
    ' custofixo_valor numeric(4,8),  ' + //
    ' custofixo_rateio varchar(10),  ' + //
    ' custofixo_tipo varchar(10)) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS parametro( ' + //
    ' parametro_nome varchar(60),' + //
    ' parametro_logo blob,       ' + //
    ' parametro_login varchar(100),' + //
    ' parametro_totalpontos integer, ' + //
    ' parametro_premio varchar(100), ' + //
    ' parametro_senha varchar(10)) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS alunoXaula ( ' + //
    ' alunoXaula_id integer not null primary key autoincrement,' + //
    ' alunoXaula_aluno_id integer, ' + //
    ' alunoXaula_aula_id integer, ' + //
    ' foreign key (alunoXaula_aluno_id) references aluno(aluno_id),' + //
    ' foreign key (alunoXaula_aula_id) references aula(aula_id)) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := //
    ' create table IF NOT EXISTS presenca( ' + //
    ' presenca_id integer not null primary key autoincrement,' + //
    ' aluno_id integer,' + //
    ' data date,' + //
    ' aula_id integer) ';
  FDConnection1.ExecSQL(strSQL);

end;

procedure TDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('C:\Users\vinic\Documents\Embarcadero\Studio\Projects\AppPresencaAguasClaras\Bd\',
    'Bd.db3');
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'Bd.db3');
{$ENDIF}
  FDConnection1.Params.Values['DATABASE'] := strPath;
end;

end.
