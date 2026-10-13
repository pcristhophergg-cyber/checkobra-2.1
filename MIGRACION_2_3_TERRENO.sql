begin;
-- CheckObra 2.3: correcciones de terreno y frentes; NO modifica excel_status original.
create table if not exists public.field_status (
 trade_id uuid not null references public.trades(id),
 unit_id text not null references public.units(id),
 status text not null check(status in ('Ejecutado','En proceso','Con observaciones','Sin ejecutar')),
 room text not null default '',
 source text not null default 'Registro aplicación',
 updated_by uuid references auth.users(id),
 updated_at timestamptz not null default now(),
 primary key(trade_id,unit_id,room)
);
alter table public.field_status enable row level security;
do $$ begin if not exists(select 1 from pg_policies where schemaname='public' and tablename='field_status' and policyname='field_status_read') then create policy field_status_read on public.field_status for select to authenticated using(public.my_role() is not null); end if; end $$;
do $$ begin if not exists(select 1 from pg_policies where schemaname='public' and tablename='field_status' and policyname='field_status_write') then create policy field_status_write on public.field_status for all to authenticated using(public.is_manager() or exists(select 1 from public.trades t where t.id=trade_id and t.owner_id=auth.uid())) with check(public.is_manager() or exists(select 1 from public.trades t where t.id=trade_id and t.owner_id=auth.uid())); end if; end $$;
grant select,insert,update on public.field_status to authenticated;
create table if not exists public.front_status (
 id bigint generated always as identity primary key,
 front text not null check(front in ('Cubierta','Fachada')),
 zone text not null,
 activity text not null,
 status text not null check(status in ('Ejecutado','En proceso','Con observaciones','Pendiente')),
 detail text,
 source text not null default 'Informe de terreno',
 updated_by uuid references auth.users(id),
 updated_at timestamptz not null default now(),
 unique(front,zone,activity)
);
alter table public.front_status enable row level security;
do $$ begin if not exists(select 1 from pg_policies where schemaname='public' and tablename='front_status' and policyname='front_status_read') then create policy front_status_read on public.front_status for select to authenticated using(public.my_role() is not null); end if; end $$;
do $$ begin if not exists(select 1 from pg_policies where schemaname='public' and tablename='front_status' and policyname='front_status_write') then create policy front_status_write on public.front_status for all to authenticated using(public.is_manager()) with check(public.is_manager()); end if; end $$;
grant select,insert,update on public.front_status to authenticated;
-- Confirmación expresa del jefe de terreno: todos los departamentos desde piso 2 hasta el indicado.
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='SHAFT Y  VIGONES' and u.floor between 2 and 15 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='PREP DE SUPERFICIE' and u.floor between 2 and 8 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='COCINA BASE' and u.floor between 2 and 7 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='INTERIOR CLOSET' and u.floor between 2 and 7 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='PIERNAS CLOSET' and u.floor between 2 and 7 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='CERAMICO DE TERRAZAS' and u.floor between 2 and 12 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.field_status(trade_id,unit_id,status,source) select t.id,u.id,'Ejecutado','Confirmación terreno 2026-10-12' from public.trades t cross join public.units u where t.name='CORNISAS' and u.floor between 2 and 11 on conflict(trade_id,unit_id,room) do update set status=excluded.status,source=excluded.source,updated_at=now() where public.field_status.source='Confirmación terreno 2026-10-12';
insert into public.front_status(front,zone,activity,status,detail) values('Cubierta','Tramo 1','Instalación de cerchas','Ejecutado','Último hito ejecutado confirmado; actividades anteriores no verificadas individualmente') on conflict(front,zone,activity) do nothing;
insert into public.front_status(front,zone,activity,status,detail) values('Cubierta','Tramo 3','Aplicación Igol denso','Ejecutado','Último hito ejecutado confirmado; verificar Igol Primer') on conflict(front,zone,activity) do nothing;
insert into public.front_status(front,zone,activity,status,detail) values('Cubierta','Tramo 2','Impermeabilización','Pendiente','Pendiente confirmado') on conflict(front,zone,activity) do nothing;
insert into public.front_status(front,zone,activity,status,detail) values('Cubierta','Tramo 2','Instalación de cerámicos','Pendiente','Pendiente confirmado') on conflict(front,zone,activity) do nothing;
commit;
