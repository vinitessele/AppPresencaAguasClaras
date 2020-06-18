program AguasClarasAppPresenca;

uses
  System.StartUpCopy,
  FMX.Forms,
  UModelo in 'UModelo.pas' {FModelo},
  uOpenViewUrl in 'uOpenViewUrl.pas',
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  USobre in 'USobre.pas' {FSobre},
  UDM in 'UDM.pas' {DM: TDataModule},
  UCadAluno in 'UCadAluno.pas' {FCadAluno},
  UConfiguracao in 'UConfiguracao.pas' {FConfiguracao},
  UCadAulas in 'UCadAulas.pas' {FAula},
  UAlunoAula in 'UAlunoAula.pas' {FAlunoAula},
  ULancamentoFalta in 'ULancamentoFalta.pas' {FLanctFalta},
  ULancMensalidade in 'ULancMensalidade.pas' {FMensalidade},
  UCustos in 'UCustos.pas' {FCustos},
  URelatorios in 'URelatorios.pas' {FRelatorios},
  UCadFaixa in 'UCadFaixa.pas' {FFaixa};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
