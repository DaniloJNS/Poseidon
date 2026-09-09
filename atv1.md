# 1. Quais tabelas você definiu inicialmente?

- `users` para armazenamento das informações básicas e autenticação dos usuarios.
- `users_auth` para armazenamento dos dados sensíveis dos usuarios.
- `tasks` para armazenamento das principais informações das tarefas.
- `projects` para armazenamento das informações dos projectos.
- `tags` para armazena as tags das tarefas.
- `tags_tasks` para o armazenar o mapeamento N:N entre tabela de tags e de tasks.

# 2. Você utilizou migrations? Se sim, quantas migrations? Descreva em uma frase o que cada uma faz.

Sim, utilizei migrations. É um padrão que gosto muito para promover alterações na estrutura de banco de forma reproduzível e relativamente confiável.

- `priv/repo/migrations/20260908005529_create_users.exs` Cria a tabela de usuarios
- `priv/repo/migrations/20260908004724_create_tasks.exs` Cria a tabela de tarefas
- `priv/repo/migrations/20260909001736_create_projects.exs` Cria a tabela de projetos
- `priv/repo/migrations/20260909005530_create_tags.exs` Cria a tabela de tags
- `priv/repo/migrations/20260909005727_create_task_tags.exs` Cria a tabela intermediária de mapeamento N:N entre tabela de tasks e de tags com um unique index.


# 3. Qual é o caminho do arquivo que gera a seed do seu banco?

Path do arquivo de seeds `priv/repo/seeds.exs` que é criado automaticamente pelo Phoenix em todo novo projeto.

# 4. Quais os endpoints que você irá implementar inicialmente?

- O endpoint para página de login: GET `/users/auth`
- O endpoint de autenticação: POST `/users/auth`
- O endpoint da página de kanban para exibição das tarefas: GET `/tasks`
- O endpoint de criação de projetos: POST `/projects`
- O endpoint de criação de tags: POST `/tags`


# 5. Você está usando algum framework para escrever os endpoints da sua API? Se sim, qual?
Sim, o framework mais popular da comunidade Elixir, o Phoenix.
