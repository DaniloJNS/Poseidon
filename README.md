# Poseidon

O Poseidon é um aplicativo de produtividade focado em gestão e rastreamento de tarefas, com assistente de priorização seguindo o sistema GTD (Getting Things Done) do `David Allen` inspirado no `org-mode` e no aplicativo open-source [Super Productive](https://github.com/super-productivity/super-productivity) sob [licença MIT](https://pt.wikipedia.org/wiki/Licen%C3%A7a_MIT).

# Funcionalidades

- Gestão de tarefas por projeto com sistema de tag e timeboxing.
- Pomodoro com tempo ajustável e possibilidade de ser vinculado a uma tarefa para o rastreamento do tempo gasto.
- Quadro estilo Kanban para acompanhamento e manipulação das tarefas.
- Calendário.
- Dashboard para visualização das tarefas concluídas por semana ou mês, tempo médio gasto, etc.

Mais funcionalidades serão desenvolvidas e apontadas nesta seção conforme o desenvolvimento do projeto.

# Entrega 1

| Documentação | Localização |
|---|---|
| UML | [`docs/modelagem.md`](docs/modelagem.md) |
| Script do banco de dados | [`priv/repo/structure.sql`](priv/repo/structure.sql), feito a partir das migrations do próprio Phoenix [`priv/repo/migrations`](priv/repo/migrations) |
| Login | `POST /api/login`, devolve um token JWT válido por 24 horas |
| CRUD da entidade Projetos | Projetos em `/api/projects` aceitando o padrão REST, é obrigatória a passagem do token JWT válido por bearer token nos headers |
| Documentação da API | Swagger UI em [`/swaggerui`](http://localhost:4000/swaggerui), a spec no formato OpenAPI está em `/api/openapi` |

## Endpoints

| Método | Rota | Autenticação | Descrição |
|---|---|---|---|
| `POST` | `/api/users` | não | Cadastro de usuário |
| `POST` | `/api/login` | não | Login |
| `GET` | `/api/projects` | Bearer | Lista os projetos que pertencem ao usuário |
| `POST` | `/api/projects` | Bearer | Cria um projeto |
| `GET` | `/api/projects/:id` | Bearer | Busca um projeto |
| `PUT`/`PATCH` | `/api/projects/:id` | Bearer | Atualiza um projeto |
| `DELETE` | `/api/projects/:id` | Bearer | Apaga um projeto |

# Como rodar

```sh
docker compose up -d   # sobe o PostgreSQL (opcional, se já tiver um local)
mix setup              # instala dependências, cria o banco, roda as migrations e a seed
mix phx.server
```

A API fica em [`localhost:4000`](http://localhost:4000) e a documentação em [`localhost:4000/swaggerui`](http://localhost:4000/swaggerui).

Usuário criado pela seed: `demo@poseidon.dev` / `poseidon123`.

Para rodar os testes use o comando abaixo:

```sh
mix test
```
