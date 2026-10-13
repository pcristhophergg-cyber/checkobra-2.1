-- CheckObra 2.4 - Biblioteca del Saber
-- Ejecutar con respaldo previo en Supabase SQL Editor. No borra datos.
begin;
create table if not exists public.knowledge_articles (
 id uuid primary key default gen_random_uuid(),
 title text not null, category text not null, summary text not null, content text not null,
 source_title text not null, source_revision text, published boolean not null default false,
 created_by uuid references auth.users(id), created_at timestamptz not null default now()
);
create table if not exists public.knowledge_questions (
 id uuid primary key default gen_random_uuid(), question text not null, context text,
 created_by uuid not null references auth.users(id), created_at timestamptz not null default now(),
 status text not null default 'Pendiente' check(status in ('Pendiente','Respondida')),
 answer text, source_reference text, answered_by uuid references auth.users(id), answered_at timestamptz
);
alter table public.knowledge_articles enable row level security;
alter table public.knowledge_questions enable row level security;
grant select on public.knowledge_articles to authenticated;
grant select,insert,update on public.knowledge_questions to authenticated;
grant insert on public.knowledge_articles to authenticated;
-- Las políticas se crean solamente si no existen; no se alteran políticas existentes.
do $$ begin
 if not exists(select 1 from pg_policies where schemaname='public' and tablename='knowledge_articles' and policyname='knowledge_articles_read') then
  create policy knowledge_articles_read on public.knowledge_articles for select to authenticated using (published = true or public.my_role() in ('jefatura','calidad','oficina_tecnica'));
 end if;
 if not exists(select 1 from pg_policies where schemaname='public' and tablename='knowledge_articles' and policyname='knowledge_articles_write') then
  create policy knowledge_articles_write on public.knowledge_articles for insert to authenticated with check (public.my_role() in ('jefatura','calidad','oficina_tecnica') and created_by=auth.uid() and length(trim(source_title))>0);
 end if;
 if not exists(select 1 from pg_policies where schemaname='public' and tablename='knowledge_questions' and policyname='knowledge_questions_read') then
  create policy knowledge_questions_read on public.knowledge_questions for select to authenticated using (created_by=auth.uid() or public.my_role() in ('jefatura','calidad','oficina_tecnica'));
 end if;
 if not exists(select 1 from pg_policies where schemaname='public' and tablename='knowledge_questions' and policyname='knowledge_questions_insert') then
  create policy knowledge_questions_insert on public.knowledge_questions for insert to authenticated with check (created_by=auth.uid() and status='Pendiente' and answer is null and answered_by is null);
 end if;
 if not exists(select 1 from pg_policies where schemaname='public' and tablename='knowledge_questions' and policyname='knowledge_questions_update') then
  create policy knowledge_questions_update on public.knowledge_questions for update to authenticated using (public.my_role() in ('jefatura','calidad','oficina_tecnica')) with check (public.my_role() in ('jefatura','calidad','oficina_tecnica') and (status <> 'Respondida' or (length(trim(coalesce(source_reference,'')))>0 and answered_by=auth.uid())));
 end if;
end $$;
commit;
