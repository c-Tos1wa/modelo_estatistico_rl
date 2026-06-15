# Projeto 1 - Identificar fatores de risco associados a casos graves de Covid-19

1. Objetivo
Como analista de dados em uma secretaria de saúde, investigou-se, dentre os pacientes com covid-19, quais de suas características podem estar associadas 
a casos graves da doença.

2. Metodologia
Usando a biblioteca Tidyverse, criou-se um conjunto de 500 indivíduos, descrevendo suas idades, sexo, chances de ter diabetes, hipertensão e/ou obesidade.
Para cada um deles, foi dado um "peso probabilístico" dos indivíduos possuírem estas doenças e ser do sexo masculino.
Fez-se uma comparação da média de indivíduos que possuem tais características e depois criou-se um modelo de regressão logística, com a biblioteca Survival, para determinar a importância
de cada fator sobre o aumento de risco.
Visualizou-se os resultados com o Forest Plot e Ggplot para mostrar o gráfico.

3. Resultados
Dentre os 500 indivíduos, 34,6% são de casos graves.
Comparando as estatísticas de cada grupo, nos casos graves, a idade média é de 57,4 anos; a proporção masculina é de 53,8; e das características dos pacientes, 
aqueles com diabetes, hipertensão e obesidade são 23,1, 37,6 e 31,2, respectivamente.
Após a aplicação do modelo de regressão logística, o resultado é melhor observado em um gráfico representado pelo Forest Plot.
<img src="C:\Users\crist\Desktop\r_dados\curso-analise-de-dados-main\casos">

4. Discussão e Conclusão
A análise de dados e do gráfico Forest Plot mostra que, dos indivíduos com casos graves de covid-19, os do sexo masculino e diabéticos, são as 
características que estão mais associadas a ser um caso grave. A idade, a hipertensão e a obesidade também são fatores preocupantes e, por isso,
recomenda-se a ampliação da vacinação para pessoas idosas e monitoramento dessas comorbidades.

5. Bibliotecas utilizadas
- [tidyverse](https://tidyverse.org/)
- [broom](https://broom.tidymodels.org/)
- [survival](https://cran.r-project.org/web/packages/survival/index.html)

6. Autor(a/es)
Este caso foi retirado do curso "Análise de dados" do [campus Virtual da Fiocruz](https://cursosqualificacao.campusvirtual.fiocruz.br/) e editado por [Cristina T. Iwassaki](https://www.linkedin.com/in/cristina-iwassaki/).

