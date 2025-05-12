enum Operacao{
  add('Somar', '+'),
  sub('Subtrair', '-'),
  div('Dividir', '÷'),
  mult('Multiplicar', 'x'),
  perc('Porcentagem', '%'),
  apagar('Apagar', 'back'),
  limpar('Limpar', 'clear'),
  igual('Resultado', '='),
  virgula('Virgula', '.'),
  maismenos('Negativo/Positivo', '+/-');


  final String nome;
  final String op;
  const Operacao(this.nome, this.op);
}