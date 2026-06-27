-- Schema isolado para o ValidadeSafe dentro deste banco
create schema if not exists validadesafe;

-- Permissões para o role anon (usado pelo Supabase client no frontend)
grant usage on schema validadesafe to anon, authenticated;

-- Tabela de produtos
create table if not exists validadesafe.produtos (
  id            bigint generated always as identity primary key,
  produto       text        not null,
  marca         text        not null default '',
  tipo          text        not null default '',
  data_validade date        not null,
  dias_alerta   int         not null default 7,
  criado_em     timestamptz not null default now()
);

-- Permissões na tabela e sequences
grant all on validadesafe.produtos to anon, authenticated;
grant usage, select on all sequences in schema validadesafe to anon, authenticated;

-- Row Level Security: lista compartilhada entre todos os dispositivos
alter table validadesafe.produtos enable row level security;

create policy "leitura publica"     on validadesafe.produtos for select using (true);
create policy "insercao publica"    on validadesafe.produtos for insert with check (true);
create policy "exclusao publica"    on validadesafe.produtos for delete using (true);
create policy "atualizacao publica" on validadesafe.produtos for update using (true) with check (true);

-- Habilita Realtime para sincronização entre dispositivos
alter publication supabase_realtime add table validadesafe.produtos;
