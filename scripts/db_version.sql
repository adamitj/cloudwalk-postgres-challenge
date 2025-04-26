CREATE TABLE IF NOT EXISTS public.dbversion(
    filename    VARCHAR(512) not null primary key,
    created_at  TIMESTAMP not null default current_timestamp
);
