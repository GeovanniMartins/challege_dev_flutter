## Arquitetura utilizada

Projeto desenvolvido utilizando framework Flutter seguindo padrão de **widget com divisão por responsabilidade**. Os componenetes foram separados em arquivos e pastas para facilitar a manutenção
A comunicação com a api foi encapsulada em uma camada de serviço ('StudentService'), para facilitar futura troca por outro backend.
A interface utiliza os conceitos do **Material 3** (componentes nativos flutter).
## Lista de Bibliotecas de Terceiros Utilizadas

- **[intl](https://pub.dev/packages/intl):** Para formatação de datas.
- **[mask_text_input_formatter](https://pub.dev/packages/mask_text_input_formatter):** Para máscaras de campos..
- **[http](https://pub.dev/packages/http):** Para requisições HTTP à API disponibilizada.
- **[url_launcher](https://pub.dev/packages/url_launcher):** Para abrir links externos.
- **[flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons):** Icone app.

## O que melhoraria se tivesse mais tempo

- **Ampliação dos testes**
- **Utilizar gerenciamento de estado** caso projeto cresça.
- **Sistema de login/autenticação**
- **Rotina de histórico de alterações** gravar histórico de cadastro, edição e exclusão de registros
- **Tratamento de erros**

## Quais requisitos obrigatórios que não foram entregues
- todos os requisitos sugeridos foram implementados.
