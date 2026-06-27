-- ValidadeSafe: tabela de produtos com validade
create table if not exists public.produtos (
  id            bigint generated always as identity primary key,
  produto       text        not null,
  marca         text        not null default '',
  tipo          text        not null default '',
  data_validade date        not null,
  dias_alerta   int         not null default 7,
  criado_em     timestamptz not null default now()
);

-- Habilita Realtime para atualizações em tempo real entre dispositivos
alter publication supabase_realtime add table public.produtos;

-- Row Level Security: lista compartilhada, acesso irrestrito via anon key
alter table public.produtos enable row level security;

create policy "leitura publica"      on public.produtos for select using (true);
create policy "insercao publica"     on public.produtos for insert with check (true);
create policy "exclusao publica"     on public.produtos for delete using (true);
create policy "atualizacao publica"  on public.produtos for update using (true) with check (true);
