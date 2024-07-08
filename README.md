---
# Projeto: Prediction-Fever-Yellow

Este projeto implementa o Filtro de Kalman Estendido (EKF) para prever a densidade de vetores da febre amarela, aplicado a um modelo de Equações Diferenciais Ordinárias (EDO's).

## Descrição

O objetivo deste projeto é utilizar o Filtro de Kalman Estendido para prever a densidade de vetores da febre amarela com base em um modelo matemático de propagação da doença. O código implementa o EKF para estimar o estado não observado do sistema, utilizando dados observados e o modelo de EDO's.

## Requisitos

- MATLAB 
- Pacote de Estatísticas e Machine Learning do MATLAB (para funções relacionadas ao EKF)

## Estrutura do Código

O código está estruturado da seguinte forma:

- `datas.mat`: Arquivo que contém os dados utilizados. 
- `ekf_predict.m`: Função que implementa a predição do estado utilizando o Filtro de Kalman Estendido, nele estão os parametros utilizados no modelos, a implementação do modelo de Equações Diferenciais Ordinárias (EDO's) que descreve a propagação da febre amarela e as funções para visualização dos resultados da predição.

## Como Usar

1. Clone o repositório para o seu ambiente local.
2. Certifique-se de ter o MATLAB instalado com os pacotes necessários.
3. Execute o script `main.m` para iniciar a predição.
4. Ajuste os parâmetros do modelo de EDO's conforme necessário no arquivo `ekf_predict.m`.


## Resultados e Explicações

Para uma explicação detalhada dos resultados obtidos neste projeto, por favor, visite [link_para_explicação_dos_resultados](https://repositorio.unicamp.br/acervo/detalhe/1094051). 


## Contribuições

Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões de melhorias, sinta-se à vontade para abrir uma issue ou enviar um pull request.

## Autores

Este projeto foi desenvolvido por Fernanda Paula Rocha, sob a orientação de Mateus Giesbrecht. 

## Referência

ROCHA, Fernanda Paula. Aplicação do Filtro de Kalman Estendido para estimação de populações em modelos epidemiológicos. 2019. 1 recurso online (71 p.) Dissertação (mestrado) - Universidade Estadual de Campinas, Faculdade de Engenharia Elétrica e de Computação, Campinas, SP. Disponível em: https://hdl.handle.net/20.500.12733/1637333. Acesso em: 8 jul. 2024. 

---


