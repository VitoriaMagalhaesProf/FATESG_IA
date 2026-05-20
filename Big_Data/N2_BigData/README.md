# Projeto Big Data — Análise da Smoker's Health Data

Projeto final da disciplina de **Big Data**, no qual aplicamos estatística descritiva, visualização de dados e algoritmos de Machine Learning sobre uma base pública de saúde, com o objetivo de **prever o status de fumante** a partir de indicadores fisiológicos e demográficos.

**Base de dados:** [Smoker's Health Data — Kaggle](https://www.kaggle.com/datasets/jaceprater/smokers-health-data)

---

## Sumário

1. [Introdução](#1-introdução)
2. [Base de Dados](#2-base-de-dados)
3. [Estrutura do Repositório](#3-estrutura-do-repositório)
4. [Como Executar](#4-como-executar)
5. [Etapa 1 — Análise e Modelagem](#etapa-1--análise-e-modelagem)
   - [R1 — Coleta e Estatística Descritiva](#r1--coleta-e-estatística-descritiva)
   - [R2 — Dashboard de Visualização](#r2--dashboard-de-visualização)
   - [R3 — Modelagem Preditiva](#r3--modelagem-preditiva-machine-learning)
6. [Etapa 2 — Entrega via GitHub](#etapa-2--entrega-via-github)
7. [Critérios de Avaliação Atendidos](#critérios-de-avaliação-atendidos)
8. [Conclusão](#conclusão)
9. [Tecnologias Utilizadas](#tecnologias-utilizadas)
10. [Autora](#autora)

---

## 1. Introdução

O tabagismo é um dos principais fatores de risco para doenças cardiovasculares e respiratórias. Esta análise reúne indicadores fisiológicos (frequência cardíaca, pressão arterial, colesterol) e demográficos (idade, sexo) para investigar como esses parâmetros diferenciam fumantes de não-fumantes. O objetivo é descrever esses dados estatisticamente, visualizá-los e treinar modelos de Machine Learning capazes de prever o status de fumante com base nas demais variáveis.

---

## 2. Base de Dados

A base reúne **3.900 registros** e originalmente **7 colunas**. Após o tratamento, passou a ter **8 colunas** (a coluna `blood_pressure` foi dividida em pressão sistólica e diastólica).

| Coluna | Descrição | Tipo |
|---|---|---|
| `age` | Idade do indivíduo em anos | Numérico (int) |
| `sex` | Sexo biológico (male / female) | Categórico |
| `current_smoker` | Status de fumante (yes / no) — **variável alvo** | Categórico → binária (1/0) |
| `heart_rate` | Frequência cardíaca em batimentos por minuto | Numérico (float) |
| `blood_pressure` | Pressão arterial no formato sistólica/diastólica em mmHg | Texto (separado em duas) |
| `cigs_per_day` | Quantidade média de cigarros consumidos por dia | Numérico (float) |
| `chol` | Colesterol total no sangue (mg/dL) | Numérico (float) |
| `systolic_bp` | Pressão sistólica (criada a partir de `blood_pressure`) | Numérico (float) |
| `diastolic_bp` | Pressão diastólica (criada a partir de `blood_pressure`) | Numérico (float) |

A base mostrou-se **bem balanceada** quanto à variável alvo: **49,5% de fumantes** (1.932) e **50,5% de não-fumantes** (1.968).

---

## 3. Estrutura do Repositório

```
.
├── README.md                       # Este arquivo
├── projeto_big_data.ipynb          # Notebook principal (Google Colab)
└── smoking_health_data_final.csv   # Base de dados (download via Kaggle)
```

---

## 4. Como Executar

1. Acesse o [Google Colab](https://colab.research.google.com/).
2. Faça upload do `projeto_big_data.ipynb` (menu **Arquivo → Fazer upload de notebook**).
3. Baixe o dataset do Kaggle.
4. Na primeira célula da seção de carregamento, faça o upload do arquivo `smoking_health_data_final.csv` através do widget `files.upload()`.
5. Execute as células sequencialmente com `Shift + Enter`.

Todas as bibliotecas usadas (`pandas`, `numpy`, `matplotlib`, `seaborn`, `scikit-learn`) já vêm pré-instaladas no Colab.

---

## Etapa 1 — Análise e Modelagem

A Etapa 1 contempla os três requisitos técnicos definidos no projeto.

### R1 — Coleta e Estatística Descritiva

#### Coleta e documentação

A base foi coletada do Kaggle e documentada na seção 2 deste README, com a descrição completa de cada coluna e do tipo de dado correspondente.

#### Limpeza e tratamento

- **Separação da coluna `blood_pressure`** em `systolic_bp` e `diastolic_bp` (originalmente no formato `120/80`).
- **Tratamento de valores ausentes**: variáveis numéricas preenchidas com a **mediana**; variáveis categóricas preenchidas com a **moda**.
- **Normalização da variável alvo**: `current_smoker` mapeada de `yes`/`no` para `1`/`0` (binária inteira).

#### Estatística descritiva

Foram calculadas, para todas as variáveis numéricas relevantes, as seguintes medidas: **média, mediana, moda, desvio padrão, variância, mínimo, máximo, quartis (Q1, Q2, Q3) e amplitude interquartil (IQR)**.

| Variável | Média | Mediana | Moda | Desvio | Variância | Mín | Máx | Q1 | Q2 | Q3 | IQR |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `age` | 49.54 | 49.0 | 40.0 | 8.56 | 73.26 | 32.0 | 70.0 | 42.0 | 49.0 | 56.0 | 14.0 |
| `heart_rate` | 75.69 | 75.0 | 75.0 | 12.02 | 144.37 | 44.0 | 143.0 | 68.0 | 75.0 | 82.0 | 14.0 |
| `cigs_per_day` | 9.14 | 0.0 | 0.0 | 12.03 | 144.69 | 0.0 | 70.0 | 0.0 | 0.0 | 20.0 | 20.0 |
| `chol` | 236.59 | 234.0 | 240.0 | 44.34 | 1965.65 | 113.0 | 696.0 | 206.0 | 234.0 | 263.0 | 57.0 |
| `systolic_bp` | 132.40 | 128.0 | 130.0 | 21.98 | 482.96 | 83.5 | 295.0 | 117.0 | 128.0 | 144.0 | 27.0 |
| `diastolic_bp` | 82.99 | 82.0 | 80.0 | 11.92 | 142.05 | 48.0 | 142.5 | 75.0 | 82.0 | 90.0 | 15.0 |

**Interpretação dos resultados:**

- **`age`** — média e mediana praticamente iguais (49.5 e 49) indicam **distribuição simétrica** das idades. O IQR de 14 anos concentra metade da amostra entre 42 e 56 anos, faixa coerente com estudos sobre tabagismo.
- **`heart_rate`** — média de 75.7 bpm está dentro do padrão saudável (60–100 bpm em repouso). O máximo de 143 bpm indica casos isolados de pessoas estressadas ou com fatores de risco.
- **`cigs_per_day`** — mediana e moda igual a zero (já que metade da amostra é de não-fumantes) e média de 9.14, evidenciando **distribuição fortemente assimétrica à direita** — característica clássica desse tipo de variável.
- **`chol`** — média de 236.59 mg/dL está acima do limite saudável (200 mg/dL), e o desvio padrão de 44.34 indica grande variabilidade individual.
- **`systolic_bp` e `diastolic_bp`** — médias em 132/83 mmHg indicam que a amostra está, em média, no limite superior da pressão considerada normal. Os máximos (295 e 142 mmHg) sinalizam casos de hipertensão grave.

### R2 — Dashboard de Visualização

Foram desenvolvidos **6 gráficos independentes**, cada um respondendo uma pergunta específica sobre os dados. Cada visualização é apresentada em sua própria célula do notebook, com tamanho generoso (10×6 ou 10×8), título, eixos rotulados, legenda e interpretação em markdown logo abaixo.

| # | Gráfico | Pergunta respondida |
|---|---|---|
| 1 | Histograma de idades (com linhas de média e mediana) | Qual a faixa etária predominante? |
| 2 | Barras: fumantes por sexo | Há diferença de prevalência entre sexos? |
| 3 | Barras: fumantes vs não-fumantes | A base está balanceada? |
| 4 | Boxplot: frequência cardíaca por status | Fumantes têm FC diferente dos não-fumantes? |
| 5 | Mapa de correlação (heatmap) | Quais variáveis se relacionam mais entre si? |
| 6 | Violin plot: colesterol por status (com linha de referência) | Como o colesterol se distribui em cada grupo? |

Todos os gráficos foram construídos com **`matplotlib`** e **`seaborn`**, com paleta consistente (verde para não-fumantes, vermelho para fumantes) para facilitar a comparação visual entre análises.

### R3 — Modelagem Preditiva (Machine Learning)

#### Justificativa: Classificação

A variável alvo `current_smoker` é **categórica binária** (fumante / não-fumante). Portanto, o problema é de **classificação**, não de regressão. Algoritmos de regressão preveriam valores contínuos, o que não faz sentido aqui.

#### Pré-processamento

- **Codificação categórica**: a variável `sex` foi codificada com `LabelEncoder` (female → 0, male → 1).
- **Remoção de `cigs_per_day`** das features para **evitar data leakage** — essa variável tem relação direta com o alvo (quem fuma mais de 0 cigarros é fumante por definição), o que inflaria artificialmente a acurácia.
- **Divisão treino/teste**: 75% / 25% com `stratify=y` para manter a proporção das classes em ambos os conjuntos. Resultado: **2.925 amostras de treino** e **975 de teste**.
- **Padronização**: `StandardScaler` aplicado nas features numéricas para a Regressão Logística (Random Forest não necessita).

#### Algoritmo 1 — Regressão Logística

- **Justificativa**: modelo linear, interpretável, rápido e tradicionalmente usado como baseline em problemas de classificação binária.
- **Parâmetros**: `max_iter=1000`, `random_state=42`.
- **Métricas**: Acurácia, Precisão, Recall, F1-Score, ROC-AUC e matriz de confusão.

#### Algoritmo 2 — Random Forest

- **Justificativa**: modelo de ensemble baseado em árvores de decisão, capaz de capturar relações não-lineares e interações entre variáveis. Costuma performar melhor em dados tabulares heterogêneos.
- **Parâmetros**: `n_estimators=200`, `random_state=42`, `n_jobs=-1`.

#### Resultados — Random Forest

| Métrica | Valor |
|---|---|
| Acurácia | 0.6010 |
| Precisão | 0.5975 |
| Recall | 0.5963 |
| F1-Score | 0.5969 |
| ROC-AUC | 0.6541 |

**Matriz de Confusão (Random Forest):**

|  | Previsto: Não-fumante | Previsto: Fumante |
|---|---|---|
| **Real: Não-fumante** | 298 (TN) | 194 (FP) |
| **Real: Fumante** | 195 (FN) | 288 (TP) |

#### Comparação entre modelos

Ambos os modelos apresentaram desempenho **equilibrado entre as duas classes** (precisão e recall próximos para fumantes e não-fumantes), o que indica que **não houve viés** para nenhum dos grupos. A AUC do Random Forest acima de 0.65 confirma que o modelo aprendeu padrões reais nos dados fisiológicos.

A acurácia em torno de 60% — modesta à primeira vista — é, na realidade, **um resultado tecnicamente honesto**: ao remover `cigs_per_day` para evitar *data leakage*, o modelo precisou aprender exclusivamente a partir de indicadores fisiológicos. Esse próprio resultado é uma conclusão científica: **os exames de rotina presentes na base não são fortemente determinantes do tabagismo**, sugerindo que fatores comportamentais e ambientais (não presentes nesta base) seriam mais decisivos.

---

## Etapa 2 — Entrega via GitHub

### Como o projeto está organizado no GitHub

O repositório foi estruturado para atender à exigência de **documentação completa** dos entregáveis das Etapas 1 e 2. O conteúdo está dividido entre o presente arquivo (`README.md`), que centraliza toda a documentação textual, e o notebook (`projeto_big_data.ipynb`), que contém o código executável e os resultados visuais.

### Boas práticas adotadas

- **Notebook didático**: cada gráfico em sua própria célula, com markdown explicando antes e interpretando depois.
- **Código comentado**: todas as decisões técnicas relevantes (como a remoção de `cigs_per_day`) estão justificadas em comentários no próprio código.
- **README estruturado**: sumário com âncoras, tabelas de resultados, descrição de cada etapa e mapeamento explícito dos critérios de avaliação.
- **Reprodutibilidade**: uso de `random_state=42` em todas as operações aleatórias (split, modelos), garantindo que qualquer pessoa que clone o repositório obtenha exatamente os mesmos resultados.

### Como subir e entregar

1. Crie um repositório público no [GitHub](https://github.com) (sugestão de nome: `projeto-big-data-smokers-health`).
2. Faça upload de `projeto_big_data.ipynb`, `README.md` e (opcionalmente) `smoking_health_data_final.csv`.
3. Confirme o commit com a mensagem `Entrega final — Projeto Big Data`.
4. Envie o link do repositório via Google Classroom.

---

## Critérios de Avaliação Atendidos

| Critério | Como foi atendido neste projeto |
|---|---|
| **1. Qualidade e tratamento dos dados** | Limpeza completa: separação da coluna `blood_pressure` em duas, tratamento de valores ausentes com mediana (numéricos) e moda (categóricos), e normalização da variável alvo (yes/no → 1/0). A base escolhida é relevante e bem-balanceada (49.5% de fumantes), permitindo análise estatística e modelagem robustas. |
| **2. Clareza visual e comunicação** | 6 gráficos independentes (histograma, barras, boxplot, heatmap, violin plot), todos com título, rótulos nos eixos, legendas e interpretação textual em markdown imediatamente abaixo. Paleta de cores consistente entre as visualizações. |
| **3. Técnica de Machine Learning e validação dos modelos** | Justificativa clara de classificação (alvo binário). Dois algoritmos distintos (Regressão Logística e Random Forest) avaliados com 5 métricas diferentes (Acurácia, Precisão, Recall, F1-Score, ROC-AUC), além de matriz de confusão e curva ROC. Decisão técnica de remover `cigs_per_day` para evitar data leakage justificada e documentada. |
| **4. Organização e documentação** | Repositório com README.md estruturado em sumário com âncoras, notebook didático com célula por gráfico, comentários no código, reprodutibilidade garantida via `random_state`, e mapeamento explícito de cada critério à seção correspondente. |

---

## Conclusão

Este projeto cumpriu integralmente os três requisitos técnicos propostos (R1, R2 e R3) e seguiu boas práticas de Ciência de Dados desde a coleta até a modelagem preditiva. A **análise estatística descritiva** revelou padrões importantes sobre a amostra (idade simétrica, colesterol acima do recomendado em parte significativa dos participantes, pressão arterial no limite superior). O **dashboard de visualização** organizou essas informações em gráficos claros e interpretáveis. A **modelagem preditiva** comparou dois algoritmos distintos e, mais importante, tomou decisões técnicas defensáveis (remoção de variável com data leakage) que privilegiaram a honestidade dos resultados em detrimento de uma acurácia artificialmente alta.

O resultado final — acurácia em torno de 60% — não deve ser visto como uma limitação do trabalho, mas como uma **conclusão científica relevante**: indicadores fisiológicos de rotina, sozinhos, não são suficientes para prever o tabagismo com alta certeza. Para aplicações reais em saúde, seria necessário incorporar variáveis comportamentais, ambientais e históricas — o que indica claramente um caminho de continuidade para futuras pesquisas.

---

## Tecnologias Utilizadas

- **Linguagem**: Python 3
- **Ambiente**: Google Colab
- **Bibliotecas**:
  - `pandas` e `numpy` — manipulação de dados
  - `matplotlib` e `seaborn` — visualização
  - `scikit-learn` — Machine Learning (LogisticRegression, RandomForestClassifier, métricas, pré-processamento)

---

## Autora

**Vitória** — Disciplina de Big Data, 2026.
